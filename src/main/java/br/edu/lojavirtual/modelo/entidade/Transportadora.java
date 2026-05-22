package br.edu.lojavirtual.modelo.entidade;

public class Transportadora {
    
    private Integer idTransportadora;
    private String nome;
    private String cnpj;
    private String telefone;
    private Integer prazoMedio;
    
    public Transportadora() {
    }
    
    public Transportadora(Integer idTransportadora, String nome, String cnpj, String telefone, Integer prazoMedio) {
        this.idTransportadora = idTransportadora;
        this.nome = nome;
        this.cnpj = cnpj;
        this.telefone = telefone;
        this.prazoMedio = prazoMedio;
    }

    public Integer getIdTransportadora() {
        return idTransportadora;
    }

    public void setIdTransportadora(Integer idTransportadora) {
        this.idTransportadora = idTransportadora;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCnpj() {
        return cnpj;
    }

    public void setCnpj(String cnpj) {
        this.cnpj = cnpj;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public Integer getPrazoMedio() {
        return prazoMedio;
    }

    public void setPrazoMedio(Integer prazoMedio) {
        this.prazoMedio = prazoMedio;
    }

    @Override
    public String toString() {
        return "Transportadora{" + 
               "idTransportadora=" + idTransportadora + 
               ", nome='" + nome + '\'' + 
               ", cnpj='" + cnpj + '\'' + 
               ", telefone='" + telefone + '\'' + 
               ", prazoMedio=" + prazoMedio + 
               '}';
    }
}