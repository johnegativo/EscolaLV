package br.edu.lojavirtual.modelo.dao;

import br.edu.lojavirtual.modelo.entidade.Cliente;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class ClienteDao extends GenericoDAO<Cliente> {
    
    public void salvar(Cliente cliente) {
        String sql = "INSERT INTO clientes(nome, email, senha, cpf_cnpj, telefone, dataCadastro, dataNascimento) VALUES(?, ?, ?, ?, ?, ?, ?)";
        save(sql, cliente.getNome(), cliente.getEmail(), cliente.getSenha(),
             cliente.getCpfCnpj(), cliente.getTelefone(), cliente.getDataCadastro(),
             cliente.getDataNascimento());
    }
    
    public void alterar(Cliente cliente) {
        String sql = "UPDATE clientes SET nome=?, email=?, senha=?, cpf_cnpj=?, telefone=?, dataCadastro=?, dataNascimento=? WHERE id_cliente=?";
        save(sql, cliente.getNome(), cliente.getEmail(), cliente.getSenha(),
             cliente.getCpfCnpj(), cliente.getTelefone(), cliente.getDataCadastro(),
             cliente.getDataNascimento(), cliente.getIdCliente());
    }
    
    public boolean excluir(Cliente cliente) {
        String sql = "DELETE FROM clientes WHERE id_cliente=?";
        try {
            save(sql, cliente.getIdCliente());
            return true;
        } catch (Exception e) {
            System.err.println("ERRO ao excluir cliente: " + e.getMessage());
            return false;
        }
    }
    
    private static class ClienteRowMapper implements RowMapper<Cliente> {
        
        @Override
        public Cliente mapRow(ResultSet rs) throws SQLException {
            Cliente cliente = new Cliente();
            cliente.setIdCliente(rs.getInt("id_cliente"));
            cliente.setNome(rs.getString("nome"));
            cliente.setEmail(rs.getString("email"));
            cliente.setSenha(rs.getString("senha"));
            cliente.setCpfCnpj(rs.getString("cpf_cnpj"));
            cliente.setTelefone(rs.getString("telefone"));
            cliente.setDataCadastro(rs.getString("dataCadastro"));
            cliente.setDataNascimento(rs.getString("dataNascimento"));
            
            System.out.println("Mapeando cliente: " + cliente.toString());
            
            return cliente;
        }
    }
    
    public List<Cliente> buscarTodosClientes() {
        String sql = "SELECT * FROM clientes ORDER BY nome";
        return buscarTodos(sql, new ClienteRowMapper());
    }
    
    public Cliente buscarClientePorId(int id) {
        String sql = "SELECT * FROM clientes WHERE id_cliente = ?";
        return buscarPorId(sql, new ClienteRowMapper(), id);
    }
}