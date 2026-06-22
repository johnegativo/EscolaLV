<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cadastro de Itens de Pedido - Loja Virtual</title>
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
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/EnderecoControlador">Endereços</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/PedidoControlador">Pedidos</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/ItemPedidoControlador" class="active">Itens de Pedido</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/PagamentoControlador">Pagamentos</a></li>
                </ul>
            </div>
        </nav>

        <!-- CONTAINER PRINCIPAL -->
        <div class="main-container">

            <!-- CABEÇALHO DA PÁGINA -->
            <div class="page-header">
                <h1>Gerenciamento de Itens de Pedido</h1>
                <p>Adicione produtos aos pedidos. Preço unitário e valor total são calculados automaticamente.</p>
            </div>

            <div class="form-container">
                <form name="cadastro" method="get" action="${pageContext.request.contextPath}${URL_BASE}/ItemPedidoControlador">
                    <input type="hidden" name="opcao" value="${empty opcao ? 'cadastrar' : opcao}">
                    <input type="hidden" name="idItensPedido" value="${idItensPedido}">

                    <div class="form-group">
                        <label>Quantidade:</label>
                        <input type="number" min="1" name="quantidade" value="${quantidade}" required/>
                    </div>

                    <!-- Dropdown de Produto -->
                    <div class="form-group">
                        <label>Produto:</label>
                        <select name="produtosIdProduto" required>
                            <option value="">Selecione um produto</option>
                            <c:forEach var="produto" items="${listaProdutos}">
                                <option value="${produto.idProduto}"
                                        ${produto.idProduto == produtosIdProduto ? 'selected' : ''}>
                                    ${produto.nome} (R$ ${produto.preco} - Estoque: ${produto.estoque})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Dropdown de Pedido -->
                    <div class="form-group">
                        <label>Pedido:</label>
                        <select name="pedidosIdPedidos" required>
                            <option value="">Selecione um pedido</option>
                            <c:forEach var="pedido" items="${listaPedidos}">
                                <option value="${pedido.idPedidos}"
                                        ${pedido.idPedidos == pedidosIdPedidos ? 'selected' : ''}>
                                    Pedido #${pedido.idPedidos} - ${pedido.nomeCliente} (${pedido.data})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <input type="submit" value="Salvar" name="btnSalvar"/>
                </form>

                <form name="cancelar" method="get" action="${pageContext.request.contextPath}${URL_BASE}/ItemPedidoControlador" style="display: inline;">
                    <input type="hidden" name="opcao" value="cancelar">
                    <input type="submit" value="Cancelar" name="btnCancelar"/>
                </form>
            </div>

            <c:if test="${not empty mensagem}">
                <div class="mensagem">${mensagem}</div>
            </c:if>

            <!-- Tabela com Lista de Itens de Pedido -->
            <table>
                <c:if test="${not empty listaItensPedido}">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>PRODUTO</th>
                            <th>QUANTIDADE</th>
                            <th>PREÇO UNITÁRIO</th>
                            <th>SUBTOTAL</th>
                            <th>PEDIDO</th>
                            <th>ALTERAR</th>
                            <th>EXCLUIR</th>
                        </tr>
                    </thead>
                </c:if>
                <tbody>
                    <c:forEach var="item" items="${listaItensPedido}">
                        <tr>
                            <td>${item.idItensPedido}</td>
                            <td>${item.nomeProduto}</td>
                            <td>${item.quantidade}</td>
                            <td>R$ ${item.precoUnitario}</td>
                            <td>R$ ${item.subtotal}</td>
                            <td>#${item.pedidosIdPedidos}</td>

                            <!-- Botão Alterar -->
                            <td>
                                <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/ItemPedidoControlador">
                                    <input type="hidden" name="idItensPedido" value="${item.idItensPedido}">
                                    <input type="hidden" name="quantidade" value="${item.quantidade}">
                                    <input type="hidden" name="produtosIdProduto" value="${item.produtosIdProduto}">
                                    <input type="hidden" name="pedidosIdPedidos" value="${item.pedidosIdPedidos}">
                                    <input type="hidden" name="opcao" value="enviarAlterar">
                                    <button type="submit">ALTERAR</button>
                                </form>
                            </td>

                            <!-- Botão Excluir -->
                            <td>
                                <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/ItemPedidoControlador">
                                    <input type="hidden" name="idItensPedido" value="${item.idItensPedido}">
                                    <input type="hidden" name="quantidade" value="${item.quantidade}">
                                    <input type="hidden" name="produtosIdProduto" value="${item.produtosIdProduto}">
                                    <input type="hidden" name="pedidosIdPedidos" value="${item.pedidosIdPedidos}">
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