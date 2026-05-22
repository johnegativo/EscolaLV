<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cadastro de Fornecedores - Loja Virtual</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}${URL_BASE}/css/Estilo.css">
    </head>
    <body>
        <!-- HEADER DE NAVEGAÇÃO -->
        <nav class="navbar">
            <div class="navbar-container">
                <a href="${pageContext.request.contextPath}${URL_BASE}/Index.jsp" class="navbar-brand">
                    🏪 Loja Virtual
                </a>
                <ul class="navbar-menu">
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/">Início</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/MarcaControlador">Marcas</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/CategoriaControlador">Categorias</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/TransportadoraControlador">Transportadoras</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/FornecedorControlador" class="active">Fornecedores</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/ClienteControlador">Clientes</a></li>
                </ul>
            </div>
        </nav>
        <!-- CONTAINER PRINCIPAL -->
        <div class="main-container">
            
            <!-- CABEÇALHO DA PÁGINA -->
            <div class="page-header">
                <h1>Gerenciamento de Fornecedores</h1>
                <p>Cadastre e gerencie os Fornecedores</p>
            </div>
        
        <div class="form-container">
            <form name="cadastro" method="get" action="${pageContext.request.contextPath}${URL_BASE}/FornecedorControlador">
                <input type="hidden" name="opcao" value="${empty opcao ? 'cadastrar' : opcao}">
                <input type="hidden" name="idFornecedor" value="${idFornecedor}">
                
                <div class="form-group">
                    <label>Nome:</label>
                    <input type="text" name="nome" value="${nome}" required/>
                </div>
                
                <div class="form-group">
                    <label>CNPJ:</label>
                    <input type="text" name="cnpj" value="${cnpj}" required/>
                </div>
                
                <div class="form-group">
                    <label>Telefone:</label>
                    <input type="text" name="telefone" value="${telefone}"/>
                </div>
                
                <div class="form-group">
                    <label>Email:</label>
                    <input type="email" name="email" value="${email}"/>
                </div>
                
                <div class="form-group">
                    <label>Endereço:</label>
                    <textarea name="endereco">${endereco}</textarea>
                </div>
                
                <input type="submit" value="Salvar" name="btnSalvar"/>
            </form>
            
            <form name="cancelar" method="get" action="${pageContext.request.contextPath}${URL_BASE}/FornecedorControlador" style="display: inline;">
                <input type="hidden" name="opcao" value="cancelar">
                <input type="submit" value="Cancelar" name="btnCancelar"/>
            </form>
        </div>
        
        <c:if test="${not empty mensagem}">
            <div class="mensagem">${mensagem}</div>
        </c:if>
        
        <table>
            <c:if test="${not empty listaFornecedores}">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>NOME</th>
                        <th>CNPJ</th>
                        <th>TELEFONE</th>
                        <th>EMAIL</th>
                        <th>ENDEREÇO</th>
                        <th>ALTERAR</th>
                        <th>EXCLUIR</th>
                    </tr>
                </thead>
            </c:if>
            <tbody>
                <c:forEach var="fornecedor" items="${listaFornecedores}">
                    <tr>
                        <td>${fornecedor.idFornecedor}</td>
                        <td>${fornecedor.nome}</td>
                        <td>${fornecedor.cnpj}</td>
                        <td>${fornecedor.telefone}</td>
                        <td>${fornecedor.email}</td>
                        <td>${fornecedor.endereco}</td>
                        
                        <td>
                            <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/FornecedorControlador">
                                <input type="hidden" name="idFornecedor" value="${fornecedor.idFornecedor}">
                                <input type="hidden" name="nome" value="${fornecedor.nome}">
                                <input type="hidden" name="cnpj" value="${fornecedor.cnpj}">
                                <input type="hidden" name="telefone" value="${fornecedor.telefone}">
                                <input type="hidden" name="email" value="${fornecedor.email}">
                                <input type="hidden" name="endereco" value="${fornecedor.endereco}">
                                <input type="hidden" name="opcao" value="enviarAlterar">
                                <button type="submit">ALTERAR</button>
                            </form>
                        </td>
                        
                        <td>
                            <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/FornecedorControlador">
                                <input type="hidden" name="idFornecedor" value="${fornecedor.idFornecedor}">
                                <input type="hidden" name="nome" value="${fornecedor.nome}">
                                <input type="hidden" name="cnpj" value="${fornecedor.cnpj}">
                                <input type="hidden" name="telefone" value="${fornecedor.telefone}">
                                <input type="hidden" name="email" value="${fornecedor.email}">
                                <input type="hidden" name="endereco" value="${fornecedor.endereco}">
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