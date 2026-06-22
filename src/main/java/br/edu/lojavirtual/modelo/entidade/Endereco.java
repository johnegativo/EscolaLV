package br.edu.lojavirtual.modelo.entidade;

/**
 * Classe que representa a tabela enderecos do banco de dados
 */
public class Endereco {

    // Atributos correspondem às colunas da tabela enderecos
    private Integer idEndereco;
    private String cep;
    private String rua;
    private String numero;
    private String bairro;
    private String cidade;
    private String estado;

    // Chave estrangeira (FK) - guarda apenas o ID do cliente relacionado
    private Integer clientesIdCliente;

    // Campo "extra" - NÃO existe na tabela enderecos!
    // Vem do JOIN com clientes, usado só para exibição na tela
    private String nomeCliente;

    // Construtor vazio (OBRIGATÓRIO)
    public Endereco() {
    }

    // Construtor com os campos próprios da tabela (sem o campo de JOIN)
    public Endereco(Integer idEndereco, String cep, String rua, String numero,
            String bairro, String cidade, String estado, Integer clientesIdCliente) {
        this.idEndereco = idEndereco;
        this.cep = cep;
        this.rua = rua;
        this.numero = numero;
        this.bairro = bairro;
        this.cidade = cidade;
        this.estado = estado;
        this.clientesIdCliente = clientesIdCliente;
    }

    public Integer getIdEndereco() {
        return idEndereco;
    }

    public void setIdEndereco(Integer idEndereco) {
        this.idEndereco = idEndereco;
    }

    public String getCep() {
        return cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }

    public String getRua() {
        return rua;
    }

    public void setRua(String rua) {
        this.rua = rua;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getBairro() {
        return bairro;
    }

    public void setBairro(String bairro) {
        this.bairro = bairro;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Integer getClientesIdCliente() {
        return clientesIdCliente;
    }

    public void setClientesIdCliente(Integer clientesIdCliente) {
        this.clientesIdCliente = clientesIdCliente;
    }

    public String getNomeCliente() {
        return nomeCliente;
    }

    public void setNomeCliente(String nomeCliente) {
        this.nomeCliente = nomeCliente;
    }

    @Override
    public String toString() {
        return "Endereco{" +
                "idEndereco=" + idEndereco +
                ", cep='" + cep + '\'' +
                ", rua='" + rua + '\'' +
                ", numero='" + numero + '\'' +
                ", bairro='" + bairro + '\'' +
                ", cidade='" + cidade + '\'' +
                ", estado='" + estado + '\'' +
                ", clientesIdCliente=" + clientesIdCliente +
                '}';
    }
}