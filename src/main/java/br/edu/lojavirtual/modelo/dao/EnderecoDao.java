package br.edu.lojavirtual.modelo.dao;

import br.edu.lojavirtual.modelo.entidade.Endereco;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class EnderecoDao extends GenericoDAO<Endereco> {

    /**
     * INSERT - Insere novo endereço
     */
    public void salvar(Endereco endereco) {
        String sql = "INSERT INTO enderecos(cep, rua, numero, bairro, cidade, estado, clientes_id_cliente) "
                + "VALUES(?, ?, ?, ?, ?, ?, ?)";
        save(sql, endereco.getCep(), endereco.getRua(), endereco.getNumero(),
                endereco.getBairro(), endereco.getCidade(), endereco.getEstado(),
                endereco.getClientesIdCliente());
    }

    /**
     * UPDATE - Atualiza endereço existente
     */
    public void alterar(Endereco endereco) {
        String sql = "UPDATE enderecos SET cep=?, rua=?, numero=?, bairro=?, cidade=?, estado=?, "
                + "clientes_id_cliente=? WHERE id_endereco=?";
        save(sql, endereco.getCep(), endereco.getRua(), endereco.getNumero(),
                endereco.getBairro(), endereco.getCidade(), endereco.getEstado(),
                endereco.getClientesIdCliente(), endereco.getIdEndereco());
    }

    /**
     * DELETE - Remove endereço
     * ATENÇÃO: enderecos é referenciado por pedidos (fk_pedidos_enderecos1)
     * Se o endereço já tiver pedidos associados, a exclusão vai falhar por FK
     */
    public boolean excluir(Endereco endereco) {
        String sql = "DELETE FROM enderecos WHERE id_endereco=?";
        try {
            save(sql, endereco.getIdEndereco());
            return true;
        } catch (Exception e) {
            System.err.println("ERRO ao excluir endereco: " + e.getMessage());
            return false;
        }
    }

    /**
     * RowMapper - converte cada linha do ResultSet em um objeto Endereco
     * Mapeia também nome_cliente, que só existe por causa do JOIN
     */
    private static class EnderecoRowMapper implements RowMapper<Endereco> {

        @Override
        public Endereco mapRow(ResultSet rs) throws SQLException {
            Endereco endereco = new Endereco();

            endereco.setIdEndereco(rs.getInt("id_endereco"));
            endereco.setCep(rs.getString("cep"));
            endereco.setRua(rs.getString("rua"));
            endereco.setNumero(rs.getString("numero"));
            endereco.setBairro(rs.getString("bairro"));
            endereco.setCidade(rs.getString("cidade"));
            endereco.setEstado(rs.getString("estado"));
            endereco.setClientesIdCliente(rs.getInt("clientes_id_cliente"));

            // Campo vindo do JOIN - só existe nesta consulta específica
            endereco.setNomeCliente(rs.getString("nome_cliente"));

            System.out.println("Mapeando endereco: " + endereco.toString());

            return endereco;
        }
    }

    /**
     * SELECT ALL com JOIN - busca todos os endereços trazendo também
     * o nome do cliente, em vez de só o ID
     */
    public List<Endereco> buscarTodosEnderecos() {
        String sql = "SELECT e.*, c.nome AS nome_cliente "
                + "FROM enderecos e "
                + "JOIN clientes c ON e.clientes_id_cliente = c.id_cliente "
                + "ORDER BY e.cidade";
        return buscarTodos(sql, new EnderecoRowMapper());
    }

    /**
     * SELECT BY ID com JOIN
     */
    public Endereco buscarEnderecoPorId(int id) {
        String sql = "SELECT e.*, c.nome AS nome_cliente "
                + "FROM enderecos e "
                + "JOIN clientes c ON e.clientes_id_cliente = c.id_cliente "
                + "WHERE e.id_endereco = ?";
        return buscarPorId(sql, new EnderecoRowMapper(), id);
    }
}