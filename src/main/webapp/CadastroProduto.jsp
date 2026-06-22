<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cadastro de Produtos - Loja Virtual</title>
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
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/ProdutoControlador" class="active">Produtos</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/EnderecoControlador">Endereços</a></li>
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
                <h1>Gerenciamento de Produtos</h1>
                <p>Cadastre e gerencie os Produtos</p>
            </div>

            <div class="form-container">
                <form name="cadastro" method="get" action="${pageContext.request.contextPath}${URL_BASE}/ProdutoControlador">
                    <input type="hidden" name="opcao" value="${empty opcao ? 'cadastrar' : opcao}">
                    <input type="hidden" name="idProduto" value="${idProduto}">

                    <div class="form-group">
                        <label>Nome do Produto:</label>
                        <input type="text" name="nome" value="${nome}" required/>
                    </div>

                    <div class="form-group">
                        <label>Descrição:</label>
                        <textarea name="descricao" rows="3">${descricao}</textarea>
                    </div>

                    <div class="form-group">
                        <label>Preço (R$):</label>
                        <input type="number" step="0.01" name="preco" value="${preco}" required/>
                    </div>

                    <div class="form-group">
                        <label>Estoque (quantidade):</label>
                        <input type="number" name="estoque" value="${estoque}" required/>
                    </div>

                    <div class="form-group">
                        <label>Peso (kg):</label>
                        <input type="number" step="0.01" name="peso" value="${peso}"/>
                    </div>

                    <!-- Dropdown de Categoria -->
                    <div class="form-group">
                        <label>Categoria:</label>
                        <select name="categoriasIdCategoria" required>
                            <option value="">Selecione uma categoria</option>
                            <c:forEach var="categoria" items="${listaCategorias}">
                                <option value="${categoria.idCategoria}"
                                        ${categoria.idCategoria == categoriasIdCategoria ? 'selected' : ''}>
                                    ${categoria.nome}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Dropdown de Marca -->
                    <div class="form-group">
                        <label>Marca:</label>
                        <select name="marcasIdMarca" required>
                            <option value="">Selecione uma marca</option>
                            <c:forEach var="marca" items="${listaMarcas}">
                                <option value="${marca.idMarca}"
                                        ${marca.idMarca == marcasIdMarca ? 'selected' : ''}>
                                    ${marca.nome}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <input type="submit" value="Salvar" name="btnSalvar"/>
                </form>

                <form name="cancelar" method="get" action="${pageContext.request.contextPath}${URL_BASE}/ProdutoControlador" style="display: inline;">
                    <input type="hidden" name="opcao" value="cancelar">
                    <input type="submit" value="Cancelar" name="btnCancelar"/>
                </form>
            </div>

            <c:if test="${not empty mensagem}">
                <div class="mensagem">${mensagem}</div>
            </c:if>

            <!-- Tabela com Lista de Produtos -->
            <table>
                <c:if test="${not empty listaProdutos}">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>NOME</th>
                            <th>PREÇO</th>
                            <th>ESTOQUE</th>
                            <th>CATEGORIA</th>
                            <th>MARCA</th>
                            <th>NOTA MÉDIA</th>
                            <th>ALTERAR</th>
                            <th>EXCLUIR</th>
                        </tr>
                    </thead>
                </c:if>
                <tbody>
                    <c:forEach var="produto" items="${listaProdutos}">
                        <tr>
                            <td>${produto.idProduto}</td>
                            <td>${produto.nome}</td>
                            <td>R$ ${produto.preco}</td>
                            <td>${produto.estoque}</td>
                            <td>${produto.nomeCategoria}</td>
                            <td>${produto.nomeMarca}</td>
                            <td>${produto.notaMedia}</td>

                            <!-- Botão Alterar -->
                            <td>
                                <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/ProdutoControlador">
                                    <input type="hidden" name="idProduto" value="${produto.idProduto}">
                                    <input type="hidden" name="nome" value="${produto.nome}">
                                    <input type="hidden" name="descricao" value="${produto.descricao}">
                                    <input type="hidden" name="preco" value="${produto.preco}">
                                    <input type="hidden" name="estoque" value="${produto.estoque}">
                                    <input type="hidden" name="peso" value="${produto.peso}">
                                    <input type="hidden" name="categoriasIdCategoria" value="${produto.categoriasIdCategoria}">
                                    <input type="hidden" name="marcasIdMarca" value="${produto.marcasIdMarca}">
                                    <input type="hidden" name="opcao" value="enviarAlterar">
                                    <button type="submit">ALTERAR</button>
                                </form>
                            </td>

                            <!-- Botão Excluir -->
                            <td>
                                <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/ProdutoControlador">
                                    <input type="hidden" name="idProduto" value="${produto.idProduto}">
                                    <input type="hidden" name="nome" value="${produto.nome}">
                                    <input type="hidden" name="descricao" value="${produto.descricao}">
                                    <input type="hidden" name="preco" value="${produto.preco}">
                                    <input type="hidden" name="estoque" value="${produto.estoque}">
                                    <input type="hidden" name="peso" value="${produto.peso}">
                                    <input type="hidden" name="categoriasIdCategoria" value="${produto.categoriasIdCategoria}">
                                    <input type="hidden" name="marcasIdMarca" value="${produto.marcasIdMarca}">
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