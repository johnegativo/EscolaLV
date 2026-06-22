package br.edu.lojavirtual.modelo.entidade;

/**
 * Classe que representa a tabela pedidos do banco de dados
 */
public class Pedido {

    // Atributos correspondem às colunas da tabela pedidos
    private Integer idPedidos;
    private String data;
    private Double valorTotal;
    private String status;

    // Chaves estrangeiras (FK)
    private Integer clientesIdCliente;
    private Integer enderecosIdEndereco;

    // Campos "extras" - NÃO existem na tabela pedidos!
    // Vêm do JOIN com clientes e enderecos, usados só para exibição na tela
    private String nomeCliente;
    private String enderecoResumo;

    // Construtor vazio (OBRIGATÓRIO)
    public Pedido() {
    }

    // Construtor com os campos próprios da tabela (sem os campos de JOIN)
    public Pedido(Integer idPedidos, String data, Double valorTotal, String status,
            Integer clientesIdCliente, Integer enderecosIdEndereco) {
        this.idPedidos = idPedidos;
        this.data = data;
        this.valorTotal = valorTotal;
        this.status = status;
        this.clientesIdCliente = clientesIdCliente;
        this.enderecosIdEndereco = enderecosIdEndereco;
    }

    public Integer getIdPedidos() {
        return idPedidos;
    }

    public void setIdPedidos(Integer idPedidos) {
        this.idPedidos = idPedidos;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public Double getValorTotal() {
        return valorTotal;
    }

    public void setValorTotal(Double valorTotal) {
        this.valorTotal = valorTotal;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getClientesIdCliente() {
        return clientesIdCliente;
    }

    public void setClientesIdCliente(Integer clientesIdCliente) {
        this.clientesIdCliente = clientesIdCliente;
    }

    public Integer getEnderecosIdEndereco() {
        return enderecosIdEndereco;
    }

    public void setEnderecosIdEndereco(Integer enderecosIdEndereco) {
        this.enderecosIdEndereco = enderecosIdEndereco;
    }

    public String getNomeCliente() {
        return nomeCliente;
    }

    public void setNomeCliente(String nomeCliente) {
        this.nomeCliente = nomeCliente;
    }

    public String getEnderecoResumo() {
        return enderecoResumo;
    }

    public void setEnderecoResumo(String enderecoResumo) {
        this.enderecoResumo = enderecoResumo;
    }

    @Override
    public String toString() {
        return "Pedido{" +
                "idPedidos=" + idPedidos +
                ", data='" + data + '\'' +
                ", valorTotal=" + valorTotal +
                ", status='" + status + '\'' +
                ", clientesIdCliente=" + clientesIdCliente +
                ", enderecosIdEndereco=" + enderecosIdEndereco +
                '}';
    }
}