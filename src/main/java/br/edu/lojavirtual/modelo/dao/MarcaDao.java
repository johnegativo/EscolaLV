package br.edu.lojavirtual.modelo.dao;

import br.edu.lojavirtual.modelo.entidade.Marca;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class MarcaDao extends GenericoDAO<Marca> {
    
    public void salvar(Marca marca) {
        String sql = "INSERT INTO marcas(nome, descricao, pais_origem) VALUES(?, ?, ?)";
        save(sql, marca.getNome(), marca.getDescricao(), marca.getPaisOrigem());
    }
    
    public void alterar(Marca marca) {
        String sql = "UPDATE marcas SET nome=?, descricao=?, pais_origem=? WHERE id_marca=?";
        save(sql, marca.getNome(), marca.getDescricao(), marca.getPaisOrigem(), marca.getIdMarca());
    }
    
    public boolean excluir(Marca marca) {
        String sql = "DELETE FROM marcas WHERE id_marca=?";
        try {
            save(sql, marca.getIdMarca());
            return true;
        } catch (Exception e) {
            System.err.println("ERRO ao excluir marca: " + e.getMessage());
            return false;
        }
    }
    
    private static class MarcaRowMapper implements RowMapper<Marca> {
        
        @Override
        public Marca mapRow(ResultSet rs) throws SQLException {
            Marca marca = new Marca();
            marca.setIdMarca(rs.getInt("id_marca"));
            marca.setNome(rs.getString("nome"));
            marca.setDescricao(rs.getString("descricao"));
            marca.setPaisOrigem(rs.getString("pais_origem"));
            
            System.out.println("Mapeando marca: " + marca.toString());
            
            return marca;
        }
    }
    
    public List<Marca> buscarTodasMarcas() {
        String sql = "SELECT * FROM marcas ORDER BY nome";
        return buscarTodos(sql, new MarcaRowMapper());
    }
    
    public Marca buscarMarcaPorId(int id) {
        String sql = "SELECT * FROM marcas WHERE id_marca = ?";
        return buscarPorId(sql, new MarcaRowMapper(), id);
    }
}