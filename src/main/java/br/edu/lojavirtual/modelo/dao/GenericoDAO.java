package br.edu.lojavirtual.modelo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Classe genérica com operações comuns de banco de dados Evita repetição de
 * código nos DAOs específicos
 */
public class GenericoDAO<T> {

    private Connection connection;

    public Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            connection = ConnectionFactory.getInstance().getConnection();
        }
        return connection;
    }

    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Método genérico para INSERT, UPDATE e DELETE
     *
     * @param sql Query SQL a ser executada
     * @param parametros Valores dos ? na query
     * @throws RuntimeException se houver erro no banco
     */
    public void save(String sql, Object... parametros) {
        try {
            PreparedStatement pstmt = ConnectionFactory.getInstance().getPreparedStatement(sql);

            // Preenche os ? da query com os parâmetros
            for (int i = 0; i < parametros.length; i++) {
                pstmt.setObject((i + 1), parametros[i]);
            }

            pstmt.execute();
            pstmt.close();

        } catch (SQLException e) {
            // Lança exceção em vez de apenas imprimir
            e.printStackTrace();
            throw new RuntimeException("Erro ao executar operação no banco: " + e.getMessage(), e);
        }
    }

    public List<T> buscarTodos(String sql, RowMapper<T> rowMapper, Object... parametros) {
        List<T> lista = new ArrayList<>();

        try {
            PreparedStatement pstmt = ConnectionFactory.getInstance().getPreparedStatement(sql);

            for (int i = 0; i < parametros.length; i++) {
                pstmt.setObject((i + 1), parametros[i]);
            }

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                lista.add(rowMapper.mapRow(rs));
            }

            rs.close();
            pstmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public T buscarPorId(String sql, RowMapper<T> rowMapper, Object... parametros) {
        T objeto = null;

        try {
            PreparedStatement pstmt = ConnectionFactory.getInstance().getPreparedStatement(sql);

            for (int i = 0; i < parametros.length; i++) {
                pstmt.setObject((i + 1), parametros[i]);
            }

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                objeto = rowMapper.mapRow(rs);
            }

            rs.close();
            pstmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return objeto;
    }
}
