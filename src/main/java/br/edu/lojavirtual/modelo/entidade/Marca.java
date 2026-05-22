package br.edu.lojavirtual.modelo.entidade;

public class Marca {
    
    private Integer idMarca;
    private String nome;
    private String descricao;
    private String paisOrigem;
    
    public Marca() {
    }
    
    public Marca(Integer idMarca, String nome, String descricao, String paisOrigem) {
        this.idMarca = idMarca;
        this.nome = nome;
        this.descricao = descricao;
        this.paisOrigem = paisOrigem;
    }

    public Integer getIdMarca() {
        return idMarca;
    }

    public void setIdMarca(Integer idMarca) {
        this.idMarca = idMarca;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getPaisOrigem() {
        return paisOrigem;
    }

    public void setPaisOrigem(String paisOrigem) {
        this.paisOrigem = paisOrigem;
    }

    @Override
    public String toString() {
        return "Marca{" + 
               "idMarca=" + idMarca + 
               ", nome='" + nome + '\'' + 
               ", descricao='" + descricao + '\'' + 
               ", paisOrigem='" + paisOrigem + '\'' + 
               '}';
    }
}