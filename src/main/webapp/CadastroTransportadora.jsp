<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cadastro de Transportadoras - Loja Virtual</title>
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
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/CategoriaControlador">Categorias</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/TransportadoraControlador" class="active">Transportadoras</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/FornecedorControlador">Fornecedores</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/ClienteControlador">Clientes</a></li>
                </ul>
            </div>
        </nav>
        <!-- CONTAINER PRINCIPAL -->
        <div class="main-container">
            
            <!-- CABEÇALHO DA PÁGINA -->
            <div class="page-header">
                <h1>Gerenciamento de Transportadoras</h1>
                <p>Cadastre e gerencie as transportadoras dos produtos</p>
            </div>
        
        <div class="form-container">
            <form name="cadastro" method="get" action="${pageContext.request.contextPath}${URL_BASE}/TransportadoraControlador">
                <input type="hidden" name="opcao" value="${empty opcao ? 'cadastrar' : opcao}">
                <input type="hidden" name="idTransportadora" value="${idTransportadora}">
                
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
                    <label>Prazo Médio (dias):</label>
                    <input type="number" name="prazoMedio" value="${prazoMedio}" min="0"/>
                </div>
                
                <input type="submit" value="Salvar" name="btnSalvar"/>
            </form>
            
            <form name="cancelar" method="get" action="${pageContext.request.contextPath}${URL_BASE}/TransportadoraControlador" style="display: inline;">
                <input type="hidden" name="opcao" value="cancelar">
                <input type="submit" value="Cancelar" name="btnCancelar"/>
            </form>
        </div>
        
        <c:if test="${not empty mensagem}">
            <div class="mensagem">${mensagem}</div>
        </c:if>
        
        <table>
            <c:if test="${not empty listaTransportadoras}">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>NOME</th>
                        <th>CNPJ</th>
                        <th>TELEFONE</th>
                        <th>PRAZO MÉDIO</th>
                        <th>ALTERAR</th>
                        <th>EXCLUIR</th>
                    </tr>
                </thead>
            </c:if>
            <tbody>
                <c:forEach var="transportadora" items="${listaTransportadoras}">
                    <tr>
                        <td>${transportadora.idTransportadora}</td>
                        <td>${transportadora.nome}</td>
                        <td>${transportadora.cnpj}</td>
                        <td>${transportadora.telefone}</td>
                        <td>${transportadora.prazoMedio} dias</td>
                        
                        <td>
                            <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/TransportadoraControlador">
                                <input type="hidden" name="idTransportadora" value="${transportadora.idTransportadora}">
                                <input type="hidden" name="nome" value="${transportadora.nome}">
                                <input type="hidden" name="cnpj" value="${transportadora.cnpj}">
                                <input type="hidden" name="telefone" value="${transportadora.telefone}">
                                <input type="hidden" name="prazoMedio" value="${transportadora.prazoMedio}">
                                <input type="hidden" name="opcao" value="enviarAlterar">
                                <button type="submit">ALTERAR</button>
                            </form>
                        </td>
                        
                        <td>
                            <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/TransportadoraControlador">
                                <input type="hidden" name="idTransportadora" value="${transportadora.idTransportadora}">
                                <input type="hidden" name="nome" value="${transportadora.nome}">
                                <input type="hidden" name="cnpj" value="${transportadora.cnpj}">
                                <input type="hidden" name="telefone" value="${transportadora.telefone}">
                                <input type="hidden" name="prazoMedio" value="${transportadora.prazoMedio}">
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