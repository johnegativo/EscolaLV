package br.edu.lojavirtual.modelo.entidade;

/**
 * Classe que representa a tabela produtos do banco de dados
 */
public class Produto {

    // Atributos correspondem às colunas da tabela produtos
    private Integer idProduto;
    private String nome;
    private String descricao;
    private Double preco;
    private Integer estoque;
    private Double peso;
    private Double notaMedia;

    // Chaves estrangeiras (FK) - guardam apenas o ID relacionado
    private Integer categoriasIdCategoria;
    private Integer marcasIdMarca;

    // Campos "extras" - NÃO existem na tabela produtos!
    // Vêm do JOIN com categorias e marcas, usados só para exibição na tela
    private String nomeCategoria;
    private String nomeMarca;

    // Construtor vazio (OBRIGATÓRIO)
    public Produto() {
    }

    // Construtor com os campos próprios da tabela (sem os campos de JOIN)
    public Produto(Integer idProduto, String nome, String descricao, Double preco,
            Integer estoque, Double peso, Double notaMedia,
            Integer categoriasIdCategoria, Integer marcasIdMarca) {
        this.idProduto = idProduto;
        this.nome = nome;
        this.descricao = descricao;
        this.preco = preco;
        this.estoque = estoque;
        this.peso = peso;
        this.notaMedia = notaMedia;
        this.categoriasIdCategoria = categoriasIdCategoria;
        this.marcasIdMarca = marcasIdMarca;
    }

    public Integer getIdProduto() {
        return idProduto;
    }

    public void setIdProduto(Integer idProduto) {
        this.idProduto = idProduto;
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

    public Double getPreco() {
        return preco;
    }

    public void setPreco(Double preco) {
        this.preco = preco;
    }

    public Integer getEstoque() {
        return estoque;
    }

    public void setEstoque(Integer estoque) {
        this.estoque = estoque;
    }

    public Double getPeso() {
        return peso;
    }

    public void setPeso(Double peso) {
        this.peso = peso;
    }

    public Double getNotaMedia() {
        return notaMedia;
    }

    public void setNotaMedia(Double notaMedia) {
        this.notaMedia = notaMedia;
    }

    public Integer getCategoriasIdCategoria() {
        return categoriasIdCategoria;
    }

    public void setCategoriasIdCategoria(Integer categoriasIdCategoria) {
        this.categoriasIdCategoria = categoriasIdCategoria;
    }

    public Integer getMarcasIdMarca() {
        return marcasIdMarca;
    }

    public void setMarcasIdMarca(Integer marcasIdMarca) {
        this.marcasIdMarca = marcasIdMarca;
    }

    public String getNomeCategoria() {
        return nomeCategoria;
    }

    public void setNomeCategoria(String nomeCategoria) {
        this.nomeCategoria = nomeCategoria;
    }

    public String getNomeMarca() {
        return nomeMarca;
    }

    public void setNomeMarca(String nomeMarca) {
        this.nomeMarca = nomeMarca;
    }

    // toString() facilita debug
    @Override
    public String toString() {
        return "Produto{" +
                "idProduto=" + idProduto +
                ", nome='" + nome + '\'' +
                ", descricao='" + descricao + '\'' +
                ", preco=" + preco +
                ", estoque=" + estoque +
                ", peso=" + peso +
                ", notaMedia=" + notaMedia +
                ", categoriasIdCategoria=" + categoriasIdCategoria +
                ", marcasIdMarca=" + marcasIdMarca +
                '}';
    }
}