package br.edu.lojavirtual.modelo.dao;

import br.edu.lojavirtual.modelo.entidade.Pagamento;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class PagamentoDao extends GenericoDAO<Pagamento> {

    /**
     * INSERT - Insere novo pagamento
     * ATENÇÃO: "valor" NÃO é informado aqui!
     * A trigger _tri_valorAutomaticoPagamentos busca o valor_total do pedido
     * e preenche sozinha ANTES do INSERT (BEFORE INSERT).
     * Depois, se status = 'Aprovado', a trigger tri_status_pedido_pagamento
     * muda o status do pedido para 'Pago' automaticamente.
     */
    public void salvar(Pagamento pagamento) {
        String sql = "INSERT INTO pagamentos(metodo, status, data, pedidos_id_pedidos) "
                + "VALUES(?, ?, ?, ?)";
        save(sql, pagamento.getMetodo(), pagamento.getStatus(), pagamento.getData(),
                pagamento.getPedidosIdPedidos());
    }

    /**
     * UPDATE - Atualiza pagamento existente
     */
    public void alterar(Pagamento pagamento) {
        String sql = "UPDATE pagamentos SET metodo=?, status=?, data=?, pedidos_id_pedidos=? "
                + "WHERE id_pagamento=?";
        save(sql, pagamento.getMetodo(), pagamento.getStatus(), pagamento.getData(),
                pagamento.getPedidosIdPedidos(), pagamento.getIdPagamento());
    }

    /**
     * DELETE - Remove pagamento
     * ATENÇÃO: pagamentos é referenciado por reembolsos. Se já existir um
     * reembolso vinculado, a exclusão vai falhar por FK.
     */
    public boolean excluir(Pagamento pagamento) {
        String sql = "DELETE FROM pagamentos WHERE id_pagamento=?";
        try {
            save(sql, pagamento.getIdPagamento());
            return true;
        } catch (Exception e) {
            System.err.println("ERRO ao excluir pagamento: " + e.getMessage());
            return false;
        }
    }

    /**
     * RowMapper - converte cada linha do ResultSet em um objeto Pagamento
     * Mapeia também nome_cliente_pedido, vindo do JOIN
     */
    private static class PagamentoRowMapper implements RowMapper<Pagamento> {

        @Override
        public Pagamento mapRow(ResultSet rs) throws SQLException {
            Pagamento pagamento = new Pagamento();

            pagamento.setIdPagamento(rs.getInt("id_pagamento"));
            pagamento.setMetodo(rs.getString("metodo"));
            pagamento.setValor(rs.getDouble("valor"));
            pagamento.setStatus(rs.getString("status"));
            pagamento.setData(rs.getString("data"));
            pagamento.setPedidosIdPedidos(rs.getInt("pedidos_id_pedidos"));

            // Campo vindo do JOIN
            pagamento.setNomeClientePedido(rs.getString("nome_cliente_pedido"));

            System.out.println("Mapeando pagamento: " + pagamento.toString());

            return pagamento;
        }
    }

    /**
     * SELECT ALL com JOIN - busca todos os pagamentos trazendo também
     * o nome do cliente do pedido relacionado
     */
    public List<Pagamento> buscarTodosPagamentos() {
        String sql = "SELECT pg.*, c.nome AS nome_cliente_pedido "
                + "FROM pagamentos pg "
                + "JOIN pedidos p ON pg.pedidos_id_pedidos = p.id_pedidos "
                + "JOIN clientes c ON p.clientes_id_cliente = c.id_cliente "
                + "ORDER BY pg.data DESC";
        return buscarTodos(sql, new PagamentoRowMapper());
    }

    /**
     * SELECT BY ID com JOIN
     */
    public Pagamento buscarPagamentoPorId(int id) {
        String sql = "SELECT pg.*, c.nome AS nome_cliente_pedido "
                + "FROM pagamentos pg "
                + "JOIN pedidos p ON pg.pedidos_id_pedidos = p.id_pedidos "
                + "JOIN clientes c ON p.clientes_id_cliente = c.id_cliente "
                + "WHERE pg.id_pagamento = ?";
        return buscarPorId(sql, new PagamentoRowMapper(), id);
    }
}