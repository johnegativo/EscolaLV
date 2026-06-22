package br.edu.lojavirtual.modelo.entidade;

/**
 * Classe que representa a tabela pagamentos do banco de dados
 */
public class Pagamento {

    // Atributos correspondem às colunas da tabela pagamentos
    private Integer idPagamento;
    private String metodo;

    // ATENÇÃO: valor é preenchido automaticamente pela trigger
    // _tri_valorAutomaticoPagamentos, que copia o valor_total do pedido.
    // Nosso Java não precisa (e não deve) definir esse valor manualmente.
    private Double valor;

    private String status;
    private String data;

    // Chave estrangeira (FK)
    private Integer pedidosIdPedidos;

    // Campo "extra" - NÃO existe na tabela pagamentos!
    // Vem do JOIN com pedidos, usado só para exibição na tela
    private String nomeClientePedido;

    // Construtor vazio (OBRIGATÓRIO)
    public Pagamento() {
    }

    // Construtor com os campos que o usuário realmente informa
    // (sem "valor", que vem do banco)
    public Pagamento(Integer idPagamento, String metodo, String status, String data,
            Integer pedidosIdPedidos) {
        this.idPagamento = idPagamento;
        this.metodo = metodo;
        this.status = status;
        this.data = data;
        this.pedidosIdPedidos = pedidosIdPedidos;
    }

    public Integer getIdPagamento() {
        return idPagamento;
    }

    public void setIdPagamento(Integer idPagamento) {
        this.idPagamento = idPagamento;
    }

    public String getMetodo() {
        return metodo;
    }

    public void setMetodo(String metodo) {
        this.metodo = metodo;
    }

    public Double getValor() {
        return valor;
    }

    public void setValor(Double valor) {
        this.valor = valor;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public Integer getPedidosIdPedidos() {
        return pedidosIdPedidos;
    }

    public void setPedidosIdPedidos(Integer pedidosIdPedidos) {
        this.pedidosIdPedidos = pedidosIdPedidos;
    }

    public String getNomeClientePedido() {
        return nomeClientePedido;
    }

    public void setNomeClientePedido(String nomeClientePedido) {
        this.nomeClientePedido = nomeClientePedido;
    }

    @Override
    public String toString() {
        return "Pagamento{" +
                "idPagamento=" + idPagamento +
                ", metodo='" + metodo + '\'' +
                ", valor=" + valor +
                ", status='" + status + '\'' +
                ", data='" + data + '\'' +
                ", pedidosIdPedidos=" + pedidosIdPedidos +
                '}';
    }
}