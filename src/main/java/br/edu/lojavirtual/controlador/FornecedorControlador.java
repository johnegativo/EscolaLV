package br.edu.lojavirtual.controlador;

import br.edu.lojavirtual.modelo.dao.FornecedorDao;
import br.edu.lojavirtual.modelo.entidade.Fornecedor;
import br.edu.lojavirtual.servico.WebConstante;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH + "/FornecedorControlador")
public class FornecedorControlador extends HttpServlet {
    
    private Fornecedor objFornecedor = new Fornecedor();
    private FornecedorDao objFornecedorDao = new FornecedorDao();
    
    private String nome = "";
    private String telefone = "";
    private String email = "";
    private String cnpj = "";
    private String endereco = "";
    private String idFornecedor = "";
    
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
            
            idFornecedor = request.getParameter("idFornecedor");
            nome = request.getParameter("nome");
            telefone = request.getParameter("telefone");
            email = request.getParameter("email");
            cnpj = request.getParameter("cnpj");
            endereco = request.getParameter("endereco");
            
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
        
        objFornecedor.setNome(nome);
        objFornecedor.setTelefone(telefone);
        objFornecedor.setEmail(email);
        objFornecedor.setCnpj(cnpj);
        objFornecedor.setEndereco(endereco);
        
        objFornecedorDao.salvar(objFornecedor);
        
        request.setAttribute("mensagem", "Fornecedor cadastrado com sucesso!");
        encaminharParaPagina(request, response);
    }
    
    protected void enviarAlterar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("idFornecedor", idFornecedor);
        request.setAttribute("nome", nome);
        request.setAttribute("telefone", telefone);
        request.setAttribute("email", email);
        request.setAttribute("cnpj", cnpj);
        request.setAttribute("endereco", endereco);
        request.setAttribute("opcao", "confirmarAlterar");
        request.setAttribute("mensagem", "Edite os dados e clique em Salvar");
        
        encaminharParaPagina(request, response);
    }
    
    protected void confirmarAlterar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        objFornecedor.setIdFornecedor(Integer.valueOf(idFornecedor));
        objFornecedor.setNome(nome);
        objFornecedor.setTelefone(telefone);
        objFornecedor.setEmail(email);
        objFornecedor.setCnpj(cnpj);
        objFornecedor.setEndereco(endereco);
        
        objFornecedorDao.alterar(objFornecedor);
        
        request.setAttribute("mensagem", "Fornecedor alterado com sucesso!");
        cancelar(request, response);
    }
    
    protected void enviarExcluir(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("idFornecedor", idFornecedor);
        request.setAttribute("nome", nome);
        request.setAttribute("telefone", telefone);
        request.setAttribute("email", email);
        request.setAttribute("cnpj", cnpj);
        request.setAttribute("endereco", endereco);
        request.setAttribute("opcao", "confirmarExcluir");
        request.setAttribute("mensagem", "Confirme os dados e clique em Salvar para excluir");
        
        encaminharParaPagina(request, response);
    }
    
    protected void confirmarExcluir(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            objFornecedor.setIdFornecedor(Integer.valueOf(idFornecedor));
            
            boolean excluido = objFornecedorDao.excluir(objFornecedor);
            
            if (excluido) {
                request.setAttribute("mensagem", "Fornecedor excluído com sucesso!");
            } else {
                request.setAttribute("mensagem", "ERRO: Não foi possível excluir o fornecedor. Ele pode estar sendo usado em produtos.");
            }
            
        } catch (Exception e) {
            System.err.println("Erro ao excluir fornecedor: " + e.getMessage());
            request.setAttribute("mensagem", "ERRO: Este fornecedor não pode ser excluído pois existem produtos associados a ele!");
        }
        
        request.setAttribute("idFornecedor", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("nome", "");
        request.setAttribute("telefone", "");
        request.setAttribute("email", "");
        request.setAttribute("cnpj", "");
        request.setAttribute("endereco", "");
        
        encaminharParaPagina(request, response);
    }
    
    protected void cancelar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("idFornecedor", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("nome", "");
        request.setAttribute("telefone", "");
        request.setAttribute("email", "");
        request.setAttribute("cnpj", "");
        request.setAttribute("endereco", "");
        request.setAttribute("mensagem", "");
        
        encaminharParaPagina(request, response);
    }
    
    protected void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Fornecedor> listaFornecedores = objFornecedorDao.buscarTodosFornecedores();
        request.setAttribute("listaFornecedores", listaFornecedores);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroFornecedor.jsp");
        dispatcher.forward(request, response);
    }
}