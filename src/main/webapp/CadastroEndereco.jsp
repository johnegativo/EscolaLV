<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cadastro de Endereços - Loja Virtual</title>
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
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/ClienteControlador">Clientes</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/ProdutoControlador">Produtos</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/EnderecoControlador" class="active">Endereços</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/PedidoControlador">Pedidos</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/ItemPedidoControlador">Itens de Pedido</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/PagamentoControlador">Pagamentos</a></li>
                </ul>
            </div>
        </nav>

        <!-- CONTAINER PRINCIPAL -->
        <div class="main-container">

            <!-- CABEÇALHO DA PÁGINA -->
            <div class="page-header">
                <h1>Gerenciamento de Endereços</h1>
                <p>Cadastre e gerencie os Endereços dos Clientes</p>
            </div>

            <div class="form-container">
                <form name="cadastro" method="get" action="${pageContext.request.contextPath}${URL_BASE}/EnderecoControlador">
                    <input type="hidden" name="opcao" value="${empty opcao ? 'cadastrar' : opcao}">
                    <input type="hidden" name="idEndereco" value="${idEndereco}">

                    <div class="form-group">
                        <label>CEP:</label>
                        <input type="text" name="cep" value="${cep}" required/>
                    </div>

                    <div class="form-group">
                        <label>Rua:</label>
                        <input type="text" name="rua" value="${rua}" required/>
                    </div>

                    <div class="form-group">
                        <label>Número:</label>
                        <input type="text" name="numero" value="${numero}" required/>
                    </div>

                    <div class="form-group">
                        <label>Bairro:</label>
                        <input type="text" name="bairro" value="${bairro}" required/>
                    </div>

                    <div class="form-group">
                        <label>Cidade:</label>
                        <input type="text" name="cidade" value="${cidade}" required/>
                    </div>

                    <div class="form-group">
                        <label>Estado (UF):</label>
                        <input type="text" name="estado" value="${estado}" maxlength="2" required/>
                    </div>

                    <!-- Dropdown de Cliente -->
                    <div class="form-group">
                        <label>Cliente:</label>
                        <select name="clientesIdCliente" required>
                            <option value="">Selecione um cliente</option>
                            <c:forEach var="cliente" items="${listaClientes}">
                                <option value="${cliente.idCliente}"
                                        ${cliente.idCliente == clientesIdCliente ? 'selected' : ''}>
                                    ${cliente.nome}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <input type="submit" value="Salvar" name="btnSalvar"/>
                </form>

                <form name="cancelar" method="get" action="${pageContext.request.contextPath}${URL_BASE}/EnderecoControlador" style="display: inline;">
                    <input type="hidden" name="opcao" value="cancelar">
                    <input type="submit" value="Cancelar" name="btnCancelar"/>
                </form>
            </div>

            <c:if test="${not empty mensagem}">
                <div class="mensagem">${mensagem}</div>
            </c:if>

            <!-- Tabela com Lista de Endereços -->
            <table>
                <c:if test="${not empty listaEnderecos}">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>CEP</th>
                            <th>RUA</th>
                            <th>NÚMERO</th>
                            <th>BAIRRO</th>
                            <th>CIDADE</th>
                            <th>UF</th>
                            <th>CLIENTE</th>
                            <th>ALTERAR</th>
                            <th>EXCLUIR</th>
                        </tr>
                    </thead>
                </c:if>
                <tbody>
                    <c:forEach var="endereco" items="${listaEnderecos}">
                        <tr>
                            <td>${endereco.idEndereco}</td>
                            <td>${endereco.cep}</td>
                            <td>${endereco.rua}</td>
                            <td>${endereco.numero}</td>
                            <td>${endereco.bairro}</td>
                            <td>${endereco.cidade}</td>
                            <td>${endereco.estado}</td>
                            <td>${endereco.nomeCliente}</td>

                            <!-- Botão Alterar -->
                            <td>
                                <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/EnderecoControlador">
                                    <input type="hidden" name="idEndereco" value="${endereco.idEndereco}">
                                    <input type="hidden" name="cep" value="${endereco.cep}">
                                    <input type="hidden" name="rua" value="${endereco.rua}">
                                    <input type="hidden" name="numero" value="${endereco.numero}">
                                    <input type="hidden" name="bairro" value="${endereco.bairro}">
                                    <input type="hidden" name="cidade" value="${endereco.cidade}">
                                    <input type="hidden" name="estado" value="${endereco.estado}">
                                    <input type="hidden" name="clientesIdCliente" value="${endereco.clientesIdCliente}">
                                    <input type="hidden" name="opcao" value="enviarAlterar">
                                    <button type="submit">ALTERAR</button>
                                </form>
                            </td>

                            <!-- Botão Excluir -->
                            <td>
                                <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/EnderecoControlador">
                                    <input type="hidden" name="idEndereco" value="${endereco.idEndereco}">
                                    <input type="hidden" name="cep" value="${endereco.cep}">
                                    <input type="hidden" name="rua" value="${endereco.rua}">
                                    <input type="hidden" name="numero" value="${endereco.numero}">
                                    <input type="hidden" name="bairro" value="${endereco.bairro}">
                                    <input type="hidden" name="cidade" value="${endereco.cidade}">
                                    <input type="hidden" name="estado" value="${endereco.estado}">
                                    <input type="hidden" name="clientesIdCliente" value="${endereco.clientesIdCliente}">
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