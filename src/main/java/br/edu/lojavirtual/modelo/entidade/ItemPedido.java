package br.edu.lojavirtual.modelo.entidade;

/**
 * Classe que representa a tabela itens_pedido do banco de dados
 * Esta é uma tabela ASSOCIATIVA: existe para ligar um Produto a um Pedido
 */
public class ItemPedido {

    // Atributos correspondem às colunas da tabela itens_pedido
    private Integer idItensPedido;
    private Integer quantidade;

    // ATENÇÃO: preco_unitario é preenchido automaticamente pela trigger
    // _tri_precoUnitarioItensPedido no momento do INSERT. Nosso Java
    // não precisa (e não deve) definir esse valor manualmente.
    private Double precoUnitario;

    // Chaves estrangeiras (FK)
    private Integer produtosIdProduto;
    private Integer pedidosIdPedidos;

    // Campos "extras" - NÃO existem na tabela itens_pedido!
    // Vêm do JOIN com produtos e pedidos, usados só para exibição na tela
    private String nomeProduto;
    private Double subtotal;

    // Construtor vazio (OBRIGATÓRIO)
    public ItemPedido() {
    }

    // Construtor com os campos que o usuário realmente informa
    // (sem precoUnitario, que vem do banco)
    public ItemPedido(Integer idItensPedido, Integer quantidade,
            Integer produtosIdProduto, Integer pedidosIdPedidos) {
        this.idItensPedido = idItensPedido;
        this.quantidade = quantidade;
        this.produtosIdProduto = produtosIdProduto;
        this.pedidosIdPedidos = pedidosIdPedidos;
    }

    public Integer getIdItensPedido() {
        return idItensPedido;
    }

    public void setIdItensPedido(Integer idItensPedido) {
        this.idItensPedido = idItensPedido;
    }

    public Integer getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(Integer quantidade) {
        this.quantidade = quantidade;
    }

    public Double getPrecoUnitario() {
        return precoUnitario;
    }

    public void setPrecoUnitario(Double precoUnitario) {
        this.precoUnitario = precoUnitario;
    }

    public Integer getProdutosIdProduto() {
        return produtosIdProduto;
    }

    public void setProdutosIdProduto(Integer produtosIdProduto) {
        this.produtosIdProduto = produtosIdProduto;
    }

    public Integer getPedidosIdPedidos() {
        return pedidosIdPedidos;
    }

    public void setPedidosIdPedidos(Integer pedidosIdPedidos) {
        this.pedidosIdPedidos = pedidosIdPedidos;
    }

    public String getNomeProduto() {
        return nomeProduto;
    }

    public void setNomeProduto(String nomeProduto) {
        this.nomeProduto = nomeProduto;
    }

    public Double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(Double subtotal) {
        this.subtotal = subtotal;
    }

    @Override
    public String toString() {
        return "ItemPedido{" +
                "idItensPedido=" + idItensPedido +
                ", quantidade=" + quantidade +
                ", precoUnitario=" + precoUnitario +
                ", produtosIdProduto=" + produtosIdProduto +
                ", pedidosIdPedidos=" + pedidosIdPedidos +
                '}';
    }
}