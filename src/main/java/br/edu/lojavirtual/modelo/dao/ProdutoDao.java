package br.edu.lojavirtual.modelo.dao;

import br.edu.lojavirtual.modelo.entidade.Produto;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class ProdutoDao extends GenericoDAO<Produto> {

    /**
     * INSERT - Insere novo produto
     * ATENÇÃO: nota_media NÃO é inserida aqui!
     * A trigger tri_nota_media_produto calcula ela automaticamente
     * quando uma avaliação é cadastrada.
     */
    public void salvar(Produto produto) {
        String sql = "INSERT INTO produtos(nome, descricao, preco, estoque, peso, categorias_id_categoria, marcas_id_marca) "
                + "VALUES(?, ?, ?, ?, ?, ?, ?)";
        save(sql, produto.getNome(), produto.getDescricao(), produto.getPreco(),
                produto.getEstoque(), produto.getPeso(),
                produto.getCategoriasIdCategoria(), produto.getMarcasIdMarca());
    }

    /**
     * UPDATE - Atualiza produto existente
     */
    public void alterar(Produto produto) {
        String sql = "UPDATE produtos SET nome=?, descricao=?, preco=?, estoque=?, peso=?, "
                + "categorias_id_categoria=?, marcas_id_marca=? WHERE id_produto=?";
        save(sql, produto.getNome(), produto.getDescricao(), produto.getPreco(),
                produto.getEstoque(), produto.getPeso(),
                produto.getCategoriasIdCategoria(), produto.getMarcasIdMarca(),
                produto.getIdProduto());
    }

    /**
     * DELETE - Remove produto
     * ATENÇÃO: produtos tem MUITAS tabelas dependentes (itens_pedido, avaliacoes,
     * estoque, produtos_has_fornecedores) - é bem provável dar erro de FK aqui!
     */
    public boolean excluir(Produto produto) {
        String sql = "DELETE FROM produtos WHERE id_produto=?";
        try {
            save(sql, produto.getIdProduto());
            return true;
        } catch (Exception e) {
            System.err.println("ERRO ao excluir produto: " + e.getMessage());
            return false;
        }
    }

    /**
     * RowMapper - converte cada linha do ResultSet em um objeto Produto
     * ATENÇÃO: mapeia também nome_categoria e nome_marca, que só existem
     * por causa do JOIN feito nas consultas abaixo
     */
    private static class ProdutoRowMapper implements RowMapper<Produto> {

        @Override
        public Produto mapRow(ResultSet rs) throws SQLException {
            Produto produto = new Produto();

            produto.setIdProduto(rs.getInt("id_produto"));
            produto.setNome(rs.getString("nome"));
            produto.setDescricao(rs.getString("descricao"));
            produto.setPreco(rs.getDouble("preco"));
            produto.setEstoque(rs.getInt("estoque"));
            produto.setPeso(rs.getDouble("peso"));
            produto.setNotaMedia(rs.getDouble("nota_media"));
            produto.setCategoriasIdCategoria(rs.getInt("categorias_id_categoria"));
            produto.setMarcasIdMarca(rs.getInt("marcas_id_marca"));

            // Campos vindos do JOIN - só existem nesta consulta específica
            produto.setNomeCategoria(rs.getString("nome_categoria"));
            produto.setNomeMarca(rs.getString("nome_marca"));

            System.out.println("Mapeando produto: " + produto.toString());

            return produto;
        }
    }

    /**
     * SELECT ALL com JOIN - busca todos os produtos já trazendo o
     * nome da categoria e da marca, em vez de só o ID
     */
    public List<Produto> buscarTodosProdutos() {
        String sql = "SELECT p.*, c.nome AS nome_categoria, m.nome AS nome_marca "
                + "FROM produtos p "
                + "JOIN categorias c ON p.categorias_id_categoria = c.id_categoria "
                + "JOIN marcas m ON p.marcas_id_marca = m.id_marca "
                + "ORDER BY p.nome";
        return buscarTodos(sql, new ProdutoRowMapper());
    }

    /**
     * SELECT BY ID com JOIN - usado, por exemplo, ao carregar um produto
     * específico para alteração
     */
    public Produto buscarProdutoPorId(int id) {
        String sql = "SELECT p.*, c.nome AS nome_categoria, m.nome AS nome_marca "
                + "FROM produtos p "
                + "JOIN categorias c ON p.categorias_id_categoria = c.id_categoria "
                + "JOIN marcas m ON p.marcas_id_marca = m.id_marca "
                + "WHERE p.id_produto = ?";
        return buscarPorId(sql, new ProdutoRowMapper(), id);
    }
}