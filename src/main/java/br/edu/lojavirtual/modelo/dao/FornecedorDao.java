package br.edu.lojavirtual.modelo.dao;

import br.edu.lojavirtual.modelo.entidade.Fornecedor;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class FornecedorDao extends GenericoDAO<Fornecedor> {
    
    public void salvar(Fornecedor fornecedor) {
        String sql = "INSERT INTO fornecedores(nome, telefone, email, cnpj, endereco) VALUES(?, ?, ?, ?, ?)";
        save(sql, fornecedor.getNome(), fornecedor.getTelefone(), 
             fornecedor.getEmail(), fornecedor.getCnpj(), fornecedor.getEndereco());
    }
    
    public void alterar(Fornecedor fornecedor) {
        String sql = "UPDATE fornecedores SET nome=?, telefone=?, email=?, cnpj=?, endereco=? WHERE id_fornecedor=?";
        save(sql, fornecedor.getNome(), fornecedor.getTelefone(), 
             fornecedor.getEmail(), fornecedor.getCnpj(), fornecedor.getEndereco(),
             fornecedor.getIdFornecedor());
    }
    
    public boolean excluir(Fornecedor fornecedor) {
        String sql = "DELETE FROM fornecedores WHERE id_fornecedor=?";
        try {
            save(sql, fornecedor.getIdFornecedor());
            return true;
        } catch (Exception e) {
            System.err.println("ERRO ao excluir fornecedor: " + e.getMessage());
            return false;
        }
    }
    
    private static class FornecedorRowMapper implements RowMapper<Fornecedor> {
        
        @Override
        public Fornecedor mapRow(ResultSet rs) throws SQLException {
            Fornecedor fornecedor = new Fornecedor();
            fornecedor.setIdFornecedor(rs.getInt("id_fornecedor"));
            fornecedor.setNome(rs.getString("nome"));
            fornecedor.setTelefone(rs.getString("telefone"));
            fornecedor.setEmail(rs.getString("email"));
            fornecedor.setCnpj(rs.getString("cnpj"));
            fornecedor.setEndereco(rs.getString("endereco"));
            
            System.out.println("Mapeando fornecedor: " + fornecedor.toString());
            
            return fornecedor;
        }
    }
    
    public List<Fornecedor> buscarTodosFornecedores() {
        String sql = "SELECT * FROM fornecedores ORDER BY nome";
        return buscarTodos(sql, new FornecedorRowMapper());
    }
    
    public Fornecedor buscarFornecedorPorId(int id) {
        String sql = "SELECT * FROM fornecedores WHERE id_fornecedor = ?";
        return buscarPorId(sql, new FornecedorRowMapper(), id);
    }
}