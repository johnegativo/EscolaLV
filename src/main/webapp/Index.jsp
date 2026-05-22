<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Loja Virtual - Sistema de Gerenciamento</title>
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
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/" class="active">Início</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/MarcaControlador">Marcas</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/CategoriaControlador">Categorias</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/TransportadoraControlador">Transportadoras</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/FornecedorControlador">Fornecedores</a></li>
                    <li><a href="${pageContext.request.contextPath}${URL_BASE}/ClienteControlador">Clientes</a></li>
                </ul>
            </div>
        </nav>

        <!-- CONTAINER PRINCIPAL -->
        <div class="main-container">
            
            <!-- SEÇÃO DE BOAS-VINDAS -->
            <div class="welcome-section">
                <h2>📦 Sistema de Gerenciamento de Loja Virtual</h2>
                <p>
                    Bem-vindo ao sistema de gerenciamento! Escolha uma das opções abaixo para gerenciar 
                    marcas, categorias, transportadoras, fornecedores ou clientes.
                </p>
            </div>

            <!-- CARDS DOS MÓDULOS -->
            <div class="cards-container">
                
                <!-- CARD MARCAS -->
                <a href="${pageContext.request.contextPath}${URL_BASE}/MarcaControlador" class="card card-marcas">
                    <div class="card-icon">🏷️</div>
                    <h3>Marcas</h3>
                    <p>Gerencie as marcas dos produtos cadastrados no sistema</p>
                </a>

                <!-- CARD CATEGORIAS -->
                <a href="${pageContext.request.contextPath}${URL_BASE}/CategoriaControlador" class="card card-categorias">
                    <div class="card-icon">📁</div>
                    <h3>Categorias</h3>
                    <p>Organize os produtos por categorias e subcategorias</p>
                </a>

                <!-- CARD TRANSPORTADORAS -->
                <a href="${pageContext.request.contextPath}${URL_BASE}/TransportadoraControlador" class="card card-transportadoras">
                    <div class="card-icon">🚚</div>
                    <h3>Transportadoras</h3>
                    <p>Cadastre e gerencie as empresas de transporte</p>
                </a>

                <!-- CARD FORNECEDORES -->
                <a href="${pageContext.request.contextPath}${URL_BASE}/FornecedorControlador" class="card card-fornecedores">
                    <div class="card-icon">🏭</div>
                    <h3>Fornecedores</h3>
                    <p>Controle os fornecedores de produtos da loja</p>
                </a>

                <!-- CARD CLIENTES -->
                <a href="${pageContext.request.contextPath}${URL_BASE}/ClienteControlador" class="card card-clientes">
                    <div class="card-icon">👥</div>
                    <h3>Clientes</h3>
                    <p>Gerencie o cadastro de clientes da loja virtual</p>
                </a>
                
            </div>

            <!-- RODAPÉ COM INFORMAÇÕES -->
            <div class="welcome-section mt-20">
                <p style="font-size: 14px; color: #95a5a6;">
                    💻 Desenvolvido como projeto escolar | Java Web 
                </p>
            </div>

        </div>
    </body>
</html>