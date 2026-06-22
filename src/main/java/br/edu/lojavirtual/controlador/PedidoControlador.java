package br.edu.lojavirtual.controlador;

import br.edu.lojavirtual.modelo.dao.ClienteDao;
import br.edu.lojavirtual.modelo.dao.EnderecoDao;
import br.edu.lojavirtual.modelo.dao.PedidoDao;
import br.edu.lojavirtual.modelo.entidade.Cliente;
import br.edu.lojavirtual.modelo.entidade.Endereco;
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

@WebServlet(WebConstante.BASE_PATH + "/PedidoControlador")
public class PedidoControlador extends HttpServlet {

    private Pedido objPedido = new Pedido();
    private PedidoDao objPedidoDao = new PedidoDao();

    // DAOs auxiliares - usados só para alimentar os dropdowns
    private ClienteDao objClienteDao = new ClienteDao();
    private EnderecoDao objEnderecoDao = new EnderecoDao();

    private String idPedidos = "";
    private String data = "";
    private String valorTotal = "";
    private String status = "";
    private String clientesIdCliente = "";
    private String enderecosIdEndereco = "";

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

            idPedidos = request.getParameter("idPedidos");
            data = request.getParameter("data");
            valorTotal = request.getParameter("valorTotal");
            status = request.getParameter("status");
            clientesIdCliente = request.getParameter("clientesIdCliente");
            enderecosIdEndereco = request.getParameter("enderecosIdEndereco");

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
     * CADASTRAR - Insere novo pedido
     * ATENÇÃO: valorTotal começa em 0 (ou o que for digitado) e será
     * recalculado automaticamente quando itens forem adicionados ao pedido
     */
    protected void cadastrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        objPedido.setData(data);
        objPedido.setValorTotal(valorTotal == null || valorTotal.isEmpty() ? 0.0 : Double.valueOf(valorTotal));
        objPedido.setStatus(status);
        objPedido.setClientesIdCliente(Integer.valueOf(clientesIdCliente));
        objPedido.setEnderecosIdEndereco(Integer.valueOf(enderecosIdEndereco));

        objPedidoDao.salvar(objPedido);

        request.setAttribute("mensagem", "Pedido cadastrado com sucesso! Adicione os itens do pedido a seguir.");
        encaminharParaPagina(request, response);
    }

    protected void enviarAlterar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("idPedidos", idPedidos);
        request.setAttribute("data", data);
        request.setAttribute("valorTotal", valorTotal);
        request.setAttribute("status", status);
        request.setAttribute("clientesIdCliente", clientesIdCliente);
        request.setAttribute("enderecosIdEndereco", enderecosIdEndereco);
        request.setAttribute("opcao", "confirmarAlterar");
        request.setAttribute("mensagem", "Edite os dados e clique em Salvar");

        encaminharParaPagina(request, response);
    }

    /**
     * CONFIRMAR ALTERAR
     * ATENÇÃO: se o status for alterado para "Cancelado", a trigger
     * tri_reembolso_automatico age sozinha (cria reembolso e devolve estoque)
     */
    protected void confirmarAlterar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        objPedido.setIdPedidos(Integer.valueOf(idPedidos));
        objPedido.setData(data);
        objPedido.setValorTotal(valorTotal == null || valorTotal.isEmpty() ? 0.0 : Double.valueOf(valorTotal));
        objPedido.setStatus(status);
        objPedido.setClientesIdCliente(Integer.valueOf(clientesIdCliente));
        objPedido.setEnderecosIdEndereco(Integer.valueOf(enderecosIdEndereco));

        objPedidoDao.alterar(objPedido);

        request.setAttribute("mensagem", "Pedido alterado com sucesso!");
        cancelar(request, response);
    }

    protected void enviarExcluir(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("idPedidos", idPedidos);
        request.setAttribute("data", data);
        request.setAttribute("valorTotal", valorTotal);
        request.setAttribute("status", status);
        request.setAttribute("clientesIdCliente", clientesIdCliente);
        request.setAttribute("enderecosIdEndereco", enderecosIdEndereco);
        request.setAttribute("opcao", "confirmarExcluir");
        request.setAttribute("mensagem", "Confirme os dados e clique em Salvar para excluir");

        encaminharParaPagina(request, response);
    }

    /**
     * CONFIRMAR EXCLUIR
     * ATENÇÃO: pedidos é referenciado por itens_pedido, pagamentos e reembolsos.
     * É bem provável que falhe por FK se o pedido já tiver itens ou pagamento.
     */
    protected void confirmarExcluir(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            objPedido.setIdPedidos(Integer.valueOf(idPedidos));

            boolean excluido = objPedidoDao.excluir(objPedido);

            if (excluido) {
                request.setAttribute("mensagem", "Pedido excluído com sucesso!");
            } else {
                request.setAttribute("mensagem", "ERRO: Não foi possível excluir. Este pedido pode ter itens, pagamentos ou reembolsos associados.");
            }

        } catch (Exception e) {
            System.err.println("Erro ao excluir pedido: " + e.getMessage());
            request.setAttribute("mensagem", "ERRO: Este pedido não pode ser excluído pois está associado a outros dados!");
        }

        request.setAttribute("idPedidos", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("data", "");
        request.setAttribute("valorTotal", "");
        request.setAttribute("status", "");
        request.setAttribute("clientesIdCliente", "");
        request.setAttribute("enderecosIdEndereco", "");

        encaminharParaPagina(request, response);
    }

    protected void cancelar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("idPedidos", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("data", "");
        request.setAttribute("valorTotal", "");
        request.setAttribute("status", "");
        request.setAttribute("clientesIdCliente", "");
        request.setAttribute("enderecosIdEndereco", "");
        request.setAttribute("mensagem", "");

        encaminharParaPagina(request, response);
    }

    /**
     * Busca lista de pedidos E também as listas de clientes/enderecos
     * (usadas para montar os dropdowns no formulário)
     */
    protected void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Pedido> listaPedidos = objPedidoDao.buscarTodosPedidos();
        request.setAttribute("listaPedidos", listaPedidos);

        List<Cliente> listaClientes = objClienteDao.buscarTodosClientes();
        request.setAttribute("listaClientes", listaClientes);

        List<Endereco> listaEnderecos = objEnderecoDao.buscarTodosEnderecos();
        request.setAttribute("listaEnderecos", listaEnderecos);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroPedido.jsp");
        dispatcher.forward(request, response);
    }
}