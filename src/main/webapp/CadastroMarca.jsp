<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cadastro de Marcas - Loja Virtual</title>
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
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/MarcaControlador" class="active">Marcas</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/CategoriaControlador">Categorias</a></li>
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
                <h1>Gerenciamento de Marcas</h1>
                <p>Cadastre e gerencie as Marcas</p>
            </div>
       
            <div class="form-container">
                <form name="cadastro" method="get" action="${pageContext.request.contextPath}${URL_BASE}/MarcaControlador">
                    <input type="hidden" name="opcao" value="${empty opcao ? 'cadastrar' : opcao}">
                    <input type="hidden" name="idMarca" value="${idMarca}">
                   
                    <div class="form-group">
                        <label>Nome da Marca:</label>
                        <input type="text" name="nome" value="${nome}" required/>
                    </div>
                   
                    <div class="form-group">
                        <label>Descrição:</label>
                        <textarea name="descricao" rows="3">${descricao}</textarea>
                    </div>
                   
                    <div class="form-group">
                        <label>País de Origem:</label>
                        <input type="text" name="paisOrigem" value="${paisOrigem}"/>
                    </div>
                   
                    <input type="submit" value="Salvar" name="btnSalvar"/>
                </form>
               
                <form name="cancelar" method="get" action="${pageContext.request.contextPath}${URL_BASE}/MarcaControlador" style="display: inline;">
                    <input type="hidden" name="opcao" value="cancelar">
                    <input type="submit" value="Cancelar" name="btnCancelar"/>
                </form>
            </div>
           
            <c:if test="${not empty mensagem}">
                <div class="mensagem">${mensagem}</div>
            </c:if>
           
            <!-- Tabela com Lista de Marcas -->
            <table>
                <c:if test="${not empty listaMarcas}">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>NOME</th>
                            <th>DESCRIÇÃO</th>
                            <th>PAÍS DE ORIGEM</th>
                            <th>ALTERAR</th>
                            <th>EXCLUIR</th>
                        </tr>
                    </thead>
                </c:if>
                <tbody>
                    <c:forEach var="marca" items="${listaMarcas}">
                        <tr>
                            <td>${marca.idMarca}</td>
                            <td>${marca.nome}</td>
                            <td>${marca.descricao}</td>
                            <td>${marca.paisOrigem}</td>
                           
                            <!-- Botão Alterar -->
                            <td>
                                <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/MarcaControlador">
                                    <input type="hidden" name="idMarca" value="${marca.idMarca}">
                                    <input type="hidden" name="nome" value="${marca.nome}">
                                    <input type="hidden" name="descricao" value="${marca.descricao}">
                                    <input type="hidden" name="paisOrigem" value="${marca.paisOrigem}">
                                    <input type="hidden" name="opcao" value="enviarAlterar">
                                    <button type="submit">ALTERAR</button>
                                </form>
                            </td>
                           
                            <!-- Botão Excluir -->
                            <td>
                                <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/MarcaControlador">
                                    <input type="hidden" name="idMarca" value="${marca.idMarca}">
                                    <input type="hidden" name="nome" value="${marca.nome}">
                                    <input type="hidden" name="descricao" value="${marca.descricao}">
                                    <input type="hidden" name="paisOrigem" value="${marca.paisOrigem}">
                                    <input type="hidden" name="opcao" value="enviarExcluir">
                                    <button type="submit" class="btn-excluir">EXCLUIR</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>