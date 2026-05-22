package br.edu.lojavirtual.modelo.dao;

import br.edu.lojavirtual.modelo.entidade.Transportadora;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class TransportadoraDao extends GenericoDAO<Transportadora> {
    
    public void salvar(Transportadora transportadora) {
        String sql = "INSERT INTO transportadoras(nome, cnpj, telefone, prazo_medio) VALUES(?, ?, ?, ?)";
        save(sql, transportadora.getNome(), transportadora.getCnpj(), 
             transportadora.getTelefone(), transportadora.getPrazoMedio());
    }
    
    public void alterar(Transportadora transportadora) {
        String sql = "UPDATE transportadoras SET nome=?, cnpj=?, telefone=?, prazo_medio=? WHERE id_transportadora=?";
        save(sql, transportadora.getNome(), transportadora.getCnpj(), 
             transportadora.getTelefone(), transportadora.getPrazoMedio(), 
             transportadora.getIdTransportadora());
    }
    
    public boolean excluir(Transportadora transportadora) {
        String sql = "DELETE FROM transportadoras WHERE id_transportadora=?";
        try {
            save(sql, transportadora.getIdTransportadora());
            return true;
        } catch (Exception e) {
            System.err.println("ERRO ao excluir transportadora: " + e.getMessage());
            return false;
        }
    }
    
    private static class TransportadoraRowMapper implements RowMapper<Transportadora> {
        
        @Override
        public Transportadora mapRow(ResultSet rs) throws SQLException {
            Transportadora transportadora = new Transportadora();
            transportadora.setIdTransportadora(rs.getInt("id_transportadora"));
            transportadora.setNome(rs.getString("nome"));
            transportadora.setCnpj(rs.getString("cnpj"));
            transportadora.setTelefone(rs.getString("telefone"));
            transportadora.setPrazoMedio(rs.getInt("prazo_medio"));
            
            System.out.println("Mapeando transportadora: " + transportadora.toString());
            
            return transportadora;
        }
    }
    
    public List<Transportadora> buscarTodasTransportadoras() {
        String sql = "SELECT * FROM transportadoras ORDER BY nome";
        return buscarTodos(sql, new TransportadoraRowMapper());
    }
    
    public Transportadora buscarTransportadoraPorId(int id) {
        String sql = "SELECT * FROM transportadoras WHERE id_transportadora = ?";
        return buscarPorId(sql, new TransportadoraRowMapper(), id);
    }
}