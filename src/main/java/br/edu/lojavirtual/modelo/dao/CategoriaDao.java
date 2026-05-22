package br.edu.lojavirtual.modelo.dao;

import br.edu.lojavirtual.modelo.entidade.Categoria;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class CategoriaDao extends GenericoDAO<Categoria> {
    
    public void salvar(Categoria categoria) {
        String sql = "INSERT INTO categorias(nome, descricao) VALUES(?, ?)";
        save(sql, categoria.getNome(), categoria.getDescricao());
    }
    
    public void alterar(Categoria categoria) {
        String sql = "UPDATE categorias SET nome=?, descricao=? WHERE id_categoria=?";
        save(sql, categoria.getNome(), categoria.getDescricao(), categoria.getIdCategoria());
    }
    
    public boolean excluir(Categoria categoria) {
        String sql = "DELETE FROM categorias WHERE id_categoria=?";
        try {
            save(sql, categoria.getIdCategoria());
            return true;
        } catch (Exception e) {
            System.err.println("ERRO ao excluir categoria: " + e.getMessage());
            return false;
        }
    }
    
    private static class CategoriaRowMapper implements RowMapper<Categoria> {
        
        @Override
        public Categoria mapRow(ResultSet rs) throws SQLException {
            Categoria categoria = new Categoria();
            categoria.setIdCategoria(rs.getInt("id_categoria"));
            categoria.setNome(rs.getString("nome"));
            categoria.setDescricao(rs.getString("descricao"));
            
            System.out.println("Mapeando categoria: " + categoria.toString());
            
            return categoria;
        }
    }
    
    public List<Categoria> buscarTodasCategorias() {
        String sql = "SELECT * FROM categorias ORDER BY nome";
        return buscarTodos(sql, new CategoriaRowMapper());
    }
    
    public Categoria buscarCategoriaPorId(int id) {
        String sql = "SELECT * FROM categorias WHERE id_categoria = ?";
        return buscarPorId(sql, new CategoriaRowMapper(), id);
    }
}