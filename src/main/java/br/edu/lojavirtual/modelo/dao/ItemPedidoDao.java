package br.edu.lojavirtual.modelo.dao;

import br.edu.lojavirtual.modelo.entidade.ItemPedido;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class ItemPedidoDao extends GenericoDAO<ItemPedido> {

    /**
     * INSERT - Insere novo item de pedido
     * ATENÇÃO: preco_unitario NÃO é informado aqui!
     * A trigger _tri_precoUnitarioItensPedido busca o preço atual do produto
     * e preenche sozinha ANTES do INSERT ser concluído (BEFORE INSERT).
     * Depois, outra trigger recalcula o valor_total do pedido automaticamente.
     */
    public void salvar(ItemPedido item) {
        String sql = "INSERT INTO itens_pedido(quantidade, produtos_id_produto, pedidos_id_pedidos) "
                + "VALUES(?, ?, ?)";
        save(sql, item.getQuantidade(), item.getProdutosIdProduto(), item.getPedidosIdPedidos());
    }

    /**
     * UPDATE - Atualiza item de pedido existente
     * ATENÇÃO: ao alterar a quantidade, a trigger _tri_valorTotalAltera
     * recalcula o valor_total do pedido automaticamente
     */
    public void alterar(ItemPedido item) {
        String sql = "UPDATE itens_pedido SET quantidade=?, produtos_id_produto=?, pedidos_id_pedidos=? "
                + "WHERE id_itens_pedido=?";
        save(sql, item.getQuantidade(), item.getProdutosIdProduto(), item.getPedidosIdPedidos(),
                item.getIdItensPedido());
    }

    /**
     * DELETE - Remove item de pedido
     * ATENÇÃO: ao excluir, a trigger tri_estoque_delete_item_pedido devolve
     * a quantidade ao estoque do produto automaticamente, e o valor_total
     * do pedido é recalculado
     */
    public boolean excluir(ItemPedido item) {
        String sql = "DELETE FROM itens_pedido WHERE id_itens_pedido=?";
        try {
            save(sql, item.getIdItensPedido());
            return true;
        } catch (Exception e) {
            System.err.println("ERRO ao excluir item de pedido: " + e.getMessage());
            return false;
        }
    }

    /**
     * RowMapper - converte cada linha do ResultSet em um objeto ItemPedido
     * Mapeia também nome_produto e subtotal, vindos do JOIN
     */
    private static class ItemPedidoRowMapper implements RowMapper<ItemPedido> {

        @Override
        public ItemPedido mapRow(ResultSet rs) throws SQLException {
            ItemPedido item = new ItemPedido();

            item.setIdItensPedido(rs.getInt("id_itens_pedido"));
            item.setQuantidade(rs.getInt("quantidade"));
            item.setPrecoUnitario(rs.getDouble("preco_unitario"));
            item.setProdutosIdProduto(rs.getInt("produtos_id_produto"));
            item.setPedidosIdPedidos(rs.getInt("pedidos_id_pedidos"));

            // Campos vindos do JOIN
            item.setNomeProduto(rs.getString("nome_produto"));
            item.setSubtotal(rs.getDouble("subtotal"));

            System.out.println("Mapeando item de pedido: " + item.toString());

            return item;
        }
    }

    /**
     * SELECT ALL com JOIN - busca todos os itens de pedido trazendo
     * o nome do produto e o subtotal (quantidade x preco_unitario) calculado
     */
    public List<ItemPedido> buscarTodosItensPedido() {
        String sql = "SELECT ip.*, pr.nome AS nome_produto, "
                + "(ip.quantidade * ip.preco_unitario) AS subtotal "
                + "FROM itens_pedido ip "
                + "JOIN produtos pr ON ip.produtos_id_produto = pr.id_produto "
                + "ORDER BY ip.pedidos_id_pedidos";
        return buscarTodos(sql, new ItemPedidoRowMapper());
    }

    /**
     * SELECT BY ID com JOIN
     */
    public ItemPedido buscarItemPedidoPorId(int id) {
        String sql = "SELECT ip.*, pr.nome AS nome_produto, "
                + "(ip.quantidade * ip.preco_unitario) AS subtotal "
                + "FROM itens_pedido ip "
                + "JOIN produtos pr ON ip.produtos_id_produto = pr.id_produto "
                + "WHERE ip.id_itens_pedido = ?";
        return buscarPorId(sql, new ItemPedidoRowMapper(), id);
    }

    /**
     * Busca apenas os itens de UM pedido específico
     * Útil para mostrar "os itens deste pedido" em vez da lista inteira
     */
    public List<ItemPedido> buscarItensPorPedido(int idPedido) {
        String sql = "SELECT ip.*, pr.nome AS nome_produto, "
                + "(ip.quantidade * ip.preco_unitario) AS subtotal "
                + "FROM itens_pedido ip "
                + "JOIN produtos pr ON ip.produtos_id_produto = pr.id_produto "
                + "WHERE ip.pedidos_id_pedidos = ?";
        return buscarTodos(sql, new ItemPedidoRowMapper(), idPedido);
    }
}