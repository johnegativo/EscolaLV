package br.edu.lojavirtual.controlador;

import br.edu.lojavirtual.modelo.dao.CategoriaDao;
import br.edu.lojavirtual.modelo.entidade.Categoria;
import br.edu.lojavirtual.servico.WebConstante;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH + "/CategoriaControlador")
public class CategoriaControlador extends HttpServlet {
    
    private Categoria objCategoria = new Categoria();
    private CategoriaDao objCategoriaDao = new CategoriaDao();
    
    private String nome = "";
    private String descricao = "";
    private String idCategoria = "";
    
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
            
            idCategoria = request.getParameter("idCategoria");
            nome = request.getParameter("nome");
            descricao = request.getParameter("descricao");
            
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
        
        objCategoria.setNome(nome);
        objCategoria.setDescricao(descricao);
        objCategoriaDao.salvar(objCategoria);
        
        request.setAttribute("mensagem", "Categoria cadastrada com sucesso!");
        encaminharParaPagina(request, response);
    }
    
    protected void enviarAlterar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("idCategoria", idCategoria);
        request.setAttribute("nome", nome);
        request.setAttribute("descricao", descricao);
        request.setAttribute("opcao", "confirmarAlterar");
        request.setAttribute("mensagem", "Edite os dados e clique em Salvar");
        
        encaminharParaPagina(request, response);
    }
    
    protected void confirmarAlterar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        objCategoria.setIdCategoria(Integer.valueOf(idCategoria));
        objCategoria.setNome(nome);
        objCategoria.setDescricao(descricao);
        objCategoriaDao.alterar(objCategoria);
        
        request.setAttribute("mensagem", "Categoria alterada com sucesso!");
        cancelar(request, response);
    }
    
    protected void enviarExcluir(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("idCategoria", idCategoria);
        request.setAttribute("nome", nome);
        request.setAttribute("descricao", descricao);
        request.setAttribute("opcao", "confirmarExcluir");
        request.setAttribute("mensagem", "Confirme os dados e clique em Salvar para excluir");
        
        encaminharParaPagina(request, response);
    }
    
    protected void confirmarExcluir(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            objCategoria.setIdCategoria(Integer.valueOf(idCategoria));
            
            boolean excluido = objCategoriaDao.excluir(objCategoria);
            
            if (excluido) {
                request.setAttribute("mensagem", "Categoria excluída com sucesso!");
            } else {
                request.setAttribute("mensagem", "ERRO: Não foi possível excluir a categoria. Ela pode estar sendo usada em produtos.");
            }
            
        } catch (Exception e) {
            System.err.println("Erro ao excluir categoria: " + e.getMessage());
            request.setAttribute("mensagem", "ERRO: Esta categoria não pode ser excluída pois existem produtos associados a ela!");
        }
        
        request.setAttribute("idCategoria", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("nome", "");
        request.setAttribute("descricao", "");
        
        encaminharParaPagina(request, response);
    }
    
    protected void cancelar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("idCategoria", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("nome", "");
        request.setAttribute("descricao", "");
        request.setAttribute("mensagem", "");
        
        encaminharParaPagina(request, response);
    }
    
    protected void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Categoria> listaCategorias = objCategoriaDao.buscarTodasCategorias();
        request.setAttribute("listaCategorias", listaCategorias);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroCategoria.jsp");
        dispatcher.forward(request, response);
    }
}