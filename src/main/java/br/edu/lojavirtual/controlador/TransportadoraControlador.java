package br.edu.lojavirtual.controlador;

import br.edu.lojavirtual.modelo.dao.TransportadoraDao;
import br.edu.lojavirtual.modelo.entidade.Transportadora;
import br.edu.lojavirtual.servico.WebConstante;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH + "/TransportadoraControlador")
public class TransportadoraControlador extends HttpServlet {
    
    private Transportadora objTransportadora = new Transportadora();
    private TransportadoraDao objTransportadoraDao = new TransportadoraDao();
    
    private String nome = "";
    private String cnpj = "";
    private String telefone = "";
    private String prazoMedio = "";
    private String idTransportadora = "";
    
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
            
            idTransportadora = request.getParameter("idTransportadora");
            nome = request.getParameter("nome");
            cnpj = request.getParameter("cnpj");
            telefone = request.getParameter("telefone");
            prazoMedio = request.getParameter("prazoMedio");
            
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
        
        objTransportadora.setNome(nome);
        objTransportadora.setCnpj(cnpj);
        objTransportadora.setTelefone(telefone);
        
        // Converter prazo_medio para Integer (pode estar vazio)
        if (prazoMedio != null && !prazoMedio.isEmpty()) {
            objTransportadora.setPrazoMedio(Integer.valueOf(prazoMedio));
        } else {
            objTransportadora.setPrazoMedio(null);
        }
        
        objTransportadoraDao.salvar(objTransportadora);
        
        request.setAttribute("mensagem", "Transportadora cadastrada com sucesso!");
        encaminharParaPagina(request, response);
    }
    
    protected void enviarAlterar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("idTransportadora", idTransportadora);
        request.setAttribute("nome", nome);
        request.setAttribute("cnpj", cnpj);
        request.setAttribute("telefone", telefone);
        request.setAttribute("prazoMedio", prazoMedio);
        request.setAttribute("opcao", "confirmarAlterar");
        request.setAttribute("mensagem", "Edite os dados e clique em Salvar");
        
        encaminharParaPagina(request, response);
    }
    
    protected void confirmarAlterar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        objTransportadora.setIdTransportadora(Integer.valueOf(idTransportadora));
        objTransportadora.setNome(nome);
        objTransportadora.setCnpj(cnpj);
        objTransportadora.setTelefone(telefone);
        
        if (prazoMedio != null && !prazoMedio.isEmpty()) {
            objTransportadora.setPrazoMedio(Integer.valueOf(prazoMedio));
        } else {
            objTransportadora.setPrazoMedio(null);
        }
        
        objTransportadoraDao.alterar(objTransportadora);
        
        request.setAttribute("mensagem", "Transportadora alterada com sucesso!");
        cancelar(request, response);
    }
    
    protected void enviarExcluir(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("idTransportadora", idTransportadora);
        request.setAttribute("nome", nome);
        request.setAttribute("cnpj", cnpj);
        request.setAttribute("telefone", telefone);
        request.setAttribute("prazoMedio", prazoMedio);
        request.setAttribute("opcao", "confirmarExcluir");
        request.setAttribute("mensagem", "Confirme os dados e clique em Salvar para excluir");
        
        encaminharParaPagina(request, response);
    }
    
    protected void confirmarExcluir(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            objTransportadora.setIdTransportadora(Integer.valueOf(idTransportadora));
            
            boolean excluido = objTransportadoraDao.excluir(objTransportadora);
            
            if (excluido) {
                request.setAttribute("mensagem", "Transportadora excluída com sucesso!");
            } else {
                request.setAttribute("mensagem", "ERRO: Não foi possível excluir a transportadora. Ela pode estar sendo usada em pedidos.");
            }
            
        } catch (Exception e) {
            System.err.println("Erro ao excluir transportadora: " + e.getMessage());
            request.setAttribute("mensagem", "ERRO: Esta transportadora não pode ser excluída pois existem pedidos associados a ela!");
        }
        
        request.setAttribute("idTransportadora", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("nome", "");
        request.setAttribute("cnpj", "");
        request.setAttribute("telefone", "");
        request.setAttribute("prazoMedio", "");
        
        encaminharParaPagina(request, response);
    }
    
    protected void cancelar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("idTransportadora", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("nome", "");
        request.setAttribute("cnpj", "");
        request.setAttribute("telefone", "");
        request.setAttribute("prazoMedio", "");
        request.setAttribute("mensagem", "");
        
        encaminharParaPagina(request, response);
    }
    
    protected void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Transportadora> listaTransportadoras = objTransportadoraDao.buscarTodasTransportadoras();
        request.setAttribute("listaTransportadoras", listaTransportadoras);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroTransportadora.jsp");
        dispatcher.forward(request, response);
    }
}