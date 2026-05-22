<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cadastro de Categorias - Loja Virtual</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}${URL_BASE}/css/Estilo.css">
    </head>
    <body>
        <!-- HEADER DE NAVEGAÇÃO -->
        <nav class="navbar">
            <div class="navbar-container">
                <a href="${pageContext.request.contextPath}${URL_BASE}/" class="navbar-brand">
                    🏪 Loja Virtual
                </a>
                <ul class="navbar-menu">
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/Index.jsp">Início</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/MarcaControlador">Marcas</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/CategoriaControlador" class="active">Categorias</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/TransportadoraControlador">Transportadoras</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/FornecedorControlador">Fornecedores</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/ClienteControlador">Clientes</a></li>
                </ul>
            </div>
        </nav>
        <!-- CONTAINER PRINCIPAL -->
        <div class="main-container">
            
            <!-- CABEÇALHO DA PÁGINA -->
            <div class="page-header">
                <h1>Gerenciamento de Categorias</h1>
                <p>Cadastre e gerencie as Categorias</p>
            </div>
        
        <div class="form-container">
            <form name="cadastro" method="get" action="${pageContext.request.contextPath}/CategoriaControlador">
                <input type="hidden" name="opcao" value="${empty opcao ? 'cadastrar' : opcao}">
                <input type="hidden" name="idCategoria" value="${idCategoria}">
                
                <div class="form-group">
                    <label>Nome da Categoria:</label>
                    <input type="text" name="nome" value="${nome}" required/>
                </div>
                
                <div class="form-group">
                    <label>Descrição:</label>
                    <textarea name="descricao">${descricao}</textarea>
                </div>
                
                <input type="submit" value="Salvar" name="btnSalvar"/>
            </form>
            
            <form name="cancelar" method="get" action="${pageContext.request.contextPath}/Factor/CategoriaControlador" style="display: inline;">
                <input type="hidden" name="opcao" value="cancelar">
                <input type="submit" value="Cancelar" name="btnCancelar"/>
            </form>
        </div>
        
        <c:if test="${not empty mensagem}">
            <div class="mensagem">${mensagem}</div>
        </c:if>
        
        <table>
            <c:if test="${not empty listaCategorias}">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>NOME</th>
                        <th>DESCRIÇÃO</th>
                        <th>ALTERAR</th>
                        <th>EXCLUIR</th>
                    </tr>
                </thead>
            </c:if>
            <tbody>
                <c:forEach var="categoria" items="${listaCategorias}">
                    <tr>
                        <td>${categoria.idCategoria}</td>
                        <td>${categoria.nome}</td>
                        <td>${categoria.descricao}</td>
                        
                        <td>
                            <form method="get" action="${pageContext.request.contextPath}/CategoriaControlador">
                                <input type="hidden" name="idCategoria" value="${categoria.idCategoria}">
                                <input type="hidden" name="nome" value="${categoria.nome}">
                                <input type="hidden" name="descricao" value="${categoria.descricao}">
                                <input type="hidden" name="opcao" value="enviarAlterar">
                                <button type="submit">ALTERAR</button>
                            </form>
                        </td>
                        
                        <td>
                            <form method="get" action="${pageContext.request.contextPath}/CategoriaControlador">
                                <input type="hidden" name="idCategoria" value="${categoria.idCategoria}">
                                <input type="hidden" name="nome" value="${categoria.nome}">
                                <input type="hidden" name="descricao" value="${categoria.descricao}">
                                <input type="hidden" name="opcao" value="enviarExcluir">
                                <button type="submit" class="btn-excluir">EXCLUIR</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>