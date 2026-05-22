package br.edu.lojavirtual.modelo.entidade;

public class Fornecedor {
    
    private Integer idFornecedor;
    private String nome;
    private String telefone;
    private String email;
    private String cnpj;
    private String endereco;
    
    public Fornecedor() {
    }
    
    public Fornecedor(Integer idFornecedor, String nome, String telefone, String email, String cnpj, String endereco) {
        this.idFornecedor = idFornecedor;
        this.nome = nome;
        this.telefone = telefone;
        this.email = email;
        this.cnpj = cnpj;
        this.endereco = endereco;
    }

    public Integer getIdFornecedor() {
        return idFornecedor;
    }

    public void setIdFornecedor(Integer idFornecedor) {
        this.idFornecedor = idFornecedor;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCnpj() {
        return cnpj;
    }

    public void setCnpj(String cnpj) {
        this.cnpj = cnpj;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    @Override
    public String toString() {
        return "Fornecedor{" + 
               "idFornecedor=" + idFornecedor + 
               ", nome='" + nome + '\'' + 
               ", telefone='" + telefone + '\'' + 
               ", email='" + email + '\'' + 
               ", cnpj='" + cnpj + '\'' + 
               ", endereco='" + endereco + '\'' + 
               '}';
    }
}