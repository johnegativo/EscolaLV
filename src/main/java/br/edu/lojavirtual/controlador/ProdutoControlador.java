package br.edu.lojavirtual.controlador;

import br.edu.lojavirtual.modelo.dao.CategoriaDao;
import br.edu.lojavirtual.modelo.dao.MarcaDao;
import br.edu.lojavirtual.modelo.dao.ProdutoDao;
import br.edu.lojavirtual.modelo.entidade.Categoria;
import br.edu.lojavirtual.modelo.entidade.Marca;
import br.edu.lojavirtual.modelo.entidade.Produto;
import br.edu.lojavirtual.servico.WebConstante;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH + "/ProdutoControlador")
public class ProdutoControlador extends HttpServlet {

    // Objetos principais
    private Produto objProduto = new Produto();
    private ProdutoDao objProdutoDao = new ProdutoDao();

    // DAOs "auxiliares" - usados só para alimentar os dropdowns do formulário
    private CategoriaDao objCategoriaDao = new CategoriaDao();
    private MarcaDao objMarcaDao = new MarcaDao();

    // Variáveis para receber dados do formulário
    private String idProduto = "";
    private String nome = "";
    private String descricao = "";
    private String preco = "";
    private String estoque = "";
    private String peso = "";
    private String categoriasIdCategoria = "";
    private String marcasIdMarca = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String opcao = request.getParameter("opcao");

            if (opcao == null || opcao.isEmpty()) {
                opcao = "cadastrar";
                encaminharParaPagina(request, response);
                return;
            }

            idProduto = request.getParameter("idProduto");
            nome = request.getParameter("nome");
            descricao = request.getParameter("descricao");
            preco = request.getParameter("preco");
            estoque = request.getParameter("estoque");
            peso = request.getParameter("peso");
            categoriasIdCategoria = request.getParameter("categoriasIdCategoria");
            marcasIdMarca = request.getParameter("marcasIdMarca");

            switch (opcao) {
                case "cadastrar":
                    cadastrar(request, response);
                    break;
                case "enviarAlterar":
                    enviarAlterar(request, response);
                    break;
                case "confirmarAlterar":
                    confirmarAlterar(request, response);
                    break;
                case "enviarExcluir":
                    enviarExcluir(request, response);
                    break;
                case "confirmarExcluir":
                    confirmarExcluir(request, response);
                    break;
                case "cancelar":
                    cancelar(request, response);
                    break;
                default:
                    encaminharParaPagina(request, response);
            }

        } catch (NumberFormatException e) {
            response.getWriter().println("Erro: Parâmetro inválido - " + e.getMessage());
        } catch (IllegalArgumentException e) {
            response.getWriter().println("Erro: " + e.getMessage());
        }
    }

    /**
     * CADASTRAR - Insere novo produto
     * ATENÇÃO: preco, estoque e peso vêm como String do formulário,
     * por isso usamos Double.valueOf() e Integer.valueOf() para converter
     */
    protected void cadastrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        objProduto.setNome(nome);
        objProduto.setDescricao(descricao);
        objProduto.setPreco(Double.valueOf(preco));
        objProduto.setEstoque(Integer.valueOf(estoque));
        objProduto.setPeso(peso == null || peso.isEmpty() ? null : Double.valueOf(peso));
        objProduto.setCategoriasIdCategoria(Integer.valueOf(categoriasIdCategoria));
        objProduto.setMarcasIdMarca(Integer.valueOf(marcasIdMarca));

        objProdutoDao.salvar(objProduto);

        request.setAttribute("mensagem", "Produto cadastrado com sucesso!");
        encaminharParaPagina(request, response);
    }

    protected void enviarAlterar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("idProduto", idProduto);
        request.setAttribute("nome", nome);
        request.setAttribute("descricao", descricao);
        request.setAttribute("preco", preco);
        request.setAttribute("estoque", estoque);
        request.setAttribute("peso", peso);
        request.setAttribute("categoriasIdCategoria", categoriasIdCategoria);
        request.setAttribute("marcasIdMarca", marcasIdMarca);
        request.setAttribute("opcao", "confirmarAlterar");
        request.setAttribute("mensagem", "Edite os dados e clique em Salvar");

        encaminharParaPagina(request, response);
    }

    protected void confirmarAlterar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        objProduto.setIdProduto(Integer.valueOf(idProduto));
        objProduto.setNome(nome);
        objProduto.setDescricao(descricao);
        objProduto.setPreco(Double.valueOf(preco));
        objProduto.setEstoque(Integer.valueOf(estoque));
        objProduto.setPeso(peso == null || peso.isEmpty() ? null : Double.valueOf(peso));
        objProduto.setCategoriasIdCategoria(Integer.valueOf(categoriasIdCategoria));
        objProduto.setMarcasIdMarca(Integer.valueOf(marcasIdMarca));

        objProdutoDao.alterar(objProduto);

        request.setAttribute("mensagem", "Produto alterado com sucesso!");
        cancelar(request, response);
    }

    protected void enviarExcluir(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("idProduto", idProduto);
        request.setAttribute("nome", nome);
        request.setAttribute("descricao", descricao);
        request.setAttribute("preco", preco);
        request.setAttribute("estoque", estoque);
        request.setAttribute("peso", peso);
        request.setAttribute("categoriasIdCategoria", categoriasIdCategoria);
        request.setAttribute("marcasIdMarca", marcasIdMarca);
        request.setAttribute("opcao", "confirmarExcluir");
        request.setAttribute("mensagem", "Confirme os dados e clique em Salvar para excluir");

        encaminharParaPagina(request, response);
    }

    /**
     * CONFIRMAR EXCLUIR
     * ATENÇÃO: produto tem MUITAS tabelas dependentes (itens_pedido, avaliacoes,
     * estoque, produtos_has_fornecedores). É bem provável que essa exclusão
     * falhe por Foreign Key se o produto já tiver pedidos/avaliações associadas.
     */
    protected void confirmarExcluir(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            objProduto.setIdProduto(Integer.valueOf(idProduto));

            boolean excluido = objProdutoDao.excluir(objProduto);

            if (excluido) {
                request.setAttribute("mensagem", "Produto excluído com sucesso!");
            } else {
                request.setAttribute("mensagem", "ERRO: Não foi possível excluir. Este produto pode estar associado a pedidos, avaliações ou estoque.");
            }

        } catch (Exception e) {
            System.err.println("Erro ao excluir produto: " + e.getMessage());
            request.setAttribute("mensagem", "ERRO: Este produto não pode ser excluído pois está associado a outros dados!");
        }

        request.setAttribute("idProduto", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("nome", "");
        request.setAttribute("descricao", "");
        request.setAttribute("preco", "");
        request.setAttribute("estoque", "");
        request.setAttribute("peso", "");
        request.setAttribute("categoriasIdCategoria", "");
        request.setAttribute("marcasIdMarca", "");

        encaminharParaPagina(request, response);
    }

    protected void cancelar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("idProduto", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("nome", "");
        request.setAttribute("descricao", "");
        request.setAttribute("preco", "");
        request.setAttribute("estoque", "");
        request.setAttribute("peso", "");
        request.setAttribute("categoriasIdCategoria", "");
        request.setAttribute("marcasIdMarca", "");
        request.setAttribute("mensagem", "");

        encaminharParaPagina(request, response);
    }

    /**
     * Busca lista de produtos E também as listas de categorias/marcas
     * (usadas para montar os dropdowns no formulário)
     */
    protected void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Produto> listaProdutos = objProdutoDao.buscarTodosProdutos();
        request.setAttribute("listaProdutos", listaProdutos);

        // Listas auxiliares para montar os <select> no JSP
        List<Categoria> listaCategorias = objCategoriaDao.buscarTodasCategorias();
        request.setAttribute("listaCategorias", listaCategorias);

        List<Marca> listaMarcas = objMarcaDao.buscarTodasMarcas();
        request.setAttribute("listaMarcas", listaMarcas);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroProduto.jsp");
        dispatcher.forward(request, response);
    }
}