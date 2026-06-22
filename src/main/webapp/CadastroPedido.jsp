<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cadastro de Pedidos - Loja Virtual</title>
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
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/PedidoControlador" class="active">Pedidos</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/ItemPedidoControlador">Itens de Pedido</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/PagamentoControlador">Pagamentos</a></li>
                </ul>
            </div>
        </nav>

        <!-- CONTAINER PRINCIPAL -->
        <div class="main-container">

            <!-- CABEÇALHO DA PÁGINA -->
            <div class="page-header">
                <h1>Gerenciamento de Pedidos</h1>
                <p>Cadastre e gerencie os Pedidos</p>
            </div>

            <div class="form-container">
                <form name="cadastro" method="get" action="${pageContext.request.contextPath}${URL_BASE}/PedidoControlador">
                    <input type="hidden" name="opcao" value="${empty opcao ? 'cadastrar' : opcao}">
                    <input type="hidden" name="idPedidos" value="${idPedidos}">

                    <div class="form-group">
                        <label>Data do Pedido:</label>
                        <input type="date" name="data" value="${data}" required/>
                    </div>

                    <div class="form-group">
                        <label>Valor Total (R$):</label>
                        <input type="number" step="0.01" name="valorTotal" value="${valorTotal}"/>
                        <small>Será recalculado automaticamente ao adicionar itens ao pedido</small>
                    </div>

                    <!-- Dropdown de Status -->
                    <div class="form-group">
                        <label>Status:</label>
                        <select name="status" required>
                            <option value="">Selecione um status</option>
                            <option value="Em processamento" ${status == 'Em processamento' ? 'selected' : ''}>Em processamento</option>
                            <option value="Aprovado" ${status == 'Aprovado' ? 'selected' : ''}>Aprovado</option>
                            <option value="Pago" ${status == 'Pago' ? 'selected' : ''}>Pago</option>
                            <option value="Pagamento pendente" ${status == 'Pagamento pendente' ? 'selected' : ''}>Pagamento pendente</option>
                            <option value="Enviado" ${status == 'Enviado' ? 'selected' : ''}>Enviado</option>
                            <option value="Entregue" ${status == 'Entregue' ? 'selected' : ''}>Entregue</option>
                            <option value="Cancelado" ${status == 'Cancelado' ? 'selected' : ''}>Cancelado</option>
                        </select>
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

                    <!-- Dropdown de Endereço -->
                    <div class="form-group">
                        <label>Endereço de Entrega:</label>
                        <select name="enderecosIdEndereco" required>
                            <option value="">Selecione um endereço</option>
                            <c:forEach var="endereco" items="${listaEnderecos}">
                                <option value="${endereco.idEndereco}"
                                        ${endereco.idEndereco == enderecosIdEndereco ? 'selected' : ''}>
                                    ${endereco.rua}, ${endereco.numero} - ${endereco.cidade}/${endereco.estado} (${endereco.nomeCliente})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <input type="submit" value="Salvar" name="btnSalvar"/>
                </form>

                <form name="cancelar" method="get" action="${pageContext.request.contextPath}${URL_BASE}/PedidoControlador" style="display: inline;">
                    <input type="hidden" name="opcao" value="cancelar">
                    <input type="submit" value="Cancelar" name="btnCancelar"/>
                </form>
            </div>

            <c:if test="${not empty mensagem}">
                <div class="mensagem">${mensagem}</div>
            </c:if>

            <!-- Tabela com Lista de Pedidos -->
            <table>
                <c:if test="${not empty listaPedidos}">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>DATA</th>
                            <th>VALOR TOTAL</th>
                            <th>STATUS</th>
                            <th>CLIENTE</th>
                            <th>ENDEREÇO DE ENTREGA</th>
                            <th>ALTERAR</th>
                            <th>EXCLUIR</th>
                        </tr>
                    </thead>
                </c:if>
                <tbody>
                    <c:forEach var="pedido" items="${listaPedidos}">
                        <tr>
                            <td>${pedido.idPedidos}</td>
                            <td>${pedido.data}</td>
                            <td>R$ ${pedido.valorTotal}</td>
                            <td>${pedido.status}</td>
                            <td>${pedido.nomeCliente}</td>
                            <td>${pedido.enderecoResumo}</td>

                            <!-- Botão Alterar -->
                            <td>
                                <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/PedidoControlador">
                                    <input type="hidden" name="idPedidos" value="${pedido.idPedidos}">
                                    <input type="hidden" name="data" value="${pedido.data}">
                                    <input type="hidden" name="valorTotal" value="${pedido.valorTotal}">
                                    <input type="hidden" name="status" value="${pedido.status}">
                                    <input type="hidden" name="clientesIdCliente" value="${pedido.clientesIdCliente}">
                                    <input type="hidden" name="enderecosIdEndereco" value="${pedido.enderecosIdEndereco}">
                                    <input type="hidden" name="opcao" value="enviarAlterar">
                                    <button type="submit">ALTERAR</button>
                                </form>
                            </td>

                            <!-- Botão Excluir -->
                            <td>
                                <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/PedidoControlador">
                                    <input type="hidden" name="idPedidos" value="${pedido.idPedidos}">
                                    <input type="hidden" name="data" value="${pedido.data}">
                                    <input type="hidden" name="valorTotal" value="${pedido.valorTotal}">
                                    <input type="hidden" name="status" value="${pedido.status}">
                                    <input type="hidden" name="clientesIdCliente" value="${pedido.clientesIdCliente}">
                                    <input type="hidden" name="enderecosIdEndereco" value="${pedido.enderecosIdEndereco}">
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