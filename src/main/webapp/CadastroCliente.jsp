<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cadastro de Clientes - Loja Virtual</title>
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
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/TransportadoraControlador">Transportadoras</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/FornecedorControlador">Fornecedores</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/ClienteControlador" class="active">Clientes</a></li>
                </ul>
            </div>
        </nav>
        <!-- CONTAINER PRINCIPAL -->
        <div class="main-container">
            
            <!-- CABEÇALHO DA PÁGINA -->
            <div class="page-header">
                <h1>Gerenciamento de Clientes</h1>
                <p>Cadastre e gerencie os Clientes</p>
            </div>
        
        <div class="form-container">
            <form name="cadastro" method="get" action="${pageContext.request.contextPath}${URL_BASE}/ClienteControlador">
                <input type="hidden" name="opcao" value="${empty opcao ? 'cadastrar' : opcao}">
                <input type="hidden" name="idCliente" value="${idCliente}">
                
                <div class="form-group-full">
                    <label>Nome Completo:</label>
                    <input type="text" name="nome" value="${nome}" required/>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Email:</label>
                        <input type="email" name="email" value="${email}" required/>
                    </div>
                    
                    <div class="form-group">
                        <label>Senha:</label>
                        <input type="password" name="senha" value="${senha}" required/>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>CPF/CNPJ:</label>
                        <input type="text" name="cpfCnpj" value="${cpfCnpj}" required/>
                    </div>
                    
                    <div class="form-group">
                        <label>Telefone:</label>
                        <input type="text" name="telefone" value="${telefone}"/>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Data de Cadastro:</label>
                        <input type="date" name="dataCadastro" value="${dataCadastro}"/>
                        <small style="color: #666;">Deixe em branco para usar a data atual</small>
                    </div>
                    
                    <div class="form-group">
                        <label>Data de Nascimento:</label>
                        <input type="date" name="dataNascimento" value="${dataNascimento}" required/>
                    </div>
                </div>
                
                <input type="submit" value="Salvar" name="btnSalvar"/>
            </form>
            
            <form name="cancelar" method="get" action="${pageContext.request.contextPath}${URL_BASE}/ClienteControlador" style="display: inline;">
                <input type="hidden" name="opcao" value="cancelar">
                <input type="submit" value="Cancelar" name="btnCancelar"/>
            </form>
        </div>
        
        <c:if test="${not empty mensagem}">
            <div class="mensagem">${mensagem}</div>
        </c:if>
        
        <table>
            <c:if test="${not empty listaClientes}">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>NOME</th>
                        <th>EMAIL</th>
                        <th>CPF/CNPJ</th>
                        <th>TELEFONE</th>
                        <th>CADASTRO</th>
                        <th>NASCIMENTO</th>
                        <th>ALTERAR</th>
                        <th>EXCLUIR</th>
                    </tr>
                </thead>
            </c:if>
            <tbody>
                <c:forEach var="cliente" items="${listaClientes}">
                    <tr>
                        <td>${cliente.idCliente}</td>
                        <td>${cliente.nome}</td>
                        <td>${cliente.email}</td>
                        <td>${cliente.cpfCnpj}</td>
                        <td>${cliente.telefone}</td>
                        <td>${cliente.dataCadastro}</td>
                        <td>${cliente.dataNascimento}</td>
                        
                        <td>
                            <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/ClienteControlador">
                                <input type="hidden" name="idCliente" value="${cliente.idCliente}">
                                <input type="hidden" name="nome" value="${cliente.nome}">
                                <input type="hidden" name="email" value="${cliente.email}">
                                <input type="hidden" name="senha" value="${cliente.senha}">
                                <input type="hidden" name="cpfCnpj" value="${cliente.cpfCnpj}">
                                <input type="hidden" name="telefone" value="${cliente.telefone}">
                                <input type="hidden" name="dataCadastro" value="${cliente.dataCadastro}">
                                <input type="hidden" name="dataNascimento" value="${cliente.dataNascimento}">
                                <input type="hidden" name="opcao" value="enviarAlterar">
                                <button type="submit">ALTERAR</button>
                            </form>
                        </td>
                        
                        <td>
                            <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/ClienteControlador">
                                <input type="hidden" name="idCliente" value="${cliente.idCliente}">
                                <input type="hidden" name="nome" value="${cliente.nome}">
                                <input type="hidden" name="email" value="${cliente.email}">
                                <input type="hidden" name="senha" value="${cliente.senha}">
                                <input type="hidden" name="cpfCnpj" value="${cliente.cpfCnpj}">
                                <input type="hidden" name="telefone" value="${cliente.telefone}">
                                <input type="hidden" name="dataCadastro" value="${cliente.dataCadastro}">
                                <input type="hidden" name="dataNascimento" value="${cliente.dataNascimento}">
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