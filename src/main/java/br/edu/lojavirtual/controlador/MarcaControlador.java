package br.edu.lojavirtual.controlador;

import br.edu.lojavirtual.modelo.dao.MarcaDao;
import br.edu.lojavirtual.modelo.entidade.Marca;
import br.edu.lojavirtual.servico.WebConstante;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH + "/MarcaControlador")
public class MarcaControlador extends HttpServlet {

    // Objetos que serão usados nas operações
    private Marca objMarca = new Marca();
    private MarcaDao objMarcaDao = new MarcaDao();

// Variáveis para receber dados do formulário
    private String nome = "";
    private String descricao = "";
    private String paisOrigem = "";
    private String idMarca = "";

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

            // Pega os valores dos campos do formulário
            idMarca = request.getParameter("idMarca");
            nome = request.getParameter("nome");
            descricao = request.getParameter("descricao");
            paisOrigem = request.getParameter("paisOrigem");

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
    
    objMarca.setNome(nome);
    objMarca.setDescricao(descricao);
    objMarca.setPaisOrigem(paisOrigem);
    objMarcaDao.salvar(objMarca);
    
    request.setAttribute("mensagem", "Marca cadastrada com sucesso!");
    encaminharParaPagina(request, response);
}

    protected void enviarAlterar(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    request.setAttribute("idMarca", idMarca);
    request.setAttribute("nome", nome);
    request.setAttribute("descricao", descricao);
    request.setAttribute("paisOrigem", paisOrigem);
    request.setAttribute("opcao", "confirmarAlterar");
    request.setAttribute("mensagem", "Edite os dados e clique em Salvar");
    
    encaminharParaPagina(request, response);
}

    protected void confirmarAlterar(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    objMarca.setIdMarca(Integer.valueOf(idMarca));
    objMarca.setNome(nome);
    objMarca.setDescricao(descricao);
    objMarca.setPaisOrigem(paisOrigem);
    objMarcaDao.alterar(objMarca);
    
    request.setAttribute("mensagem", "Marca alterada com sucesso!");
    cancelar(request, response);
}

    protected void enviarExcluir(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    request.setAttribute("idMarca", idMarca);
    request.setAttribute("nome", nome);
    request.setAttribute("descricao", descricao);
    request.setAttribute("paisOrigem", paisOrigem);
    request.setAttribute("opcao", "confirmarExcluir");
    request.setAttribute("mensagem", "Confirme os dados e clique em Salvar para excluir");
    
    encaminharParaPagina(request, response);
}

    /**
     * CONFIRMAR EXCLUIR - Executa o DELETE no banco
     */
    protected void confirmarExcluir(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            objMarca.setIdMarca(Integer.valueOf(idMarca));

            // Tenta excluir e verifica se foi bem-sucedido
            boolean excluido = objMarcaDao.excluir(objMarca);

            if (excluido) {
                request.setAttribute("mensagem", "Marca excluída com sucesso!");
            } else {
                request.setAttribute("mensagem", "ERRO: Não foi possível excluir a marca. Ela pode estar sendo usada em produtos.");
            }

        } catch (Exception e) {
            // Captura erros de foreign key e outros
            System.err.println("Erro ao excluir marca: " + e.getMessage());
            request.setAttribute("mensagem", "ERRO: Esta marca não pode ser excluída pois existem produtos associados a ela!");
        }

        // Limpa o formulário e volta para modo cadastro
        request.setAttribute("idMarca", 0);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("nome", "");

        encaminharParaPagina(request, response);
    }

    protected void cancelar(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    request.setAttribute("idMarca", 0);
    request.setAttribute("opcao", "cadastrar");
    request.setAttribute("nome", "");
    request.setAttribute("descricao", "");
    request.setAttribute("paisOrigem", "");
    request.setAttribute("mensagem", "");
    
    encaminharParaPagina(request, response);
}

    protected void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Marca> listaMarcas = objMarcaDao.buscarTodasMarcas();
        request.setAttribute("listaMarcas", listaMarcas);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroMarca.jsp");
        dispatcher.forward(request, response);
    }
}
