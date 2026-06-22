package br.edu.lojavirtual.controlador;

import br.edu.lojavirtual.modelo.dao.PagamentoDao;
import br.edu.lojavirtual.modelo.dao.PedidoDao;
import br.edu.lojavirtual.modelo.entidade.Pagamento;
import br.edu.lojavirtual.modelo.entidade.Pedido;
import br.edu.lojavirtual.servico.WebConstante;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH + "/PagamentoControlador")
public class PagamentoControlador extends HttpServlet {

    private Pagamento objPagamento = new Pagamento();
    private PagamentoDao objPagamentoDao = new PagamentoDao();

    // DAO auxiliar - usado só para alimentar o dropdown de pedidos
    private PedidoDao objPedidoDao = new PedidoDao();

    private String idPagamento = "";
    private String metodo = "";
    private String status = "";
    private String data = "";
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

            idPagamento = request.getParameter("idPagamento");
            metodo = request.getParameter("metodo");
            status = request.getParameter("status");
            data = request.getParameter("data");
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
     * CADASTRAR - Insere novo pagamento
     * ATENÇÃO: se status = 'Aprovado', a trigger tri_status_pedido_pagamento
     * muda automaticamente o status do pedido relacionado para 'Pago'
     */
    protected void cadastrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            objPagamento.setMetodo(metodo);
            objPagamento.setStatus(status);
            objPagamento.setData(data);
            objPagamento.setPedidosIdPedidos(Integer.valueOf(pedidosIdPedidos));

            objPagamentoDao.salvar(objPagamento);

            request.setAttribute("mensagem", "Pagamento cadastrado com sucesso! O valor foi calculado automaticamente a partir do total do pedido.");

        } catch (RuntimeException e) {
            System.err.println("Erro ao cadastrar pagamento: " + e.getMessage());
            request.setAttribute("mensagem", "ERRO: Não foi possível cadastrar o pagamento.");
        }

        encaminharParaPagina(request, response);
    }

    protected void enviarAlterar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("idPagamento", idPagamento);
        request.setAttribute("metodo", metodo);
        request.setAttribute("status", status);
        request.setAttribute("data", data);
        request.setAttribute("pedidosIdPedidos", pedidosIdPedidos);
        request.setAttribute("opcao", "confirmarAlterar");
        request.setAttribute("mensagem", "Edite os dados e clique em Salvar");

        encaminharParaPagina(request, response);
    }

    protected void confirmarAlterar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        objPagamento.setIdPagamento(Integer.valueOf(idPagamento));
        objPagamento.setMetodo(metodo);
        objPagamento.setStatus(status);
        objPagamento.setData(data);
        objPagamento.setPedidosIdPedidos(Integer.valueOf(pedidosIdPedidos));

        objPagamentoDao.alterar(objPagamento);

        request.setAttribute("mensagem", "Pagamento alterado com sucesso!");
        cancelar(request, response);
    }

    protected void enviarExcluir(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("idPagamento", idPagamento);
        request.setAttribute("metodo", metodo);
        request.setAttribute("status", status);
        request.setAttribute("data", data);
        request.setAttribute("pedidosIdPedidos", pedidosIdPedidos);
        request.setAttribute("opcao", "confirmarExcluir");
        request.setAttribute("mensagem", "Confirme os dados e clique em Salvar para excluir");

        encaminharParaPagina(request, response);
    }

    /**
     * CONFIRMAR EXCLUIR
     * ATENÇÃO: pagamentos é referenciado por reembolsos.
     */
    protected void confirmarExcluir(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            objPagamento.setIdPagamento(Integer.valueOf(idPagamento));

            boolean excluido = objPagamentoDao.excluir(objPagamento);

            if (excluido) {
                request.setAttribute("mensagem", "Pagamento excluído com sucesso!");
            } else {
                request.setAttribute("mensagem", "ERRO: Não foi possível excluir. Este pagamento pode estar associado a um reembolso.");
            }

        } catch (Exception e) {
            System.err.println("Erro ao excluir pagamento: " + e.getMessage());
            request.setAttribute("mensagem", "ERRO: Este pagamento não pode ser excluído pois está associado a outros dados!");
        }

        request.setAttribute("idPagamento", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("metodo", "");
        request.setAttribute("status", "");
        request.setAttribute("data", "");
        request.setAttribute("pedidosIdPedidos", "");

        encaminharParaPagina(request, response);
    }

    protected void cancelar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("idPagamento", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("metodo", "");
        request.setAttribute("status", "");
        request.setAttribute("data", "");
        request.setAttribute("pedidosIdPedidos", "");
        request.setAttribute("mensagem", "");

        encaminharParaPagina(request, response);
    }

    protected void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Pagamento> listaPagamentos = objPagamentoDao.buscarTodosPagamentos();
        request.setAttribute("listaPagamentos", listaPagamentos);

        List<Pedido> listaPedidos = objPedidoDao.buscarTodosPedidos();
        request.setAttribute("listaPedidos", listaPedidos);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroPagamento.jsp");
        dispatcher.forward(request, response);
    }
}