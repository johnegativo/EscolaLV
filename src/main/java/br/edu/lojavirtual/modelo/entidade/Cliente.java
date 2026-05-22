package br.edu.lojavirtual.modelo.entidade;

public class Cliente {
    
    private Integer idCliente;
    private String nome;
    private String email;
    private String senha;
    private String cpfCnpj;
    private String telefone;
    private String dataCadastro;
    private String dataNascimento;
    
    public Cliente() {
    }
    
    public Cliente(Integer idCliente, String nome, String email, String senha, 
                   String cpfCnpj, String telefone, String dataCadastro, String dataNascimento) {
        this.idCliente = idCliente;
        this.nome = nome;
        this.email = email;
        this.senha = senha;
        this.cpfCnpj = cpfCnpj;
        this.telefone = telefone;
        this.dataCadastro = dataCadastro;
        this.dataNascimento = dataNascimento;
    }

    public Integer getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(Integer idCliente) {
        this.idCliente = idCliente;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getCpfCnpj() {
        return cpfCnpj;
    }

    public void setCpfCnpj(String cpfCnpj) {
        this.cpfCnpj = cpfCnpj;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getDataCadastro() {
        return dataCadastro;
    }

    public void setDataCadastro(String dataCadastro) {
        this.dataCadastro = dataCadastro;
    }

    public String getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(String dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    @Override
    public String toString() {
        return "Cliente{" + 
               "idCliente=" + idCliente + 
               ", nome='" + nome + '\'' + 
               ", email='" + email + '\'' + 
               ", cpfCnpj='" + cpfCnpj + '\'' + 
               ", telefone='" + telefone + '\'' + 
               ", dataCadastro='" + dataCadastro + '\'' + 
               ", dataNascimento='" + dataNascimento + '\'' + 
               '}';
    }
}