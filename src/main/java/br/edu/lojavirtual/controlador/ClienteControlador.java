package br.edu.lojavirtual.controlador;

import br.edu.lojavirtual.modelo.dao.ClienteDao;
import br.edu.lojavirtual.modelo.entidade.Cliente;
import br.edu.lojavirtual.servico.WebConstante;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH + "/ClienteControlador")
public class ClienteControlador extends HttpServlet {
    
    private Cliente objCliente = new Cliente();
    private ClienteDao objClienteDao = new ClienteDao();
    
    private String nome = "";
    private String email = "";
    private String senha = "";
    private String cpfCnpj = "";
    private String telefone = "";
    private String dataCadastro = "";
    private String dataNascimento = "";
    private String idCliente = "";
    
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
            
            idCliente = request.getParameter("idCliente");
            nome = request.getParameter("nome");
            email = request.getParameter("email");
            senha = request.getParameter("senha");
            cpfCnpj = request.getParameter("cpfCnpj");
            telefone = request.getParameter("telefone");
            dataCadastro = request.getParameter("dataCadastro");
            dataNascimento = request.getParameter("dataNascimento");
            
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
        
        objCliente.setNome(nome);
        objCliente.setEmail(email);
        objCliente.setSenha(senha);
        objCliente.setCpfCnpj(cpfCnpj);
        objCliente.setTelefone(telefone);
        
        // Se data de cadastro não foi informada, usa a data atual
        if (dataCadastro == null || dataCadastro.isEmpty()) {
            objCliente.setDataCadastro(LocalDate.now().toString());
        } else {
            objCliente.setDataCadastro(dataCadastro);
        }
        
        objCliente.setDataNascimento(dataNascimento);
        
        objClienteDao.salvar(objCliente);
        
        request.setAttribute("mensagem", "Cliente cadastrado com sucesso!");
        encaminharParaPagina(request, response);
    }
    
    protected void enviarAlterar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("idCliente", idCliente);
        request.setAttribute("nome", nome);
        request.setAttribute("email", email);
        request.setAttribute("senha", senha);
        request.setAttribute("cpfCnpj", cpfCnpj);
        request.setAttribute("telefone", telefone);
        request.setAttribute("dataCadastro", dataCadastro);
        request.setAttribute("dataNascimento", dataNascimento);
        request.setAttribute("opcao", "confirmarAlterar");
        request.setAttribute("mensagem", "Edite os dados e clique em Salvar");
        
        encaminharParaPagina(request, response);
    }
    
    protected void confirmarAlterar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        objCliente.setIdCliente(Integer.valueOf(idCliente));
        objCliente.setNome(nome);
        objCliente.setEmail(email);
        objCliente.setSenha(senha);
        objCliente.setCpfCnpj(cpfCnpj);
        objCliente.setTelefone(telefone);
        objCliente.setDataCadastro(dataCadastro);
        objCliente.setDataNascimento(dataNascimento);
        
        objClienteDao.alterar(objCliente);
        
        request.setAttribute("mensagem", "Cliente alterado com sucesso!");
        cancelar(request, response);
    }
    
    protected void enviarExcluir(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("idCliente", idCliente);
        request.setAttribute("nome", nome);
        request.setAttribute("email", email);
        request.setAttribute("senha", senha);
        request.setAttribute("cpfCnpj", cpfCnpj);
        request.setAttribute("telefone", telefone);
        request.setAttribute("dataCadastro", dataCadastro);
        request.setAttribute("dataNascimento", dataNascimento);
        request.setAttribute("opcao", "confirmarExcluir");
        request.setAttribute("mensagem", "Confirme os dados e clique em Salvar para excluir");
        
        encaminharParaPagina(request, response);
    }
    
    protected void confirmarExcluir(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            objCliente.setIdCliente(Integer.valueOf(idCliente));
            
            boolean excluido = objClienteDao.excluir(objCliente);
            
            if (excluido) {
                request.setAttribute("mensagem", "Cliente excluído com sucesso!");
            } else {
                request.setAttribute("mensagem", "ERRO: Não foi possível excluir o cliente. Ele pode ter pedidos ou avaliações associados.");
            }
            
        } catch (Exception e) {
            System.err.println("Erro ao excluir cliente: " + e.getMessage());
            request.setAttribute("mensagem", "ERRO: Este cliente não pode ser excluído pois possui pedidos ou avaliações!");
        }
        
        request.setAttribute("idCliente", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("nome", "");
        request.setAttribute("email", "");
        request.setAttribute("senha", "");
        request.setAttribute("cpfCnpj", "");
        request.setAttribute("telefone", "");
        request.setAttribute("dataCadastro", "");
        request.setAttribute("dataNascimento", "");
        
        encaminharParaPagina(request, response);
    }
    
    protected void cancelar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("idCliente", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("nome", "");
        request.setAttribute("email", "");
        request.setAttribute("senha", "");
        request.setAttribute("cpfCnpj", "");
        request.setAttribute("telefone", "");
        request.setAttribute("dataCadastro", "");
        request.setAttribute("dataNascimento", "");
        request.setAttribute("mensagem", "");
        
        encaminharParaPagina(request, response);
    }
    
    protected void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Cliente> listaClientes = objClienteDao.buscarTodosClientes();
        request.setAttribute("listaClientes", listaClientes);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroCliente.jsp");
        dispatcher.forward(request, response);
    }
}