# 🛒 EscolaLV - Loja Virtual

Sistema de Loja Virtual desenvolvido em Java Web utilizando as especificações modernas do Jakarta EE. O projeto está estruturado seguindo o padrão de arquitetura MVC (Model-View-Controller) com persistência em banco de dados.

---

## 🛠️ Tecnologias Utilizadas

*   **Linguagem:** Java 21
*   **Servidor de Aplicação:** GlassFish 8.0.0 (Suporte a Jakarta EE 11)
*   **Gerenciador de Dependências:** Maven (definido no `pom.xml`)
*   **Camada de Visualização:** JSP (JavaServer Pages) & CSS3
*   **Arquitetura:** MVC (Controladores, DAOs, Entidades e Serviços)

---

## 🗂️ Estrutura Básica do Projeto

*   `src/main/java`: Contém toda a lógica de negócio do sistema (Entidades, DAOs, Controladores).
*   `src/main/webapp`: Contém as páginas de interface do usuário (`.jsp`), arquivos de configuração do GlassFish (`glassfish-web.xml`) e estilização (`css/Estilo.css`).
*   `pom.xml`: Configurações de dependências do Maven e do compilador Java 21.

---

## 🚀 Como Executar o Projeto Localmente

### Pré-requisitos
1.  **Java Development Kit (JDK) 21** instalado e configurado nas variáveis de ambiente.
2.  **Apache GlassFish 8.0.0** configurado na sua máquina ou IDE.
3.  Um banco de dados compatível (ex: MySQL/PostgreSQL) configurado de acordo com o arquivo `persistence.xml`.

### Passo a Passo

1.  **Clonar o repositório:**
    ```bash
    git clone https://github.com
    ```

2.  **Compilar o projeto (Geração do arquivo .war):**
    Execute o comando Maven na raiz do projeto:
    ```bash
    mvn clean package
    ```
    *Isso gerará o arquivo compactado da aplicação dentro da pasta `/target`.*

3.  **Deploy no GlassFish 8.0.0:**
    *   Inicie o seu servidor GlassFish.
    *   Acesse o console de administração do GlassFish (geralmente em `http://localhost:4848`).
    *   Vá na seção **Applications** > **Deploy** e selecione o arquivo `.war` gerado na pasta `target`.
    *   *Alternativamente*, você pode copiar o arquivo `.war` diretamente para a pasta `/glassfish8/glassfish/domains/domain1/autodeploy/`.

4.  **Acessar a Aplicação:**
    Abra o seu navegador e acesse a página inicial do sistema através da URL padrão do GlassFish:
    ```text
    http://localhost:8080/EscolaLV/
    ```

---

### 🗄️ Configuração do Banco de Dados (MySQL)

1. Certifique-se de ter o MySQL Server ativo na sua máquina.
2. Acesse a pasta `/database` deste repositório.
3. Execute o script `script.sql` no seu gerenciador de banco de dados (ex: MySQL Workbench, DBeaver) para criar a estrutura das tabelas.
4. Verifique ou ajuste as credenciais de acesso ao banco (usuário e senha) no arquivo do seu projeto Java localizado em:
   `src/main/resources/META-INF/persistence.xml`

## ✒️ Autor

*   **Desenvolvedor:** johnegativo - *Trabalho Inicial*
