<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cadastro de Pagamentos - Loja Virtual</title>
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
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/ItemPedidoControlador">Itens de Pedido</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/PagamentoControlador" class="active">Pagamentos</a></li>
                </ul>
            </div>
        </nav>

        <!-- CONTAINER PRINCIPAL -->
        <div class="main-container">

            <!-- CABEÇALHO DA PÁGINA -->
            <div class="page-header">
                <h1>Gerenciamento de Pagamentos</h1>
                <p>O valor do pagamento é calculado automaticamente a partir do total do pedido</p>
            </div>

            <div class="form-container">
                <form name="cadastro" method="get" action="${pageContext.request.contextPath}${URL_BASE}/PagamentoControlador">
                    <input type="hidden" name="opcao" value="${empty opcao ? 'cadastrar' : opcao}">
                    <input type="hidden" name="idPagamento" value="${idPagamento}">

                    <!-- Dropdown de Método -->
                    <div class="form-group">
                        <label>Método de Pagamento:</label>
                        <select name="metodo" required>
                            <option value="">Selecione um método</option>
                            <option value="PIX" ${metodo == 'PIX' ? 'selected' : ''}>PIX</option>
                            <option value="Cartão de Crédito" ${metodo == 'Cartão de Crédito' ? 'selected' : ''}>Cartão de Crédito</option>
                            <option value="Boleto" ${metodo == 'Boleto' ? 'selected' : ''}>Boleto</option>
                            <option value="Transferência" ${metodo == 'Transferência' ? 'selected' : ''}>Transferência</option>
                        </select>
                    </div>

                    <!-- Dropdown de Status -->
                    <div class="form-group">
                        <label>Status:</label>
                        <select name="status" required>
                            <option value="">Selecione um status</option>
                            <option value="Pendente" ${status == 'Pendente' ? 'selected' : ''}>Pendente</option>
                            <option value="Aprovado" ${status == 'Aprovado' ? 'selected' : ''}>Aprovado</option>
                            <option value="Cancelado" ${status == 'Cancelado' ? 'selected' : ''}>Cancelado</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Data do Pagamento:</label>
                        <input type="date" name="data" value="${data}" required/>
                    </div>

                    <!-- Dropdown de Pedido -->
                    <div class="form-group">
                        <label>Pedido:</label>
                        <select name="pedidosIdPedidos" required>
                            <option value="">Selecione um pedido</option>
                            <c:forEach var="pedido" items="${listaPedidos}">
                                <option value="${pedido.idPedidos}"
                                        ${pedido.idPedidos == pedidosIdPedidos ? 'selected' : ''}>
                                    Pedido #${pedido.idPedidos} - ${pedido.nomeCliente} (R$ ${pedido.valorTotal})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <input type="submit" value="Salvar" name="btnSalvar"/>
                </form>

                <form name="cancelar" method="get" action="${pageContext.request.contextPath}${URL_BASE}/PagamentoControlador" style="display: inline;">
                    <input type="hidden" name="opcao" value="cancelar">
                    <input type="submit" value="Cancelar" name="btnCancelar"/>
                </form>
            </div>

            <c:if test="${not empty mensagem}">
                <div class="mensagem">${mensagem}</div>
            </c:if>

            <!-- Tabela com Lista de Pagamentos -->
            <table>
                <c:if test="${not empty listaPagamentos}">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>MÉTODO</th>
                            <th>VALOR</th>
                            <th>STATUS</th>
                            <th>DATA</th>
                            <th>CLIENTE</th>
                            <th>ALTERAR</th>
                            <th>EXCLUIR</th>
                        </tr>
                    </thead>
                </c:if>
                <tbody>
                    <c:forEach var="pagamento" items="${listaPagamentos}">
                        <tr>
                            <td>${pagamento.idPagamento}</td>
                            <td>${pagamento.metodo}</td>
                            <td>R$ ${pagamento.valor}</td>
                            <td>${pagamento.status}</td>
                            <td>${pagamento.data}</td>
                            <td>${pagamento.nomeClientePedido}</td>

                            <!-- Botão Alterar -->
                            <td>
                                <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/PagamentoControlador">
                                    <input type="hidden" name="idPagamento" value="${pagamento.idPagamento}">
                                    <input type="hidden" name="metodo" value="${pagamento.metodo}">
                                    <input type="hidden" name="status" value="${pagamento.status}">
                                    <input type="hidden" name="data" value="${pagamento.data}">
                                    <input type="hidden" name="pedidosIdPedidos" value="${pagamento.pedidosIdPedidos}">
                                    <input type="hidden" name="opcao" value="enviarAlterar">
                                    <button type="submit">ALTERAR</button>
                                </form>
                            </td>

                            <!-- Botão Excluir -->
                            <td>
                                <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/PagamentoControlador">
                                    <input type="hidden" name="idPagamento" value="${pagamento.idPagamento}">
                                    <input type="hidden" name="metodo" value="${pagamento.metodo}">
                                    <input type="hidden" name="status" value="${pagamento.status}">
                                    <input type="hidden" name="data" value="${pagamento.data}">
                                    <input type="hidden" name="pedidosIdPedidos" value="${pagamento.pedidosIdPedidos}">
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