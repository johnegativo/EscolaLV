package br.edu.lojavirtual.modelo.dao;

import br.edu.lojavirtual.modelo.entidade.Pedido;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class PedidoDao extends GenericoDAO<Pedido> {

    /**
     * INSERT - Insere novo pedido
     * ATENÇÃO: valor_total é inserido com o valor inicial informado (geralmente 0),
     * mas será RECALCULADO automaticamente pelas triggers do banco quando
     * itens de pedido forem cadastrados em itens_pedido
     */
    public void salvar(Pedido pedido) {
        String sql = "INSERT INTO pedidos(data, valor_total, status, clientes_id_cliente, enderecos_id_endereco) "
                + "VALUES(?, ?, ?, ?, ?)";
        save(sql, pedido.getData(), pedido.getValorTotal(), pedido.getStatus(),
                pedido.getClientesIdCliente(), pedido.getEnderecosIdEndereco());
    }

    /**
     * UPDATE - Atualiza pedido existente
     * ATENÇÃO: se alterar o status para "Cancelado", a trigger
     * tri_reembolso_automatico cria um reembolso e devolve o estoque sozinha
     */
    public void alterar(Pedido pedido) {
        String sql = "UPDATE pedidos SET data=?, valor_total=?, status=?, "
                + "clientes_id_cliente=?, enderecos_id_endereco=? WHERE id_pedidos=?";
        save(sql, pedido.getData(), pedido.getValorTotal(), pedido.getStatus(),
                pedido.getClientesIdCliente(), pedido.getEnderecosIdEndereco(),
                pedido.getIdPedidos());
    }

    /**
     * DELETE - Remove pedido
     * ATENÇÃO: pedidos é referenciado por itens_pedido, pagamentos e reembolsos.
     * É bem provável que a exclusão falhe por FK se o pedido já tiver itens.
     */
    public boolean excluir(Pedido pedido) {
        String sql = "DELETE FROM pedidos WHERE id_pedidos=?";
        try {
            save(sql, pedido.getIdPedidos());
            return true;
        } catch (Exception e) {
            System.err.println("ERRO ao excluir pedido: " + e.getMessage());
            return false;
        }
    }

    /**
     * RowMapper - converte cada linha do ResultSet em um objeto Pedido
     * Mapeia também nome_cliente e endereco_resumo, vindos do JOIN
     */
    private static class PedidoRowMapper implements RowMapper<Pedido> {

        @Override
        public Pedido mapRow(ResultSet rs) throws SQLException {
            Pedido pedido = new Pedido();

            pedido.setIdPedidos(rs.getInt("id_pedidos"));
            pedido.setData(rs.getString("data"));
            pedido.setValorTotal(rs.getDouble("valor_total"));
            pedido.setStatus(rs.getString("status"));
            pedido.setClientesIdCliente(rs.getInt("clientes_id_cliente"));
            pedido.setEnderecosIdEndereco(rs.getInt("enderecos_id_endereco"));

            // Campos vindos do JOIN
            pedido.setNomeCliente(rs.getString("nome_cliente"));
            pedido.setEnderecoResumo(rs.getString("endereco_resumo"));

            System.out.println("Mapeando pedido: " + pedido.toString());

            return pedido;
        }
    }

    /**
     * SELECT ALL com JOIN duplo - busca todos os pedidos trazendo
     * o nome do cliente e um resumo do endereço de entrega
     */
    public List<Pedido> buscarTodosPedidos() {
        String sql = "SELECT p.*, c.nome AS nome_cliente, "
                + "CONCAT(e.rua, ', ', e.numero, ' - ', e.bairro, ', ', e.cidade, '/', e.estado) AS endereco_resumo "
                + "FROM pedidos p "
                + "JOIN clientes c ON p.clientes_id_cliente = c.id_cliente "
                + "JOIN enderecos e ON p.enderecos_id_endereco = e.id_endereco "
                + "ORDER BY p.data DESC";
        return buscarTodos(sql, new PedidoRowMapper());
    }

    /**
     * SELECT BY ID com JOIN duplo
     */
    public Pedido buscarPedidoPorId(int id) {
        String sql = "SELECT p.*, c.nome AS nome_cliente, "
                + "CONCAT(e.rua, ', ', e.numero, ' - ', e.bairro, ', ', e.cidade, '/', e.estado) AS endereco_resumo "
                + "FROM pedidos p "
                + "JOIN clientes c ON p.clientes_id_cliente = c.id_cliente "
                + "JOIN enderecos e ON p.enderecos_id_endereco = e.id_endereco "
                + "WHERE p.id_pedidos = ?";
        return buscarPorId(sql, new PedidoRowMapper(), id);
    }
}
