package br.edu.lojavirtual.controlador;

import br.edu.lojavirtual.modelo.dao.ItemPedidoDao;
import br.edu.lojavirtual.modelo.dao.PedidoDao;
import br.edu.lojavirtual.modelo.dao.ProdutoDao;
import br.edu.lojavirtual.modelo.entidade.ItemPedido;
import br.edu.lojavirtual.modelo.entidade.Pedido;
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

@WebServlet(WebConstante.BASE_PATH + "/ItemPedidoControlador")
public class ItemPedidoControlador extends HttpServlet {

    private ItemPedido objItemPedido = new ItemPedido();
    private ItemPedidoDao objItemPedidoDao = new ItemPedidoDao();

    // DAOs auxiliares - usados só para alimentar os dropdowns
    private ProdutoDao objProdutoDao = new ProdutoDao();
    private PedidoDao objPedidoDao = new PedidoDao();

    private String idItensPedido = "";
    private String quantidade = "";
    private String produtosIdProduto = "";
    private String pedidosIdPedidos = "";

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

            idItensPedido = request.getParameter("idItensPedido");
            quantidade = request.getParameter("quantidade");
            produtosIdProduto = request.getParameter("produtosIdProduto");
            pedidosIdPedidos = request.getParameter("pedidosIdPedidos");

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
     * CADASTRAR - Insere novo item de pedido
     * ATENÇÃO: a trigger de estoque pode BLOQUEAR este INSERT se não houver
     * quantidade suficiente do produto. Por isso o try-catch é essencial aqui
     * (diferente das outras telas, onde o try-catch só aparece no excluir).
     */
    protected void cadastrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            objItemPedido.setQuantidade(Integer.valueOf(quantidade));
            objItemPedido.setProdutosIdProduto(Integer.valueOf(produtosIdProduto));
            objItemPedido.setPedidosIdPedidos(Integer.valueOf(pedidosIdPedidos));

            objItemPedidoDao.salvar(objItemPedido);

            request.setAttribute("mensagem", "Item adicionado ao pedido com sucesso! Preço e total foram calculados automaticamente.");

        } catch (RuntimeException e) {
            // Captura o erro lançado pela trigger de estoque (SIGNAL SQLSTATE '45000')
            // e por qualquer outra falha do banco neste INSERT
            System.err.println("Erro ao cadastrar item de pedido: " + e.getMessage());
            request.setAttribute("mensagem", "ERRO: Não foi possível adicionar o item. Estoque insuficiente para este produto.");
        }

        encaminharParaPagina(request, response);
    }

    protected void enviarAlterar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("idItensPedido", idItensPedido);
        request.setAttribute("quantidade", quantidade);
        request.setAttribute("produtosIdProduto", produtosIdProduto);
        request.setAttribute("pedidosIdPedidos", pedidosIdPedidos);
        request.setAttribute("opcao", "confirmarAlterar");
        request.setAttribute("mensagem", "Edite os dados e clique em Salvar");

        encaminharParaPagina(request, response);
    }

    /**
     * CONFIRMAR ALTERAR
     * ATENÇÃO: também pode falhar se a nova quantidade não fizer sentido
     * com o estoque disponível, então mantemos o try-catch aqui também
     */
    protected void confirmarAlterar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            objItemPedido.setIdItensPedido(Integer.valueOf(idItensPedido));
            objItemPedido.setQuantidade(Integer.valueOf(quantidade));
            objItemPedido.setProdutosIdProduto(Integer.valueOf(produtosIdProduto));
            objItemPedido.setPedidosIdPedidos(Integer.valueOf(pedidosIdPedidos));

            objItemPedidoDao.alterar(objItemPedido);

            request.setAttribute("mensagem", "Item de pedido alterado com sucesso!");

        } catch (RuntimeException e) {
            System.err.println("Erro ao alterar item de pedido: " + e.getMessage());
            request.setAttribute("mensagem", "ERRO: Não foi possível alterar o item. Verifique o estoque disponível.");
        }

        cancelar(request, response);
    }

    protected void enviarExcluir(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("idItensPedido", idItensPedido);
        request.setAttribute("quantidade", quantidade);
        request.setAttribute("produtosIdProduto", produtosIdProduto);
        request.setAttribute("pedidosIdPedidos", pedidosIdPedidos);
        request.setAttribute("opcao", "confirmarExcluir");
        request.setAttribute("mensagem", "Confirme os dados e clique em Salvar para excluir");

        encaminharParaPagina(request, response);
    }

    /**
     * CONFIRMAR EXCLUIR
     * Ao excluir, a trigger devolve a quantidade ao estoque automaticamente
     */
    protected void confirmarExcluir(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            objItemPedido.setIdItensPedido(Integer.valueOf(idItensPedido));

            boolean excluido = objItemPedidoDao.excluir(objItemPedido);

            if (excluido) {
                request.setAttribute("mensagem", "Item excluído com sucesso! O estoque do produto foi devolvido automaticamente.");
            } else {
                request.setAttribute("mensagem", "ERRO: Não foi possível excluir este item de pedido.");
            }

        } catch (Exception e) {
            System.err.println("Erro ao excluir item de pedido: " + e.getMessage());
            request.setAttribute("mensagem", "ERRO: Este item não pode ser excluído.");
        }

        request.setAttribute("idItensPedido", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("quantidade", "");
        request.setAttribute("produtosIdProduto", "");
        request.setAttribute("pedidosIdPedidos", "");

        encaminharParaPagina(request, response);
    }

    protected void cancelar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("idItensPedido", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("quantidade", "");
        request.setAttribute("produtosIdProduto", "");
        request.setAttribute("pedidosIdPedidos", "");
        request.setAttribute("mensagem", "");

        encaminharParaPagina(request, response);
    }

    /**
     * Busca lista de itens E também as listas de produtos/pedidos
     * (usadas para montar os dropdowns no formulário)
     */
    protected void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<ItemPedido> listaItensPedido = objItemPedidoDao.buscarTodosItensPedido();
        request.setAttribute("listaItensPedido", listaItensPedido);

        List<Produto> listaProdutos = objProdutoDao.buscarTodosProdutos();
        request.setAttribute("listaProdutos", listaProdutos);

        List<Pedido> listaPedidos = objPedidoDao.buscarTodosPedidos();
        request.setAttribute("listaPedidos", listaPedidos);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroItemPedido.jsp");
        dispatcher.forward(request, response);
    }
}