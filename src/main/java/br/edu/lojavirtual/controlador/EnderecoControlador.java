package br.edu.lojavirtual.controlador;

import br.edu.lojavirtual.modelo.dao.ClienteDao;
import br.edu.lojavirtual.modelo.dao.EnderecoDao;
import br.edu.lojavirtual.modelo.entidade.Cliente;
import br.edu.lojavirtual.modelo.entidade.Endereco;
import br.edu.lojavirtual.servico.WebConstante;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH + "/EnderecoControlador")
public class EnderecoControlador extends HttpServlet {

    private Endereco objEndereco = new Endereco();
    private EnderecoDao objEnderecoDao = new EnderecoDao();

    // DAO auxiliar - usado só para alimentar o dropdown de clientes
    private ClienteDao objClienteDao = new ClienteDao();

    private String idEndereco = "";
    private String cep = "";
    private String rua = "";
    private String numero = "";
    private String bairro = "";
    private String cidade = "";
    private String estado = "";
    private String clientesIdCliente = "";

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

            idEndereco = request.getParameter("idEndereco");
            cep = request.getParameter("cep");
            rua = request.getParameter("rua");
            numero = request.getParameter("numero");
            bairro = request.getParameter("bairro");
            cidade = request.getParameter("cidade");
            estado = request.getParameter("estado");
            clientesIdCliente = request.getParameter("clientesIdCliente");

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

    protected void cadastrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        objEndereco.setCep(cep);
        objEndereco.setRua(rua);
        objEndereco.setNumero(numero);
        objEndereco.setBairro(bairro);
        objEndereco.setCidade(cidade);
        objEndereco.setEstado(estado);
        objEndereco.setClientesIdCliente(Integer.valueOf(clientesIdCliente));

        objEnderecoDao.salvar(objEndereco);

        request.setAttribute("mensagem", "Endereço cadastrado com sucesso!");
        encaminharParaPagina(request, response);
    }

    protected void enviarAlterar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("idEndereco", idEndereco);
        request.setAttribute("cep", cep);
        request.setAttribute("rua", rua);
        request.setAttribute("numero", numero);
        request.setAttribute("bairro", bairro);
        request.setAttribute("cidade", cidade);
        request.setAttribute("estado", estado);
        request.setAttribute("clientesIdCliente", clientesIdCliente);
        request.setAttribute("opcao", "confirmarAlterar");
        request.setAttribute("mensagem", "Edite os dados e clique em Salvar");

        encaminharParaPagina(request, response);
    }

    protected void confirmarAlterar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        objEndereco.setIdEndereco(Integer.valueOf(idEndereco));
        objEndereco.setCep(cep);
        objEndereco.setRua(rua);
        objEndereco.setNumero(numero);
        objEndereco.setBairro(bairro);
        objEndereco.setCidade(cidade);
        objEndereco.setEstado(estado);
        objEndereco.setClientesIdCliente(Integer.valueOf(clientesIdCliente));

        objEnderecoDao.alterar(objEndereco);

        request.setAttribute("mensagem", "Endereço alterado com sucesso!");
        cancelar(request, response);
    }

    protected void enviarExcluir(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("idEndereco", idEndereco);
        request.setAttribute("cep", cep);
        request.setAttribute("rua", rua);
        request.setAttribute("numero", numero);
        request.setAttribute("bairro", bairro);
        request.setAttribute("cidade", cidade);
        request.setAttribute("estado", estado);
        request.setAttribute("clientesIdCliente", clientesIdCliente);
        request.setAttribute("opcao", "confirmarExcluir");
        request.setAttribute("mensagem", "Confirme os dados e clique em Salvar para excluir");

        encaminharParaPagina(request, response);
    }

    /**
     * CONFIRMAR EXCLUIR
     * ATENÇÃO: enderecos é referenciado por pedidos. Se o endereço já tiver
     * pedidos associados, vai falhar por FK
     */
    protected void confirmarExcluir(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            objEndereco.setIdEndereco(Integer.valueOf(idEndereco));

            boolean excluido = objEnderecoDao.excluir(objEndereco);

            if (excluido) {
                request.setAttribute("mensagem", "Endereço excluído com sucesso!");
            } else {
                request.setAttribute("mensagem", "ERRO: Não foi possível excluir. Este endereço pode estar associado a pedidos.");
            }

        } catch (Exception e) {
            System.err.println("Erro ao excluir endereco: " + e.getMessage());
            request.setAttribute("mensagem", "ERRO: Este endereço não pode ser excluído pois está associado a pedidos!");
        }

        request.setAttribute("idEndereco", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("cep", "");
        request.setAttribute("rua", "");
        request.setAttribute("numero", "");
        request.setAttribute("bairro", "");
        request.setAttribute("cidade", "");
        request.setAttribute("estado", "");
        request.setAttribute("clientesIdCliente", "");

        encaminharParaPagina(request, response);
    }

    protected void cancelar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("idEndereco", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("cep", "");
        request.setAttribute("rua", "");
        request.setAttribute("numero", "");
        request.setAttribute("bairro", "");
        request.setAttribute("cidade", "");
        request.setAttribute("estado", "");
        request.setAttribute("clientesIdCliente", "");
        request.setAttribute("mensagem", "");

        encaminharParaPagina(request, response);
    }

    protected void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Endereco> listaEnderecos = objEnderecoDao.buscarTodosEnderecos();
        request.setAttribute("listaEnderecos", listaEnderecos);

        // Lista auxiliar para montar o <select> de clientes no JSP
        List<Cliente> listaClientes = objClienteDao.buscarTodosClientes();
        request.setAttribute("listaClientes", listaClientes);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroEndereco.jsp");
        dispatcher.forward(request, response);
    }
}