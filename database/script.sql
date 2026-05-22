-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           8.0.45 - MySQL Community Server - GPL
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.16.0.7229
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para projetolojavirtual
DROP DATABASE IF EXISTS `projetolojavirtual`;
CREATE DATABASE IF NOT EXISTS `projetolojavirtual` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `projetolojavirtual`;

-- Copiando estrutura para tabela projetolojavirtual.auditoria
DROP TABLE IF EXISTS `auditoria`;
CREATE TABLE IF NOT EXISTS `auditoria` (
  `id_log` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(300) NOT NULL,
  `acao` varchar(300) NOT NULL,
  `tabela_afetada` varchar(300) NOT NULL,
  `data_hora` datetime NOT NULL,
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela projetolojavirtual.auditoria: ~0 rows (aproximadamente)
DELETE FROM `auditoria`;

-- Copiando estrutura para tabela projetolojavirtual.avaliacoes
DROP TABLE IF EXISTS `avaliacoes`;
CREATE TABLE IF NOT EXISTS `avaliacoes` (
  `id_avaliacao` int NOT NULL AUTO_INCREMENT,
  `nota` decimal(3,2) NOT NULL,
  `comentario` varchar(500) DEFAULT NULL,
  `data` date NOT NULL,
  `clientes_id_cliente` int NOT NULL,
  `produtos_id_produto` int NOT NULL,
  PRIMARY KEY (`id_avaliacao`,`clientes_id_cliente`,`produtos_id_produto`),
  KEY `fk_avaliacoes_clientes1_idx` (`clientes_id_cliente`),
  KEY `fk_avaliacoes_produtos1_idx` (`produtos_id_produto`),
  CONSTRAINT `fk_avaliacoes_clientes1` FOREIGN KEY (`clientes_id_cliente`) REFERENCES `clientes` (`id_cliente`),
  CONSTRAINT `fk_avaliacoes_produtos1` FOREIGN KEY (`produtos_id_produto`) REFERENCES `produtos` (`id_produto`)
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela projetolojavirtual.avaliacoes: ~28 rows (aproximadamente)
DELETE FROM `avaliacoes`;
INSERT INTO `avaliacoes` (`id_avaliacao`, `nota`, `comentario`, `data`, `clientes_id_cliente`, `produtos_id_produto`) VALUES
	(225, 5.00, 'Produto excelente, superou minhas expectativas!', '2025-10-15', 2, 1),
	(226, 4.00, 'Muito bom, mas o prazo de entrega foi um pouco longo.', '2025-10-18', 3, 5),
	(227, 5.00, 'Qualidade impecável, recomendo!', '2025-10-20', 4, 8),
	(228, 3.00, 'Funciona bem, mas o material poderia ser melhor.', '2025-10-21', 5, 12),
	(229, 5.00, 'Chegou rápido e em perfeitas condições!', '2025-10-22', 6, 10),
	(230, 4.00, 'O som é bom, mas o cabo é curto.', '2025-10-23', 8, 14),
	(231, 5.00, 'Imagem linda, ótima TV!', '2025-10-24', 9, 15),
	(232, 5.00, 'Muito útil no dia a dia, recomendo demais.', '2025-10-25', 10, 18),
	(233, 4.00, 'Design bonito, mas um pouco pesado.', '2025-10-26', 11, 20),
	(234, 5.00, 'Melhor compra que fiz este ano!', '2025-10-27', 12, 22),
	(235, 4.00, 'Funciona como esperado, boa durabilidade.', '2025-10-28', 13, 25),
	(236, 5.00, 'Excelente desempenho e acabamento.', '2025-10-29', 14, 27),
	(237, 3.00, 'Não gostei muito da bateria, mas cumpre o básico.', '2025-10-30', 15, 30),
	(238, 5.00, 'Chegou antes do prazo e em ótimo estado.', '2025-11-01', 16, 32),
	(239, 4.00, 'Cumpre o que promete, ótimo custo-benefício.', '2025-11-02', 17, 34),
	(240, 5.00, 'Simplesmente perfeito, uso todos os dias.', '2025-11-03', 18, 35),
	(241, 4.00, 'Produto muito bom, apenas embalagem frágil.', '2025-11-04', 19, 37),
	(242, 5.00, 'Adorei, qualidade top!', '2025-11-05', 20, 39),
	(243, 5.00, 'Entrega rápida e produto funcionando perfeitamente.', '2025-11-06', 21, 41),
	(244, 4.00, 'Excelente, mas poderia vir com mais acessórios.', '2025-11-06', 22, 43),
	(245, 5.00, 'Cumpre o que promete, muito satisfeito.', '2025-11-06', 11, 17),
	(246, 3.00, 'Achei o desempenho mediano pelo preço.', '2025-11-06', 13, 26),
	(247, 5.00, 'Super prático e bonito!', '2025-11-06', 14, 19),
	(248, 4.00, 'Boa construção, mas manual confuso.', '2025-11-06', 16, 23),
	(249, 5.00, 'Produto leve, ergonômico e resistente.', '2025-11-06', 18, 28),
	(250, 4.00, 'Funciona bem, mas esperava mais potência.', '2025-11-06', 20, 33),
	(251, 5.00, 'Excelente custo-benefício, recomendo fortemente.', '2025-11-06', 21, 36),
	(252, 3.00, 'Poderia ter uma bateria com mais duração.', '2025-11-06', 22, 38);

-- Copiando estrutura para tabela projetolojavirtual.categorias
DROP TABLE IF EXISTS `categorias`;
CREATE TABLE IF NOT EXISTS `categorias` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(300) NOT NULL,
  `descricao` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela projetolojavirtual.categorias: ~25 rows (aproximadamente)
DELETE FROM `categorias`;
INSERT INTO `categorias` (`id_categoria`, `nome`, `descricao`) VALUES
	(1, 'Eletrodomésticos', 'Eletrodomésticos de diversos tipos, como geladeiras, micro-ondas e fogões modernos'),
	(2, 'Video Games', 'Consoles, jogos e acessórios voltados ao entretenimento digital'),
	(4, 'Utensílios de Cozinha', 'Utensílios e ferramentas práticas para o preparo de alimentos e organização da cozinha'),
	(5, 'Motocicletas', 'Motocicletas e equipamentos voltados para o público que busca mobilidade e performance'),
	(6, 'Smartphones', 'Smartphones e dispositivos móveis das principais marcas do mercado'),
	(7, 'Informática', 'Computadores, notebooks, peças e periféricos em geral'),
	(8, 'Hardware', 'Componentes de PC como processadores, memórias e placas de vídeo'),
	(9, 'Acessórios Gamer', 'Periféricos e equipamentos voltados ao público gamer'),
	(10, 'Eletroportáteis', 'Pequenos aparelhos domésticos de uso diário'),
	(11, 'Televisores', 'TVs LED, OLED, Smart TVs e acessórios relacionados'),
	(12, 'Áudio e Fones', 'Caixas de som, fones de ouvido e equipamentos de áudio'),
	(13, 'Fotografia e Filmagem', 'Câmeras, tripés e acessórios para criadores de conteúdo'),
	(14, 'Móveis e Decoração', 'Móveis residenciais e itens de design de interiores'),
	(15, 'Automotivo', 'Produtos e acessórios voltados para carros e motos'),
	(16, 'Ferramentas e Construção', 'Equipamentos, ferramentas elétricas e industriais'),
	(17, 'Climatização', 'Ar-condicionados, ventiladores e aquecedores'),
	(18, 'Beleza e Cuidados Pessoais', 'Secadores, chapinhas e produtos de higiene pessoal'),
	(19, 'Esporte e Lazer', 'Equipamentos esportivos, bicicletas e itens de lazer'),
	(20, 'Moda e Vestuário', 'Roupas, calçados e acessórios'),
	(21, 'Saúde e Bem-estar', 'Aparelhos e produtos voltados à saúde e conforto'),
	(22, 'Casa e Jardim', 'Itens domésticos, jardinagem e manutenção residencial'),
	(23, 'Brinquedos e Colecionáveis', 'Brinquedos, action figures e colecionáveis em geral'),
	(24, 'Periféricos de Computador', 'Teclados, mouses, monitores e acessórios de PC'),
	(25, 'Smart Home', 'Produtos para casas inteligentes e automação residencial'),
	(26, 'Livros e Papelaria', 'Livros, cadernos e materiais de escritório');

-- Copiando estrutura para tabela projetolojavirtual.clientes
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE IF NOT EXISTS `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(300) NOT NULL,
  `email` varchar(300) NOT NULL,
  `senha` varchar(300) NOT NULL,
  `cpf_cnpj` varchar(300) NOT NULL,
  `telefone` varchar(300) DEFAULT NULL,
  `dataCadastro` date NOT NULL,
  `dataNascimento` date NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `cpf_cnpj_UNIQUE` (`cpf_cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela projetolojavirtual.clientes: ~20 rows (aproximadamente)
DELETE FROM `clientes`;
INSERT INTO `clientes` (`id_cliente`, `nome`, `email`, `senha`, `cpf_cnpj`, `telefone`, `dataCadastro`, `dataNascimento`) VALUES
	(2, 'Astolfo', 'Astolfo@hotmail.com', 'astolfo123', '360.120.590-43', '(48) 93273 3639', '2021-11-24', '2005-09-27'),
	(3, 'Alexandre Augusto', 'alexandre@gmail.com', 'asd1a2d17', '688.661.270-00', '(88) 92568 4738', '2024-01-07', '2008-10-16'),
	(4, 'Diego Alves', 'cachorrao123@yahoo.com', 'Alfa_da_Alcateia', '809.112.690-53', '(75) 97661 9173', '2025-10-01', '2008-08-04'),
	(5, 'Rodolfo Silva', 'rodolfosiltec@yahoo.com', 'rodolfotec123', '854.114.380-55', '(85) 98071 9092', '2023-04-04', '1981-12-23'),
	(6, 'Yasmin Nascimento', 'yasminascimento@gmail.com', '00000000', '329.231.020-29', '(77) 95149 2506', '2018-10-07', '2012-04-03'),
	(8, 'Lucas Andrade', 'lucas.andrade@email.com', '12345', '123.456.789-00', '(11) 98451-2223', '2024-08-12', '2001-04-18'),
	(9, 'Mariana Silva', 'mariana.silva@email.com', 'senha123', '321.654.987-00', '(21) 99875-1133', '2024-09-05', '1999-09-12'),
	(10, 'Carlos Eduardo', 'carloseduardo@email.com', 'teste321', '159.753.486-10', '(31) 98234-6655', '2024-10-02', '2000-03-09'),
	(11, 'Fernanda Costa', 'fernanda.costa@email.com', 'abc123', '741.258.963-00', '(41) 99512-4401', '2024-11-10', '1998-07-23'),
	(12, 'Gabriel Santos', 'gabriel.santos@email.com', 'gab123', '852.963.741-22', '(51) 99633-2110', '2024-07-22', '2002-12-14'),
	(13, 'Joana Pereira', 'joana.pereira@email.com', 'joana321', '963.852.741-55', '(61) 98766-4455', '2024-06-14', '1997-11-30'),
	(14, 'Thiago Ramos', 'thiago.ramos@email.com', 'senha321', '789.456.123-88', '(71) 98122-3098', '2024-09-09', '1999-05-10'),
	(15, 'Larissa Mendes', 'larissa.mendes@email.com', 'larissa@1', '951.753.258-44', '(81) 98711-9022', '2024-12-01', '2003-02-27'),
	(16, 'Paulo Henrique', 'paulo.henrique@email.com', 'ph2024', '741.369.852-33', '(85) 98422-6641', '2025-01-15', '1996-08-02'),
	(17, 'Beatriz Oliveira', 'beatriz.oliveira@email.com', 'bia456', '258.147.369-09', '(91) 98654-7789', '2025-02-04', '2001-10-20'),
	(18, 'Felipe Souza', 'felipe.souza@email.com', 'felipe1', '789.123.456-90', '(11) 98423-4456', '2025-03-10', '2000-01-15'),
	(19, 'Camila Rocha', 'camila.rocha@email.com', 'camila@321', '369.258.147-10', '(21) 98765-9921', '2025-03-19', '1999-09-25'),
	(20, 'Ricardo Lima', 'ricardo.lima@email.com', 'rlpass', '123.789.456-22', '(41) 98512-8845', '2025-04-01', '1998-05-08'),
	(21, 'Natália Gomes', 'natalia.gomes@email.com', 'nat123', '951.456.753-00', '(51) 98644-2231', '2025-04-28', '1997-07-02'),
	(22, 'André Fernandes', 'andre.fernandes@email.com', 'andre22', '852.147.963-77', '(61) 98322-6677', '2025-05-20', '2002-03-15');

-- Copiando estrutura para tabela projetolojavirtual.enderecos
DROP TABLE IF EXISTS `enderecos`;
CREATE TABLE IF NOT EXISTS `enderecos` (
  `id_endereco` int NOT NULL AUTO_INCREMENT,
  `cep` varchar(15) NOT NULL,
  `rua` varchar(300) NOT NULL,
  `numero` varchar(50) NOT NULL,
  `bairro` varchar(300) NOT NULL,
  `cidade` varchar(300) NOT NULL,
  `estado` char(2) NOT NULL,
  `clientes_id_cliente` int NOT NULL,
  PRIMARY KEY (`id_endereco`,`clientes_id_cliente`),
  KEY `fk_enderecos_clientes_idx` (`clientes_id_cliente`),
  CONSTRAINT `fk_enderecos_clientes` FOREIGN KEY (`clientes_id_cliente`) REFERENCES `clientes` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela projetolojavirtual.enderecos: ~20 rows (aproximadamente)
DELETE FROM `enderecos`;
INSERT INTO `enderecos` (`id_endereco`, `cep`, `rua`, `numero`, `bairro`, `cidade`, `estado`, `clientes_id_cliente`) VALUES
	(2, '22735-390', 'Rua H', '25', 'Tanque', 'Rio de Janeiro', 'RJ', 5),
	(3, '47400-970', 'Rua Coronel Manoel Teixeira', '91', 'Centro', 'Xique-Xique', 'BA', 2),
	(4, '37758-970', 'Praça Governador Valadares', '342', 'Centro', 'Paiolinho', 'MG', 4),
	(5, '37750-972', 'Rua Major Feliciano', '1011', 'Centro', 'Machado', 'MG', 3),
	(6, '78552-117', 'Rua dos Cravos', '03', 'Residencial Jequitibás', 'Sinop', 'MT', 6),
	(7, '01045-001', 'Av. Paulista', '1234', 'Bela Vista', 'São Paulo', 'SP', 17),
	(8, '20040-010', 'Rua da Quitanda', '215', 'Centro', 'Rio de Janeiro', 'RJ', 13),
	(9, '30190-001', 'Av. Afonso Pena', '980', 'Funcionários', 'Belo Horizonte', 'MG', 8),
	(10, '80010-120', 'Rua XV de Novembro', '432', 'Centro', 'Curitiba', 'PR', 9),
	(11, '88015-230', 'Rua Felipe Schmidt', '75', 'Centro', 'Florianópolis', 'SC', 10),
	(12, '69005-040', 'Av. Eduardo Ribeiro', '145', 'Centro', 'Manaus', 'AM', 11),
	(13, '40026-010', 'Rua Chile', '220', 'Comércio', 'Salvador', 'BA', 12),
	(14, '64000-040', 'Av. Frei Serafim', '510', 'Centro', 'Teresina', 'PI', 14),
	(15, '79002-980', 'Rua 14 de Julho', '333', 'Centro', 'Campo Grande', 'MS', 15),
	(16, '69900-055', 'Rua Marechal Deodoro', '87', 'Centro', 'Rio Branco', 'AC', 16),
	(17, '57020-005', 'Rua Sá e Albuquerque', '112', 'Pajuçara', 'Maceió', 'AL', 18),
	(18, '59020-200', 'Rua João Pessoa', '65', 'Petrópolis', 'Natal', 'RN', 19),
	(19, '66010-020', 'Av. Presidente Vargas', '480', 'Campina', 'Belém', 'PA', 20),
	(20, '69020-030', 'Rua 24 de Maio', '725', 'Centro', 'Manaus', 'AM', 21),
	(21, '74020-050', 'Rua 7 de Setembro', '250', 'Centro', 'Goiânia', 'GO', 22);

-- Copiando estrutura para tabela projetolojavirtual.estoque
DROP TABLE IF EXISTS `estoque`;
CREATE TABLE IF NOT EXISTS `estoque` (
  `id_acao` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(10) NOT NULL,
  `quantidade` int NOT NULL,
  `data_movimento` datetime NOT NULL,
  `produtos_id_produto` int NOT NULL,
  `transportadoras_id_transportadora` int DEFAULT NULL,
  `fornecedores_id_fornecedor` int DEFAULT NULL,
  PRIMARY KEY (`id_acao`,`produtos_id_produto`),
  KEY `fk_estoque_produtos1_idx` (`produtos_id_produto`),
  KEY `fk_estoque_fornecedores1_idx` (`fornecedores_id_fornecedor`),
  KEY `FK_estoque_transportadoras` (`transportadoras_id_transportadora`),
  CONSTRAINT `fk_estoque_fornecedores1` FOREIGN KEY (`fornecedores_id_fornecedor`) REFERENCES `fornecedores` (`id_fornecedor`),
  CONSTRAINT `fk_estoque_produtos1` FOREIGN KEY (`produtos_id_produto`) REFERENCES `produtos` (`id_produto`),
  CONSTRAINT `FK_estoque_transportadoras` FOREIGN KEY (`transportadoras_id_transportadora`) REFERENCES `transportadoras` (`id_transportadora`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela projetolojavirtual.estoque: ~83 rows (aproximadamente)
DELETE FROM `estoque`;
INSERT INTO `estoque` (`id_acao`, `tipo`, `quantidade`, `data_movimento`, `produtos_id_produto`, `transportadoras_id_transportadora`, `fornecedores_id_fornecedor`) VALUES
	(1, 'Saída', 2, '2025-10-28 16:28:47', 5, 1, NULL),
	(2, 'Entrada', 2, '2025-10-28 16:50:00', 1, 1, NULL),
	(4, 'Saída', 2, '2025-10-31 07:48:09', 4, NULL, NULL),
	(5, 'Saída', 1, '2025-10-31 07:48:47', 2, NULL, NULL),
	(6, 'Saída', 2, '2025-10-31 07:49:03', 3, NULL, NULL),
	(7, 'Saída', 1, '2025-10-31 07:52:33', 5, NULL, NULL),
	(8, 'Saída', 1, '2025-10-31 07:55:29', 3, NULL, NULL),
	(9, 'Saída', 2, '2025-10-31 07:58:35', 5, NULL, NULL),
	(12, 'Saída', 1, '2025-10-31 08:27:12', 1, NULL, NULL),
	(13, 'Saída', 1, '2025-11-06 22:47:12', 1, NULL, NULL),
	(14, 'Saída', 2, '2025-11-06 22:47:12', 5, NULL, NULL),
	(15, 'Saída', 1, '2025-11-06 22:47:12', 7, NULL, NULL),
	(16, 'Saída', 1, '2025-11-06 22:47:12', 10, 1, NULL),
	(17, 'Saída', 1, '2025-11-06 22:47:12', 12, 1, NULL),
	(18, 'Saída', 2, '2025-11-06 22:47:12', 13, 1, NULL),
	(19, 'Saída', 1, '2025-11-06 22:47:12', 3, 1, NULL),
	(20, 'Saída', 1, '2025-11-06 22:47:12', 4, 1, NULL),
	(21, 'Saída', 1, '2025-11-06 22:47:12', 6, 1, NULL),
	(22, 'Saída', 2, '2025-11-06 22:47:12', 9, 1, NULL),
	(23, 'Saída', 1, '2025-11-06 22:47:12', 8, 1, NULL),
	(24, 'Saída', 1, '2025-11-06 22:47:12', 15, 1, NULL),
	(25, 'Saída', 2, '2025-11-06 22:47:12', 16, 1, NULL),
	(26, 'Saída', 1, '2025-11-06 22:47:12', 17, 1, NULL),
	(27, 'Saída', 1, '2025-11-06 22:47:12', 2, 1, NULL),
	(28, 'Saída', 1, '2025-11-06 22:47:12', 10, 1, NULL),
	(29, 'Saída', 1, '2025-11-06 22:47:12', 20, 1, NULL),
	(30, 'Saída', 2, '2025-11-06 22:47:12', 22, 1, NULL),
	(31, 'Saída', 1, '2025-11-06 22:47:12', 23, 1, NULL),
	(32, 'Saída', 1, '2025-11-06 22:47:12', 19, 1, NULL),
	(33, 'Saída', 1, '2025-11-06 22:47:12', 28, 1, NULL),
	(34, 'Saída', 2, '2025-11-06 22:47:12', 29, 1, NULL),
	(35, 'Saída', 1, '2025-11-06 22:47:12', 31, 1, NULL),
	(36, 'Saída', 1, '2025-11-06 22:47:12', 32, 1, NULL),
	(37, 'Saída', 2, '2025-11-06 22:47:12', 33, 1, NULL),
	(38, 'Saída', 1, '2025-11-06 22:47:12', 25, 1, NULL),
	(39, 'Saída', 1, '2025-11-06 22:47:12', 26, 1, NULL),
	(40, 'Saída', 1, '2025-11-06 22:47:12', 14, 1, NULL),
	(41, 'Saída', 1, '2025-11-06 22:47:12', 40, 1, NULL),
	(42, 'Saída', 2, '2025-11-06 22:47:12', 41, 1, NULL),
	(43, 'Saída', 1, '2025-11-06 22:47:12', 39, 1, NULL),
	(44, 'Saída', 2, '2025-11-06 22:47:12', 6, 1, NULL),
	(45, 'Saída', 1, '2025-11-06 22:47:12', 8, 1, NULL),
	(46, 'Saída', 1, '2025-11-06 22:47:12', 9, 1, NULL),
	(47, 'Saída', 1, '2025-11-06 22:47:12', 21, 1, NULL),
	(48, 'Saída', 2, '2025-11-06 22:47:12', 22, 1, NULL),
	(49, 'Saída', 1, '2025-11-06 22:47:12', 24, 1, NULL),
	(50, 'Saída', 2, '2025-11-06 22:47:12', 30, 1, NULL),
	(51, 'Saída', 1, '2025-11-06 22:47:12', 27, 1, NULL),
	(52, 'Saída', 1, '2025-11-06 22:47:12', 35, 1, NULL),
	(53, 'Saída', 1, '2025-11-06 22:47:12', 36, 1, NULL),
	(54, 'Saída', 2, '2025-11-06 22:47:12', 37, 1, NULL),
	(55, 'Saída', 1, '2025-11-06 22:47:12', 11, 1, NULL),
	(56, 'Saída', 2, '2025-11-06 22:47:12', 12, 1, NULL),
	(57, 'Saída', 2, '2025-11-06 22:47:12', 38, 1, NULL),
	(58, 'Saída', 1, '2025-11-06 22:47:12', 39, 1, NULL),
	(59, 'Saída', 1, '2025-11-06 22:47:12', 40, 1, NULL),
	(60, 'Saída', 1, '2025-11-06 22:47:12', 3, 1, NULL),
	(61, 'Saída', 1, '2025-11-06 22:47:12', 4, 1, NULL),
	(62, 'Saída', 2, '2025-11-06 22:47:12', 7, 1, NULL),
	(63, 'Saída', 1, '2025-11-06 22:47:12', 1, 1, NULL),
	(64, 'Saída', 1, '2025-11-06 22:47:12', 8, 1, NULL),
	(65, 'Saída', 1, '2025-11-06 22:47:12', 9, 1, NULL),
	(66, 'Saída', 1, '2025-11-06 22:47:12', 13, 1, NULL),
	(67, 'Saída', 2, '2025-11-06 22:47:12', 14, 1, NULL),
	(68, 'Saída', 1, '2025-11-06 22:47:12', 15, 1, NULL),
	(69, 'Saída', 1, '2025-11-06 22:47:12', 17, 1, NULL),
	(70, 'Saída', 2, '2025-11-06 22:47:12', 18, 1, NULL),
	(71, 'Saída', 1, '2025-11-06 22:47:12', 19, 1, NULL),
	(72, 'Saída', 1, '2025-11-06 22:47:12', 23, 1, NULL),
	(73, 'Saída', 2, '2025-11-06 22:47:12', 25, 1, NULL),
	(74, 'Saída', 1, '2025-11-06 22:47:12', 26, 1, NULL),
	(75, 'Saída', 1, '2025-11-06 22:47:12', 28, 1, NULL),
	(76, 'Saída', 1, '2025-11-06 22:47:12', 29, 1, NULL),
	(77, 'Saída', 2, '2025-11-06 22:47:12', 30, 1, NULL),
	(78, 'Saída', 1, '2025-11-06 22:47:12', 31, 1, NULL),
	(79, 'Saída', 1, '2025-11-06 22:47:12', 33, 1, NULL),
	(80, 'Saída', 2, '2025-11-06 22:47:12', 34, 1, NULL),
	(81, 'Saída', 1, '2025-11-06 22:47:12', 37, 1, NULL),
	(82, 'Saída', 1, '2025-11-06 22:47:12', 38, 1, NULL),
	(83, 'Saída', 2, '2025-11-06 22:47:12', 39, 1, NULL),
	(84, 'Saída', 1, '2025-11-06 22:47:12', 41, 1, NULL),
	(85, 'Saída', 1, '2025-11-06 22:47:12', 42, 1, NULL),
	(86, 'Saída', 2, '2025-11-06 22:47:12', 43, 1, NULL);

-- Copiando estrutura para tabela projetolojavirtual.fornecedores
DROP TABLE IF EXISTS `fornecedores`;
CREATE TABLE IF NOT EXISTS `fornecedores` (
  `id_fornecedor` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(300) NOT NULL,
  `cnpj` varchar(50) NOT NULL,
  `contato` varchar(300) NOT NULL,
  `endereco` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id_fornecedor`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela projetolojavirtual.fornecedores: ~10 rows (aproximadamente)
DELETE FROM `fornecedores`;
INSERT INTO `fornecedores` (`id_fornecedor`, `nome`, `cnpj`, `contato`, `endereco`) VALUES
	(1, 'Tech Import Brasil', '27.456.982/0001-35', '(11) 99874-3256', 'Av. Paulista, 1000 - São Paulo/SP'),
	(2, 'Digital World Electronics', '04.223.771/0001-12', '(21) 98745-9987', 'Rua das Américas, 542 - Rio de Janeiro/RJ'),
	(3, 'GamerPro Distribuidora', '12.784.965/0001-44', '(11) 97588-2034', 'Rua das Oliveiras, 332 - São Bernardo do Campo/SP'),
	(4, 'Eletro House Distribuição', '19.654.334/0001-77', '(31) 99763-2211', 'Av. Amazonas, 1340 - Belo Horizonte/MG'),
	(5, 'Asia Trade Tech', '98.223.117/0001-81', '(11) 98456-8823', 'Rua da Liberdade, 820 - São Paulo/SP'),
	(6, 'Nordic Tools Supply', '33.789.654/0001-10', '(41) 98211-4532', 'Rua XV de Novembro, 250 - Curitiba/PR'),
	(7, 'MegaParts Informática', '25.114.982/0001-55', '(19) 99231-9842', 'Av. Brasil, 456 - Campinas/SP'),
	(8, 'MotoParts Japão', '18.777.222/0001-63', '(55) 98122-6643', 'Rua Tokyo, 88 - Manaus/AM'),
	(9, 'KitchenWorld Distribuidora', '29.654.111/0001-20', '(48) 99654-3321', 'Av. Beira-Mar Norte, 510 - Florianópolis/SC'),
	(10, 'ElectroGlobal Corp', '56.887.334/0001-88', '(55) 98123-4499', 'Rua Kennedy, 99 - Porto Alegre/RS');

-- Copiando estrutura para tabela projetolojavirtual.itens_pedido
DROP TABLE IF EXISTS `itens_pedido`;
CREATE TABLE IF NOT EXISTS `itens_pedido` (
  `id_itens_pedido` int NOT NULL AUTO_INCREMENT,
  `quantidade` int NOT NULL,
  `preco_unitario` double NOT NULL DEFAULT (0),
  `produtos_id_produto` int NOT NULL,
  `pedidos_id_pedidos` int NOT NULL,
  PRIMARY KEY (`id_itens_pedido`,`produtos_id_produto`,`pedidos_id_pedidos`),
  KEY `fk_itens_pedido_produtos1_idx` (`produtos_id_produto`),
  KEY `fk_itens_pedido_pedidos1_idx` (`pedidos_id_pedidos`),
  CONSTRAINT `fk_itens_pedido_pedidos1` FOREIGN KEY (`pedidos_id_pedidos`) REFERENCES `pedidos` (`id_pedidos`),
  CONSTRAINT `fk_itens_pedido_produtos1` FOREIGN KEY (`produtos_id_produto`) REFERENCES `produtos` (`id_produto`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela projetolojavirtual.itens_pedido: ~82 rows (aproximadamente)
DELETE FROM `itens_pedido`;
INSERT INTO `itens_pedido` (`id_itens_pedido`, `quantidade`, `preco_unitario`, `produtos_id_produto`, `pedidos_id_pedidos`) VALUES
	(2, 1, 3500, 2, 2),
	(3, 1, 1970, 4, 3),
	(4, 1, 6500, 5, 3),
	(5, 2, 6500, 5, 2),
	(7, 1, 3500, 2, 4),
	(8, 2, 1200, 3, 4),
	(10, 1, 1200, 3, 3),
	(11, 2, 6500, 5, 4),
	(15, 1, 350000, 1, 1),
	(16, 2, 6500, 5, 1),
	(17, 1, 2890, 7, 1),
	(18, 1, 4499, 10, 2),
	(19, 1, 2499, 12, 2),
	(20, 2, 499, 13, 2),
	(21, 1, 1200, 3, 3),
	(22, 1, 1970, 4, 3),
	(23, 1, 4200, 6, 3),
	(24, 2, 2999, 9, 4),
	(25, 1, 1790, 8, 4),
	(26, 1, 7999, 15, 5),
	(27, 2, 3999, 16, 5),
	(28, 1, 2799, 17, 5),
	(29, 1, 3500, 2, 6),
	(30, 1, 4499, 10, 6),
	(31, 1, 499, 20, 6),
	(32, 2, 6799, 22, 7),
	(33, 1, 3299, 23, 7),
	(34, 1, 7299, 19, 7),
	(35, 1, 1899, 28, 8),
	(36, 2, 299, 29, 8),
	(37, 1, 279, 31, 9),
	(38, 1, 37990, 32, 9),
	(39, 2, 58990, 33, 9),
	(40, 1, 399, 25, 10),
	(41, 1, 549, 26, 10),
	(42, 1, 9999, 14, 10),
	(43, 1, 599, 40, 11),
	(44, 2, 899, 41, 11),
	(45, 1, 899, 39, 11),
	(46, 2, 4200, 6, 12),
	(47, 1, 1790, 8, 12),
	(48, 1, 2999, 9, 12),
	(49, 1, 599, 21, 13),
	(50, 2, 6799, 22, 13),
	(51, 1, 1799, 24, 13),
	(52, 2, 699, 30, 14),
	(53, 1, 899, 27, 14),
	(54, 1, 499, 35, 15),
	(55, 1, 699, 36, 15),
	(56, 2, 799, 37, 15),
	(57, 1, 4299, 11, 16),
	(58, 2, 2499, 12, 16),
	(59, 2, 2799, 38, 17),
	(60, 1, 899, 39, 17),
	(61, 1, 599, 40, 17),
	(62, 1, 1200, 3, 18),
	(63, 1, 1970, 4, 18),
	(64, 2, 2890, 7, 18),
	(65, 1, 350000, 1, 19),
	(66, 1, 1790, 8, 19),
	(67, 1, 2999, 9, 19),
	(68, 1, 499, 13, 20),
	(69, 2, 9999, 14, 20),
	(70, 1, 7999, 15, 20),
	(71, 1, 2799, 17, 21),
	(72, 2, 4999, 18, 21),
	(73, 1, 7299, 19, 21),
	(74, 1, 3299, 23, 22),
	(75, 2, 399, 25, 22),
	(76, 1, 549, 26, 22),
	(77, 1, 1899, 28, 23),
	(78, 1, 299, 29, 23),
	(79, 2, 699, 30, 23),
	(80, 1, 279, 31, 24),
	(81, 1, 58990, 33, 24),
	(82, 2, 78990, 34, 24),
	(83, 1, 799, 37, 25),
	(84, 1, 2799, 38, 25),
	(85, 2, 899, 39, 25),
	(86, 1, 899, 41, 26),
	(87, 1, 2199, 42, 26),
	(88, 2, 2399, 43, 26);

-- Copiando estrutura para tabela projetolojavirtual.marcas
DROP TABLE IF EXISTS `marcas`;
CREATE TABLE IF NOT EXISTS `marcas` (
  `id_marca` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(300) NOT NULL,
  `descricao` varchar(300) DEFAULT NULL,
  `pais_origem` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_marca`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela projetolojavirtual.marcas: ~49 rows (aproximadamente)
DELETE FROM `marcas`;
INSERT INTO `marcas` (`id_marca`, `nome`, `descricao`, `pais_origem`) VALUES
	(1, 'Kawasaki', 'Fabricante de supermotos', 'Japão'),
	(2, 'Eletrolux', NULL, 'Suécia'),
	(3, 'Microsoft', NULL, 'Estados Unidos'),
	(4, 'Samsung', NULL, 'Coreia do Sul'),
	(5, 'Tramontina', NULL, 'Brasil'),
	(6, 'Sony', 'Empresa de tecnologia, entretenimento e eletrônicos de consumo', 'Japão'),
	(7, 'Aplle', 'Fabricante de eletrônicos e software premium', 'Estados Unidos'),
	(8, 'Dell', 'Fabricante de computadores e periféricos de alta qualidade', 'Estados Unidos'),
	(9, 'HP', 'Especialista em impressoras, notebooks e monitores', 'Estados Unidos'),
	(10, 'Lenovo', 'Multinacional de tecnologia e notebooks', 'China'),
	(11, 'Acer', 'Produtora de notebooks e monitores de ótimo custo-benefício', 'Taiwan'),
	(12, 'Asus', 'Famosa por produtos gamers e placas-mãe de alta performance', 'Taiwan'),
	(13, 'LG', 'Fabricante de eletrônicos e eletrodomésticos', 'Coreia do Sul'),
	(14, 'Nvidia', 'Líder mundial em GPUs e tecnologia gráfica', 'Estados Unidos'),
	(15, 'AMD', 'Fabricante de processadores e placas de vídeo', 'Estados Unidos'),
	(16, 'Intel', 'Referência global em chips e processadores', 'Estados Unidos'),
	(17, 'Razer', 'Marca gamer de periféricos e notebooks de alto desempenho', 'Singapura'),
	(18, 'Logitech', 'Fabricante de acessórios e periféricos de informática', 'Suíça'),
	(19, 'Corsair', 'Especialista em hardware gamer e periféricos', 'Estados Unidos'),
	(20, 'Philips', 'Fabricante de eletrônicos e equipamentos de saúde', 'Países Baixos'),
	(21, 'Panasonic', 'Fabricante de eletrônicos e eletrodomésticos', 'Japão'),
	(22, 'Huawei', 'Multinacional de telecomunicações e smartphones', 'China'),
	(23, 'Xiaomi', 'Fabricante de smartphones e dispositivos inteligentes', 'China'),
	(24, 'Realme', 'Marca de smartphones de alto desempenho e baixo custo', 'China'),
	(25, 'OnePlus', 'Fabricante de smartphones e wearables', 'China'),
	(26, 'Motorola', 'Pioneira em telecomunicações e smartphones', 'Estados Unidos'),
	(27, 'Dellano', 'Fabricante de móveis planejados e decoração', 'Brasil'),
	(28, 'Brastemp', 'Tradicional marca de eletrodomésticos', 'Brasil'),
	(29, 'Consul', 'Fabricante de eletrodomésticos acessíveis', 'Brasil'),
	(30, 'Midea', 'Multinacional especializada em climatização e eletrodomésticos', 'China'),
	(31, 'Arno', 'Fabricante de produtos domésticos e de cozinha', 'França'),
	(32, 'Fischer', 'Empresa de eletrodomésticos e linha branca', 'Brasil'),
	(33, 'Honda', 'Fabricante de automóveis e motocicletas', 'Japão'),
	(34, 'Yamaha', 'Produtora de motos, instrumentos e eletrônicos', 'Japão'),
	(35, 'Bosch', 'Multinacional de engenharia e tecnologia industrial', 'Alemanha'),
	(36, 'Natura', 'Marca de cosméticos e produtos sustentáveis', 'Brasil'),
	(37, 'Oster', 'Fabricante de eletroportáteis e utensílios de cozinha', 'Estados Unidos'),
	(38, 'Dell Gaming', 'Linha gamer da Dell com foco em performance', 'Estados Unidos'),
	(39, 'Kingston', 'Fabricante de memórias e armazenamento', 'Estados Unidos'),
	(40, 'Seagate', 'Especialista em soluções de armazenamento e HDs', 'Estados Unidos'),
	(41, 'Western Digital', 'Fabricante de SSDs e discos rígidos', 'Estados Unidos'),
	(42, 'TP-Link', 'Fabricante de equipamentos de rede e conectividade', 'China'),
	(43, 'HyperX', 'Marca gamer especializada em headsets e periféricos', 'Estados Unidos'),
	(44, 'Positivo', 'Empresa brasileira de informática e tecnologia educacional', 'Brasil'),
	(45, 'Multilaser', 'Fabricante brasileira de eletrônicos e periféricos', 'Brasil'),
	(46, 'Nintendo', 'Empresa japonesa pioneira na indústria de videogames e consoles', 'Japão'),
	(47, 'Philco', 'Fabricante de eletrônicos e eletrodomésticos de confiança', 'Estados Unidos'),
	(48, 'DeWalt', 'Marca reconhecida mundialmente por ferramentas elétricas e equipamentos industriais', 'Estados Unidos'),
	(49, 'Makita', 'Fabricante japonesa especializada em ferramentas elétricas de alta performance', 'Japão');

-- Copiando estrutura para tabela projetolojavirtual.pagamentos
DROP TABLE IF EXISTS `pagamentos`;
CREATE TABLE IF NOT EXISTS `pagamentos` (
  `id_pagamento` int NOT NULL AUTO_INCREMENT,
  `metodo` varchar(300) NOT NULL,
  `valor` double NOT NULL DEFAULT (0),
  `status` varchar(300) NOT NULL,
  `data` date NOT NULL,
  `pedidos_id_pedidos` int NOT NULL,
  PRIMARY KEY (`id_pagamento`,`pedidos_id_pedidos`),
  KEY `fk_pagamentos_pedidos1_idx` (`pedidos_id_pedidos`),
  CONSTRAINT `fk_pagamentos_pedidos1` FOREIGN KEY (`pedidos_id_pedidos`) REFERENCES `pedidos` (`id_pedidos`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela projetolojavirtual.pagamentos: ~25 rows (aproximadamente)
DELETE FROM `pagamentos`;
INSERT INTO `pagamentos` (`id_pagamento`, `metodo`, `valor`, `status`, `data`, `pedidos_id_pedidos`) VALUES
	(1, 'PIX', 353500, 'Pago', '2024-11-28', 7),
	(2, 'Credito', 8700, 'Cancelado', '2025-10-07', 3),
	(5, 'Pix', 329301, 'Aprovado', '2025-10-01', 1),
	(6, 'Cartão de Crédito', 24396, 'Aprovado', '2025-10-02', 2),
	(7, 'Pix', 26688, 'Aprovado', '2025-10-04', 4),
	(8, 'Cartão de Crédito', 16916.4, 'Aprovado', '2025-10-05', 5),
	(9, 'Transferência', 8498, 'Pendente', '2025-10-06', 6),
	(10, 'Boleto', 2247.3, 'Cancelado', '2025-10-08', 8),
	(11, 'Cartão de Crédito', 140624.1, 'Aprovado', '2025-10-09', 9),
	(12, 'Pix', 10847, 'Aprovado', '2025-10-10', 10),
	(13, 'Pix', 3296, 'Pendente', '2025-10-11', 11),
	(14, 'Cartão de Crédito', 13189, 'Aprovado', '2025-10-12', 12),
	(15, 'Boleto', 15976, 'Cancelado', '2025-10-13', 13),
	(16, 'Pix', 2297, 'Aprovado', '2025-10-14', 14),
	(17, 'Transferência', 2376.6, 'Aprovado', '2025-10-15', 15),
	(18, 'Cartão de Crédito', 9297, 'Aprovado', '2025-10-16', 16),
	(19, 'Boleto', 5676.8, 'Pendente', '2025-10-17', 17),
	(20, 'Pix', 8950, 'Aprovado', '2025-10-18', 18),
	(21, 'Cartão de Crédito', 266091.75, 'Aprovado', '2025-10-19', 19),
	(22, 'Pix', 28496, 'Cancelado', '2025-10-20', 20),
	(23, 'Boleto', 10048, 'Aprovado', '2025-10-21', 21),
	(24, 'Pix', 4646, 'Aprovado', '2025-10-22', 22),
	(25, 'Cartão de Crédito', 3546, 'Pendente', '2025-10-23', 23),
	(26, 'Transferência', 217249, 'Aprovado', '2025-10-24', 24),
	(27, 'Pix', 5296, 'Aprovado', '2025-10-25', 25);

-- Copiando estrutura para tabela projetolojavirtual.pedidos
DROP TABLE IF EXISTS `pedidos`;
CREATE TABLE IF NOT EXISTS `pedidos` (
  `id_pedidos` int NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL,
  `valor_total` double NOT NULL DEFAULT (0),
  `status` varchar(300) NOT NULL,
  `clientes_id_cliente` int NOT NULL,
  `enderecos_id_endereco` int NOT NULL,
  PRIMARY KEY (`id_pedidos`,`clientes_id_cliente`,`enderecos_id_endereco`),
  KEY `fk_pedidos_clientes1_idx` (`clientes_id_cliente`),
  KEY `fk_pedidos_enderecos1_idx` (`enderecos_id_endereco`),
  CONSTRAINT `fk_pedidos_clientes1` FOREIGN KEY (`clientes_id_cliente`) REFERENCES `clientes` (`id_cliente`),
  CONSTRAINT `fk_pedidos_enderecos1` FOREIGN KEY (`enderecos_id_endereco`) REFERENCES `enderecos` (`id_endereco`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela projetolojavirtual.pedidos: ~26 rows (aproximadamente)
DELETE FROM `pedidos`;
INSERT INTO `pedidos` (`id_pedidos`, `data`, `valor_total`, `status`, `clientes_id_cliente`, `enderecos_id_endereco`) VALUES
	(1, '2025-11-06', 329301, 'Entregue', 20, 20),
	(2, '2024-11-10', 24396, 'Entregue', 2, 3),
	(3, '2025-09-25', 16940, 'Entregue', 5, 2),
	(4, '2025-10-31', 26688, 'Pagamento pendente', 3, 5),
	(5, '2025-10-15', 16916.4, 'Entregue', 2, 3),
	(6, '2025-10-18', 8498, 'Entregue', 3, 5),
	(7, '2025-10-19', 24166, 'Aprovado', 4, 4),
	(8, '2025-11-06', 2247.3, 'Entregue', 18, 17),
	(9, '2025-10-22', 140624.1, 'Enviado', 6, 6),
	(10, '2025-10-23', 10847, 'Entregue', 8, 9),
	(11, '2025-10-24', 3296, 'Em processamento', 9, 10),
	(12, '2025-11-06', 13189, 'Em processamento', 21, 20),
	(13, '2025-10-26', 15976, 'Entregue', 11, 12),
	(14, '2025-10-27', 2297, 'Em processamento', 12, 13),
	(15, '2025-10-28', 2376.6, 'Enviado', 13, 8),
	(16, '2025-10-29', 9297, 'Entregue', 14, 14),
	(17, '2025-10-30', 5676.8, 'Entregue', 15, 15),
	(18, '2025-11-01', 8950, 'Aprovado', 8, 9),
	(19, '2025-11-02', 266091.75, 'Enviado', 9, 10),
	(20, '2025-11-03', 28496, 'Entregue', 10, 11),
	(21, '2025-11-05', 10048, 'Entregue', 12, 13),
	(22, '2025-11-06', 4646, 'Aprovado', 13, 8),
	(23, '2025-11-06', 3546, 'Em processamento', 14, 14),
	(24, '2025-11-06', 217249, 'Entregue', 15, 15),
	(25, '2025-11-06', 5296, 'Aprovado', 16, 16),
	(26, '2025-11-06', 7896, 'Enviado', 17, 7);

-- Copiando estrutura para tabela projetolojavirtual.produtos
DROP TABLE IF EXISTS `produtos`;
CREATE TABLE IF NOT EXISTS `produtos` (
  `id_produto` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(300) NOT NULL,
  `descricao` varchar(300) DEFAULT NULL,
  `preco` double NOT NULL DEFAULT (0),
  `estoque` int NOT NULL DEFAULT (0),
  `peso` double DEFAULT NULL,
  `nota_media` decimal(3,2) DEFAULT NULL,
  `categorias_id_categoria` int NOT NULL,
  `marcas_id_marca` int NOT NULL,
  PRIMARY KEY (`id_produto`,`categorias_id_categoria`,`marcas_id_marca`),
  KEY `fk_produtos_categorias1_idx` (`categorias_id_categoria`),
  KEY `fk_produtos_marcas1_idx` (`marcas_id_marca`),
  CONSTRAINT `fk_produtos_categorias1` FOREIGN KEY (`categorias_id_categoria`) REFERENCES `categorias` (`id_categoria`),
  CONSTRAINT `fk_produtos_marcas1` FOREIGN KEY (`marcas_id_marca`) REFERENCES `marcas` (`id_marca`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela projetolojavirtual.produtos: ~43 rows (aproximadamente)
DELETE FROM `produtos`;
INSERT INTO `produtos` (`id_produto`, `nome`, `descricao`, `preco`, `estoque`, `peso`, `nota_media`, `categorias_id_categoria`, `marcas_id_marca`) VALUES
	(1, 'Kawasaki H2R', 'Supermoto conhecida por ser a mais rápida do mundo', 350000, 1, 238, 5.00, 5, 1),
	(2, 'Xbox Series X', NULL, 3500, 234, 4.46, NULL, 2, 3),
	(3, 'Galaxy A32', NULL, 1200, 347, 0.184, NULL, 6, 4),
	(4, 'Micro-ondas de Embutir Electrolux 34L Experience (ME3BC)', NULL, 1970, 230, 17.7, NULL, 1, 2),
	(5, 'Geladeira Electrolux Frost Free (IM8S)', NULL, 6500, 45, 98, 4.00, 1, 2),
	(6, 'Geladeira Brastemp Frost Free 400L', 'Geladeira moderna com controle de temperatura eletrônico', 4200, 22, 85, NULL, 1, 28),
	(7, 'Fogão 5 Bocas Consul Inox', 'Fogão com acendimento automático e forno elétrico', 2890, 12, 60, NULL, 1, 29),
	(8, 'Micro-ondas Eletrolux 34L Experience', 'Micro-ondas digital com painel touch e descongelamento automático', 1790, 37, 18, 5.00, 1, 2),
	(9, 'Ar-condicionado Split LG Dual Inverter 12000 BTUs', 'Ar-condicionado econômico e silencioso', 2999, 16, 22, NULL, 1, 13),
	(10, 'PlayStation 5', 'Console de nova geração com SSD ultrarrápido', 4499, 33, 4.5, 5.00, 2, 6),
	(11, 'Xbox Series X', 'Console de última geração com 1TB SSD', 4299, 29, 4.4, NULL, 2, 3),
	(12, 'Nintendo Switch OLED', 'Console híbrido com tela OLED e Joy-Cons', 2499, 47, 1.2, 3.00, 2, 46),
	(13, 'Controle DualSense PS5', 'Controle sem fio com feedback tátil e gatilhos adaptativos', 499, 97, 0.28, NULL, 2, 6),
	(14, 'iPhone 15 Pro 256GB', 'Smartphone topo de linha com chip A17 Pro', 9999, 37, 0.19, 4.00, 6, 7),
	(15, 'Samsung Galaxy S24 Ultra', 'Celular premium com câmera de 200MP', 7999, 43, 0.23, 5.00, 6, 4),
	(16, 'Xiaomi 13T Pro 256GB', 'Smartphone com processador Dimensity 9200+ e câmera Leica', 3999, 58, 0.21, NULL, 6, 23),
	(17, 'Motorola Edge 50 Fusion', 'Smartphone intermediário com tela pOLED', 2799, 53, 0.2, 5.00, 6, 26),
	(18, 'Notebook Dell Inspiron 15', 'Notebook com Intel i7 e 16GB RAM', 4999, 18, 2.2, 5.00, 7, 8),
	(19, 'Notebook Asus TUF Gaming F15', 'Notebook gamer com RTX 4060 e tela 144Hz', 7299, 16, 2.5, 5.00, 7, 12),
	(20, 'SSD Kingston NV2 1TB', 'SSD NVMe Gen4 de alta velocidade', 499, 119, 0.05, 4.00, 8, 39),
	(21, 'Memória RAM Corsair Vengeance 16GB DDR5', 'Memória de alto desempenho para gamers', 599, 79, 0.04, NULL, 8, 19),
	(22, 'Placa de Vídeo Nvidia RTX 4070 Ti', 'GPU de última geração com 12GB GDDR6X', 6799, 21, 1.2, 5.00, 8, 14),
	(23, 'Processador AMD Ryzen 9 7900X', 'Processador de 12 núcleos para alto desempenho', 3299, 38, 0.1, 4.00, 8, 15),
	(24, 'Monitor LG Ultragear 27"', 'Monitor gamer 165Hz QHD com 1ms', 1799, 34, 4.5, NULL, 24, 13),
	(25, 'Mouse Razer DeathAdder V3', 'Mouse gamer ergonômico com sensor óptico de alta precisão', 399, 97, 0.18, 4.00, 9, 17),
	(26, 'Teclado Mecânico HyperX Alloy FPS', 'Teclado mecânico RGB com switches lineares', 549, 88, 0.9, 3.00, 9, 43),
	(27, 'Headset Logitech G Pro X', 'Fone gamer com microfone removível e som surround', 899, 69, 0.6, 5.00, 9, 18),
	(28, 'Cadeira Gamer Corsair T3 Rush', 'Cadeira ergonômica de tecido respirável e ajuste completo', 1899, 28, 24, 5.00, 9, 19),
	(29, 'Liquidificador Arno Power Max 1000W', 'Liquidificador com lâminas inox e 15 velocidades', 299, 67, 3.5, NULL, 1, 31),
	(30, 'Batedeira Oster Planetária 600W', 'Batedeira potente e silenciosa com 12 velocidades', 699, 46, 4.1, 3.00, 1, 37),
	(31, 'Torradeira Philco Retrô', 'Torradeira de duas fatias com controle de temperatura', 279, 43, 2.2, NULL, 1, 47),
	(32, 'Honda CB 500F', 'Moto street com motor bicilíndrico e painel digital', 37990, 9, 175, 5.00, 5, 33),
	(33, 'Yamaha MT-09', 'Motocicleta naked de alta performance', 58990, 5, 189, 4.00, 5, 34),
	(34, 'Kawasaki Ninja ZX-10R', 'Superesportiva com motor 998cc e 203 cv', 78990, 3, 208, 4.00, 5, 1),
	(35, 'Parafusadeira Bosch GSR 1200', 'Parafusadeira sem fio com bateria de 12V', 499, 59, 1.4, 5.00, 10, 35),
	(36, 'Furadeira Impacto DeWalt 13mm 750W', 'Furadeira potente e resistente para uso profissional', 699, 44, 2.1, 5.00, 10, 48),
	(37, 'Serra Circular Makita 1400W', 'Serra circular para cortes de precisão em madeira', 799, 32, 3.2, 4.00, 10, 49),
	(38, 'Sofá Retrátil 3 Lugares', 'Sofá reclinável em tecido suede', 2799, 9, 95, 3.00, 15, 22),
	(39, 'Cadeira de Escritório Dellano Comfort', 'Cadeira ergonômica com apoio lombar e altura ajustável', 899, 16, 14, 5.00, 15, 22),
	(40, 'Mesa de Centro Moderna', 'Mesa de madeira e vidro temperado', 599, 23, 10, NULL, 15, 22),
	(41, 'Caixa de Som JBL Charge 5', 'Caixa portátil Bluetooth à prova d\'água', 899, 42, 1.2, 5.00, 12, 45),
	(42, 'Fone de Ouvido Sony WH-1000XM5', 'Headphone com cancelamento de ruído ativo', 2199, 24, 0.25, NULL, 12, 6),
	(43, 'Soundbar Samsung HW-Q600C', 'Soundbar 3.1.2 canais com Dolby Atmos', 2399, 28, 4.7, 4.00, 12, 4);

-- Copiando estrutura para tabela projetolojavirtual.produtos_has_fornecedores
DROP TABLE IF EXISTS `produtos_has_fornecedores`;
CREATE TABLE IF NOT EXISTS `produtos_has_fornecedores` (
  `id_produto_fornecedor` int NOT NULL AUTO_INCREMENT,
  `produtos_id_produto` int NOT NULL,
  `fornecedores_id_fornecedor` int NOT NULL,
  PRIMARY KEY (`id_produto_fornecedor`,`produtos_id_produto`,`fornecedores_id_fornecedor`),
  KEY `fk_produtos_has_fornecedores_fornecedores1_idx` (`fornecedores_id_fornecedor`),
  KEY `fk_produtos_has_fornecedores_produtos1_idx` (`produtos_id_produto`),
  CONSTRAINT `fk_produtos_has_fornecedores_fornecedores1` FOREIGN KEY (`fornecedores_id_fornecedor`) REFERENCES `fornecedores` (`id_fornecedor`),
  CONSTRAINT `fk_produtos_has_fornecedores_produtos1` FOREIGN KEY (`produtos_id_produto`) REFERENCES `produtos` (`id_produto`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela projetolojavirtual.produtos_has_fornecedores: ~63 rows (aproximadamente)
DELETE FROM `produtos_has_fornecedores`;
INSERT INTO `produtos_has_fornecedores` (`id_produto_fornecedor`, `produtos_id_produto`, `fornecedores_id_fornecedor`) VALUES
	(1, 1, 1),
	(2, 2, 1),
	(3, 3, 2),
	(4, 4, 2),
	(5, 5, 3),
	(6, 6, 3),
	(7, 7, 4),
	(8, 8, 4),
	(9, 9, 5),
	(10, 10, 5),
	(11, 11, 6),
	(12, 12, 6),
	(13, 13, 7),
	(14, 14, 7),
	(15, 15, 8),
	(16, 16, 8),
	(17, 17, 9),
	(18, 18, 9),
	(19, 19, 10),
	(20, 20, 10),
	(21, 1, 2),
	(22, 2, 3),
	(23, 3, 4),
	(24, 4, 5),
	(25, 5, 6),
	(26, 6, 7),
	(27, 7, 8),
	(28, 8, 9),
	(29, 9, 10),
	(30, 10, 1),
	(31, 11, 2),
	(32, 12, 3),
	(33, 13, 4),
	(34, 14, 5),
	(35, 15, 6),
	(36, 16, 7),
	(37, 17, 8),
	(38, 18, 9),
	(39, 19, 10),
	(40, 20, 1),
	(41, 21, 2),
	(42, 22, 3),
	(43, 23, 4),
	(44, 24, 5),
	(45, 25, 6),
	(46, 26, 7),
	(47, 27, 8),
	(48, 28, 9),
	(49, 29, 10),
	(50, 30, 1),
	(51, 31, 2),
	(52, 32, 3),
	(53, 33, 4),
	(54, 34, 5),
	(55, 35, 6),
	(56, 36, 7),
	(57, 37, 8),
	(58, 38, 9),
	(59, 39, 10),
	(60, 40, 1),
	(61, 41, 2),
	(62, 42, 3),
	(63, 43, 4);

-- Copiando estrutura para tabela projetolojavirtual.reembolsos
DROP TABLE IF EXISTS `reembolsos`;
CREATE TABLE IF NOT EXISTS `reembolsos` (
  `id_reembolso` int NOT NULL AUTO_INCREMENT,
  `valor` double NOT NULL DEFAULT (0),
  `motivo` varchar(300) NOT NULL,
  `status` varchar(300) NOT NULL,
  `pedidos_id_pedidos` int NOT NULL,
  `pagamentos_id_pagamento` int NOT NULL,
  PRIMARY KEY (`id_reembolso`,`pedidos_id_pedidos`,`pagamentos_id_pagamento`),
  KEY `fk_reembolsos_pedidos1_idx` (`pedidos_id_pedidos`),
  KEY `fk_reembolsos_pagamentos1_idx` (`pagamentos_id_pagamento`),
  CONSTRAINT `fk_reembolsos_pagamentos1` FOREIGN KEY (`pagamentos_id_pagamento`) REFERENCES `pagamentos` (`id_pagamento`),
  CONSTRAINT `fk_reembolsos_pedidos1` FOREIGN KEY (`pedidos_id_pedidos`) REFERENCES `pedidos` (`id_pedidos`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela projetolojavirtual.reembolsos: ~5 rows (aproximadamente)
DELETE FROM `reembolsos`;
INSERT INTO `reembolsos` (`id_reembolso`, `valor`, `motivo`, `status`, `pedidos_id_pedidos`, `pagamentos_id_pagamento`) VALUES
	(16, 329301, 'Produto com defeito', 'Aprovado', 1, 5),
	(17, 8498, 'Erro na cobrança', 'Pendente', 6, 9),
	(18, 3296, 'Cancelamento de pedido', 'Aprovado', 11, 13),
	(19, 266091.75, 'Produto não entregue', 'Pendente', 19, 21),
	(20, 3546, 'Troca não realizada', 'Negado', 23, 25);

-- Copiando estrutura para tabela projetolojavirtual.transportadoras
DROP TABLE IF EXISTS `transportadoras`;
CREATE TABLE IF NOT EXISTS `transportadoras` (
  `id_transportadora` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(300) NOT NULL,
  `prazo_medio` int DEFAULT NULL,
  `contato` varchar(300) NOT NULL,
  PRIMARY KEY (`id_transportadora`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela projetolojavirtual.transportadoras: ~11 rows (aproximadamente)
DELETE FROM `transportadoras`;
INSERT INTO `transportadoras` (`id_transportadora`, `nome`, `prazo_medio`, `contato`) VALUES
	(1, 'Braspress', 10, 'Whatsapp'),
	(2, 'Correios', 21, '(61) 3003-0100'),
	(3, 'JadLog', 4, '(11) 3569-4000'),
	(4, 'Total Express', 5, '(11) 4002-9888'),
	(5, 'FedEx', 7, '(11) 4003-3339'),
	(6, 'DHL Express', 6, '(11) 3618-3200'),
	(7, 'Azul Cargo', 5, '(11) 4003-1118'),
	(8, 'Loggi', 2, '(11) 98765-1144'),
	(9, 'Sequoia Logística', 7, '(11) 3014-8000'),
	(10, 'UPS', 6, '(21) 4002-8888'),
	(11, 'Transportes Rodonorte', 4, '(41) 3322-0098');

-- Copiando estrutura para view projetolojavirtual.vw_clientes_com_pedidos
DROP VIEW IF EXISTS `vw_clientes_com_pedidos`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `vw_clientes_com_pedidos` (
	`id_cliente` INT NOT NULL,
	`nome` VARCHAR(1) NOT NULL COLLATE 'utf8mb3_general_ci',
	`email` VARCHAR(1) NOT NULL COLLATE 'utf8mb3_general_ci',
	`total_pedidos` BIGINT NOT NULL,
	`total_gasto` DOUBLE NULL,
	`ticket_medio` DOUBLE NULL
);

-- Copiando estrutura para view projetolojavirtual.vw_itens_pedido_completo
DROP VIEW IF EXISTS `vw_itens_pedido_completo`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `vw_itens_pedido_completo` (
	`id_pedido` INT NOT NULL,
	`produto` VARCHAR(1) NOT NULL COLLATE 'utf8mb3_general_ci',
	`nota_media` DECIMAL(3,2) NULL,
	`quantidade` INT NOT NULL,
	`preco_unitario` DOUBLE NOT NULL,
	`subtotal` DOUBLE NOT NULL
);

-- Copiando estrutura para view projetolojavirtual.vw_pedidos_detalhados
DROP VIEW IF EXISTS `vw_pedidos_detalhados`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `vw_pedidos_detalhados` (
	`id_pedidos` INT NOT NULL,
	`cliente` VARCHAR(1) NOT NULL COLLATE 'utf8mb3_general_ci',
	`email` VARCHAR(1) NOT NULL COLLATE 'utf8mb3_general_ci',
	`telefone` VARCHAR(1) NULL COLLATE 'utf8mb3_general_ci',
	`data` DATE NOT NULL,
	`status` VARCHAR(1) NOT NULL COLLATE 'utf8mb3_general_ci',
	`valor_total` DOUBLE NOT NULL,
	`endereco_entrega` TEXT NOT NULL COLLATE 'utf8mb3_general_ci'
);

-- Copiando estrutura para view projetolojavirtual.vw_produtos_estoque_baixo
DROP VIEW IF EXISTS `vw_produtos_estoque_baixo`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `vw_produtos_estoque_baixo` (
	`id_produto` INT NOT NULL,
	`nome` VARCHAR(1) NOT NULL COLLATE 'utf8mb3_general_ci',
	`estoque` INT NOT NULL,
	`preco` DOUBLE NOT NULL,
	`categoria` VARCHAR(1) NOT NULL COLLATE 'utf8mb3_general_ci',
	`marca` VARCHAR(1) NOT NULL COLLATE 'utf8mb3_general_ci'
);

-- Copiando estrutura para view projetolojavirtual.vw_ranking_produtos
DROP VIEW IF EXISTS `vw_ranking_produtos`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `vw_ranking_produtos` (
	`id_produto` INT NOT NULL,
	`nome` VARCHAR(1) NOT NULL COLLATE 'utf8mb3_general_ci',
	`preco` DOUBLE NOT NULL,
	`nota_media` DECIMAL(3,2) NULL,
	`categoria` VARCHAR(1) NOT NULL COLLATE 'utf8mb3_general_ci',
	`total_vendido` DECIMAL(32,0) NULL,
	`receita_gerada` DOUBLE NULL
);

-- Copiando estrutura para view projetolojavirtual.vw_receita_por_metodo_pagamento
DROP VIEW IF EXISTS `vw_receita_por_metodo_pagamento`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `vw_receita_por_metodo_pagamento` (
	`metodo` VARCHAR(1) NOT NULL COLLATE 'utf8mb3_general_ci',
	`total_transacoes` BIGINT NOT NULL,
	`receita_total` DOUBLE NULL,
	`ticket_medio` DOUBLE NULL
);

-- Copiando estrutura para trigger projetolojavirtual._tri_auditoriaAvaliacoes
DROP TRIGGER IF EXISTS `_tri_auditoriaAvaliacoes`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `_tri_auditoriaAvaliacoes` AFTER INSERT ON `avaliacoes` FOR EACH ROW BEGIN
    SELECT c.nome INTO @nomeCliente
    FROM clientes AS c
    WHERE c.id_cliente = NEW.clientes_id_cliente;

    SET @mensagem = CONCAT('Avaliação feita por: ', @nomeCliente, ' (ID: ', NEW.clientes_id_cliente, ')');

    INSERT INTO auditoria (id_log, usuario, acao, tabela_afetada, data_hora)
    VALUES (NULL, USER(), @mensagem, 'avaliacoes', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual._tri_auditoriaCliente
DROP TRIGGER IF EXISTS `_tri_auditoriaCliente`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `_tri_auditoriaCliente` AFTER INSERT ON `clientes` FOR EACH ROW BEGIN
    SET @mensagem = CONCAT('Novo cliente cadastrado: ', NEW.nome, ' (ID: ', NEW.id_cliente, ')');

    INSERT INTO auditoria (id_log, usuario, acao, tabela_afetada, data_hora)
    VALUES (NULL, USER(), @mensagem, 'clientes', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual._tri_auditoriaPagamentos
DROP TRIGGER IF EXISTS `_tri_auditoriaPagamentos`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `_tri_auditoriaPagamentos` AFTER INSERT ON `pagamentos` FOR EACH ROW BEGIN
    SELECT c.nome INTO @nomeCliente
    FROM clientes AS c
    WHERE c.id_cliente = (
        SELECT clientes_id_cliente
        FROM pedidos
        WHERE id_pedidos = NEW.pedidos_id_pedidos
    );

    SET @mensagem = CONCAT(
        'Pagamento registrado para cliente ', @nomeCliente,
        ' (Pedido ID: ', NEW.pedidos_id_pedidos,
        ', Valor: ', NEW.valor,
        ', Método: ', NEW.metodo, ')'
    );

    INSERT INTO auditoria (id_log, usuario, acao, tabela_afetada, data_hora)
    VALUES (NULL, USER(), @mensagem, 'pagamentos', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual._tri_auditoriaPedidos
DROP TRIGGER IF EXISTS `_tri_auditoriaPedidos`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `_tri_auditoriaPedidos` AFTER INSERT ON `pedidos` FOR EACH ROW BEGIN
    SELECT c.nome INTO @nomeCliente
    FROM clientes AS c
    WHERE c.id_cliente = NEW.clientes_id_cliente;

    SET @mensagem = CONCAT(
        'Novo pedido criado por ', @nomeCliente,
        ' (ID Pedido: ', NEW.id_pedidos,
        ', Status: ', NEW.status, ')'
    );

    INSERT INTO auditoria (id_log, usuario, acao, tabela_afetada, data_hora)
    VALUES (NULL, USER(), @mensagem, 'pedidos', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual._tri_auditoriaProdutos
DROP TRIGGER IF EXISTS `_tri_auditoriaProdutos`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `_tri_auditoriaProdutos` AFTER INSERT ON `produtos` FOR EACH ROW BEGIN
    SET @mensagem = CONCAT(
        'Produto adicionado: ', NEW.nome,
        ' (ID: ', NEW.id_produto,
        ', Categoria ID: ', NEW.categorias_id_categoria,
        ', Marca ID: ', NEW.marcas_id_marca, ')'
    );

    INSERT INTO auditoria (id_log, usuario, acao, tabela_afetada, data_hora)
    VALUES (NULL, USER(), @mensagem, 'produtos', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual._tri_auditoriaReembolsos
DROP TRIGGER IF EXISTS `_tri_auditoriaReembolsos`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `_tri_auditoriaReembolsos` AFTER INSERT ON `reembolsos` FOR EACH ROW BEGIN
    SELECT c.nome INTO @nomeCliente
    FROM clientes AS c
    JOIN pedidos AS p ON p.clientes_id_cliente = c.id_cliente
    WHERE p.id_pedidos = NEW.pedidos_id_pedidos;

    SET @mensagem = CONCAT(
        'Reembolso solicitado pelo cliente ', @nomeCliente,
        ' (Pedido ID: ', NEW.pedidos_id_pedidos,
        ', Valor: ', NEW.valor, ')'
    );

    INSERT INTO auditoria (id_log, usuario, acao, tabela_afetada, data_hora)
    VALUES (NULL, USER(), @mensagem, 'reembolsos', NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual._tri_estoquePosVenda
DROP TRIGGER IF EXISTS `_tri_estoquePosVenda`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `_tri_estoquePosVenda` BEFORE INSERT ON `itens_pedido` FOR EACH ROW BEGIN
    SELECT p.estoque INTO @estoqueP
    FROM produtos AS p
    WHERE p.id_produto = NEW.produtos_id_produto;

    IF @estoqueP < NEW.quantidade THEN
        SET @erro = CONCAT('Estoque do produto insuficiente. Estoque atual: ', @estoqueP);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @erro;
    ELSE
        UPDATE produtos AS p
        SET p.estoque = p.estoque - NEW.quantidade
        WHERE p.id_produto = NEW.produtos_id_produto;

        SELECT r.transportadoras_id_transportadora INTO @transportadora
        FROM rastreio_pedido AS r
        WHERE r.pedidos_id_pedido = NEW.pedidos_id_pedidos;

        INSERT INTO estoque (tipo, quantidade, data_movimento, produtos_id_produto, transportadoras_id_transportadora)
        VALUES ('Saída', NEW.quantidade, NOW(), NEW.produtos_id_produto, @transportadora);
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual._tri_precoUnitarioItensPedido
DROP TRIGGER IF EXISTS `_tri_precoUnitarioItensPedido`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `_tri_precoUnitarioItensPedido` BEFORE INSERT ON `itens_pedido` FOR EACH ROW BEGIN
    SELECT produtos.preco INTO @preco
    FROM produtos
    WHERE produtos.id_produto = NEW.produtos_id_produto;

    SET NEW.preco_unitario = @preco;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual._tri_reembolsoAutomatico
DROP TRIGGER IF EXISTS `_tri_reembolsoAutomatico`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `_tri_reembolsoAutomatico` AFTER UPDATE ON `pedidos` FOR EACH ROW BEGIN
    DECLARE v_pagamento INT;

    IF NEW.status = 'Cancelado' THEN

        SELECT id_pagamento INTO v_pagamento
        FROM pagamentos
        WHERE pedidos_id_pedidos = OLD.id_pedidos
        LIMIT 1;

        INSERT INTO reembolsos (valor, motivo, status, pedidos_id_pedidos, pagamentos_id_pagamento)
        VALUES (OLD.valor_total, 'Cancelamento de pedido', 'Pendente', OLD.id_pedidos, v_pagamento);

        UPDATE produtos AS p
        INNER JOIN itens_pedido AS i ON i.produtos_id_produto = p.id_produto
        SET p.estoque = p.estoque + i.quantidade
        WHERE i.pedidos_id_pedidos = OLD.id_pedidos;

    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual._tri_valorAutomaticoPagamentos
DROP TRIGGER IF EXISTS `_tri_valorAutomaticoPagamentos`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `_tri_valorAutomaticoPagamentos` BEFORE INSERT ON `pagamentos` FOR EACH ROW BEGIN
    SELECT valor_total INTO @valorPedido
    FROM pedidos
    WHERE id_pedidos = NEW.pedidos_id_pedidos;

    SET NEW.valor = @valorPedido;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual._tri_valorTotalAltera
DROP TRIGGER IF EXISTS `_tri_valorTotalAltera`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `_tri_valorTotalAltera` AFTER UPDATE ON `itens_pedido` FOR EACH ROW BEGIN
    DECLARE v_total DECIMAL(10,2);
    DECLARE v_tipo VARCHAR(20);
    DECLARE v_valor DECIMAL(10,2);
    DECLARE v_cupom_id INT;

    -- Se o item mudou de pedido, recalcula o pedido antigo também
    IF OLD.pedidos_id_pedidos <> NEW.pedidos_id_pedidos THEN
        SELECT IFNULL(SUM(i.quantidade * i.preco_unitario), 0)
        INTO v_total
        FROM itens_pedido AS i
        WHERE i.pedidos_id_pedidos = OLD.pedidos_id_pedidos;

        SELECT cupons_id_cupons INTO v_cupom_id
        FROM pedidos WHERE id_pedidos = OLD.pedidos_id_pedidos;

        IF v_cupom_id IS NOT NULL THEN
            SELECT tipo, valor INTO v_tipo, v_valor
            FROM cupons WHERE id_cupons = v_cupom_id;

            IF LOWER(v_tipo) = 'fixo' THEN
                SET v_total = v_total - v_valor;
            ELSEIF LOWER(v_tipo) = 'percentual' THEN
                SET v_total = v_total - (v_total * (v_valor / 100));
            END IF;

            IF v_total < 0 THEN SET v_total = 0; END IF;
        END IF;

        UPDATE pedidos SET valor_total = v_total
        WHERE id_pedidos = OLD.pedidos_id_pedidos;
    END IF;

    -- Recalcula o pedido novo (ou atual)
    SELECT IFNULL(SUM(i.quantidade * i.preco_unitario), 0)
    INTO v_total
    FROM itens_pedido AS i
    WHERE i.pedidos_id_pedidos = NEW.pedidos_id_pedidos;

    SELECT cupons_id_cupons INTO v_cupom_id
    FROM pedidos WHERE id_pedidos = NEW.pedidos_id_pedidos;

    IF v_cupom_id IS NOT NULL THEN
        SELECT tipo, valor INTO v_tipo, v_valor
        FROM cupons WHERE id_cupons = v_cupom_id;

        IF LOWER(v_tipo) = 'fixo' THEN
            SET v_total = v_total - v_valor;
        ELSEIF LOWER(v_tipo) = 'percentual' THEN
            SET v_total = v_total - (v_total * (v_valor / 100));
        END IF;

        IF v_total < 0 THEN SET v_total = 0; END IF;
    END IF;

    UPDATE pedidos SET valor_total = v_total
    WHERE id_pedidos = NEW.pedidos_id_pedidos;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual._tri_valorTotalDeleta
DROP TRIGGER IF EXISTS `_tri_valorTotalDeleta`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `_tri_valorTotalDeleta` AFTER DELETE ON `itens_pedido` FOR EACH ROW BEGIN
    SELECT IFNULL(SUM(i.quantidade * i.preco_unitario), 0)
    INTO @v_total
    FROM itens_pedido AS i
    WHERE i.pedidos_id_pedidos = OLD.pedidos_id_pedidos;

    SELECT cupons_id_cupons INTO @v_cupom_id
    FROM pedidos
    WHERE id_pedidos = OLD.pedidos_id_pedidos;

    IF @v_cupom_id IS NOT NULL THEN
        SELECT tipo, valor INTO @v_tipo, @v_valor
        FROM cupons
        WHERE id_cupons = @v_cupom_id;

        IF LOWER(@v_tipo) = 'fixo' THEN
            SET @v_total = @v_total - @v_valor;
        ELSEIF LOWER(@v_tipo) = 'percentual' THEN
            SET @v_total = @v_total - (@v_total * (@v_valor / 100));
        END IF;

        IF @v_total < 0 THEN
            SET @v_total = 0;
        END IF;
    END IF;

    UPDATE pedidos
    SET valor_total = @v_total
    WHERE id_pedidos = OLD.pedidos_id_pedidos;

    -- Devolve estoque ao produto
    UPDATE produtos AS p
    SET p.estoque = p.estoque + OLD.quantidade
    WHERE p.id_produto = OLD.produtos_id_produto;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual._tri_valorTotalInsere
DROP TRIGGER IF EXISTS `_tri_valorTotalInsere`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `_tri_valorTotalInsere` AFTER INSERT ON `itens_pedido` FOR EACH ROW BEGIN
    SELECT SUM(i.quantidade * i.preco_unitario)
    INTO @v_total
    FROM itens_pedido AS i
    WHERE i.pedidos_id_pedidos = NEW.pedidos_id_pedidos;

    SELECT cupons_id_cupons INTO @v_cupom_id
    FROM pedidos
    WHERE id_pedidos = NEW.pedidos_id_pedidos;

    IF @v_cupom_id IS NOT NULL THEN
        SELECT tipo, valor INTO @v_tipo, @v_valor
        FROM cupons
        WHERE id_cupons = @v_cupom_id;

        IF LOWER(@v_tipo) = 'fixo' THEN
            SET @v_total = @v_total - @v_valor;
        ELSEIF LOWER(@v_tipo) = 'percentual' THEN
            SET @v_total = @v_total - (@v_total * (@v_valor / 100));
        END IF;

        IF @v_total < 0 THEN
            SET @v_total = 0;
        END IF;
    END IF;

    UPDATE pedidos
    SET valor_total = @v_total
    WHERE id_pedidos = NEW.pedidos_id_pedidos;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual.tri_estoque_delete_item_pedido
DROP TRIGGER IF EXISTS `tri_estoque_delete_item_pedido`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `tri_estoque_delete_item_pedido` AFTER DELETE ON `itens_pedido` FOR EACH ROW BEGIN
    -- Devolve a quantidade ao estoque do produto
    UPDATE produtos
    SET estoque = estoque + OLD.quantidade
    WHERE id_produto = OLD.produtos_id_produto;

    -- Registra entrada na tabela estoque
    INSERT INTO estoque (tipo, quantidade, data_movimento, produtos_id_produto)
    VALUES ('Entrada', OLD.quantidade, NOW(), OLD.produtos_id_produto);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual.tri_estoque_insert_item_pedido
DROP TRIGGER IF EXISTS `tri_estoque_insert_item_pedido`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `tri_estoque_insert_item_pedido` BEFORE INSERT ON `itens_pedido` FOR EACH ROW BEGIN
    -- Busca o estoque atual do produto
    SELECT estoque INTO @estoque_atual
    FROM produtos
    WHERE id_produto = NEW.produtos_id_produto;

    -- Bloqueia se estoque insuficiente
    IF @estoque_atual < NEW.quantidade THEN
        SET @msg = CONCAT('Estoque insuficiente. Disponível: ', @estoque_atual, ' unidade(s).');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
    ELSE
        -- Abate do estoque do produto
        UPDATE produtos
        SET estoque = estoque - NEW.quantidade
        WHERE id_produto = NEW.produtos_id_produto;

        -- Registra saída na tabela estoque
        INSERT INTO estoque (tipo, quantidade, data_movimento, produtos_id_produto)
        VALUES ('Saída', NEW.quantidade, NOW(), NEW.produtos_id_produto);
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual.tri_nota_media_produto
DROP TRIGGER IF EXISTS `tri_nota_media_produto`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `tri_nota_media_produto` AFTER INSERT ON `avaliacoes` FOR EACH ROW BEGIN
    UPDATE produtos
    SET nota_media = (
        SELECT ROUND(AVG(nota), 2)
        FROM avaliacoes
        WHERE produtos_id_produto = NEW.produtos_id_produto
    )
    WHERE id_produto = NEW.produtos_id_produto;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual.tri_reembolso_automatico
DROP TRIGGER IF EXISTS `tri_reembolso_automatico`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `tri_reembolso_automatico` AFTER UPDATE ON `pedidos` FOR EACH ROW BEGIN
    DECLARE v_pagamento_id INT;

    -- Só age quando o status muda para 'Cancelado'
    IF NEW.status = 'Cancelado' AND OLD.status != 'Cancelado' THEN

        -- Busca o pagamento associado ao pedido
        SELECT id_pagamento INTO v_pagamento_id
        FROM pagamentos
        WHERE pedidos_id_pedidos = OLD.id_pedidos
        LIMIT 1;

        -- Só gera reembolso se existir pagamento
        IF v_pagamento_id IS NOT NULL THEN
            INSERT INTO reembolsos (valor, motivo, status, pedidos_id_pedidos, pagamentos_id_pagamento)
            VALUES (OLD.valor_total, 'Cancelamento de pedido', 'Pendente', OLD.id_pedidos, v_pagamento_id);
        END IF;

        -- Devolve estoque de todos os itens do pedido cancelado
        UPDATE produtos p
        INNER JOIN itens_pedido ip ON ip.produtos_id_produto = p.id_produto
        SET p.estoque = p.estoque + ip.quantidade
        WHERE ip.pedidos_id_pedidos = OLD.id_pedidos;

    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual.tri_status_pedido_pagamento
DROP TRIGGER IF EXISTS `tri_status_pedido_pagamento`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `tri_status_pedido_pagamento` AFTER INSERT ON `pagamentos` FOR EACH ROW BEGIN
    IF NEW.status = 'Aprovado' THEN
        UPDATE pedidos
        SET status = 'Pago'
        WHERE id_pedidos = NEW.pedidos_id_pedidos;
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual.tri_valor_total_delete
DROP TRIGGER IF EXISTS `tri_valor_total_delete`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `tri_valor_total_delete` AFTER DELETE ON `itens_pedido` FOR EACH ROW BEGIN
    UPDATE pedidos
    SET valor_total = (
        SELECT IFNULL(SUM(quantidade * preco_unitario), 0)
        FROM itens_pedido
        WHERE pedidos_id_pedidos = OLD.pedidos_id_pedidos
    )
    WHERE id_pedidos = OLD.pedidos_id_pedidos;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger projetolojavirtual.tri_valor_total_insert
DROP TRIGGER IF EXISTS `tri_valor_total_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `tri_valor_total_insert` AFTER INSERT ON `itens_pedido` FOR EACH ROW BEGIN
    UPDATE pedidos
    SET valor_total = (
        SELECT IFNULL(SUM(quantidade * preco_unitario), 0)
        FROM itens_pedido
        WHERE pedidos_id_pedidos = NEW.pedidos_id_pedidos
    )
    WHERE id_pedidos = NEW.pedidos_id_pedidos;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `vw_clientes_com_pedidos`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_clientes_com_pedidos` AS select `c`.`id_cliente` AS `id_cliente`,`c`.`nome` AS `nome`,`c`.`email` AS `email`,count(`p`.`id_pedidos`) AS `total_pedidos`,round(sum(`p`.`valor_total`),2) AS `total_gasto`,round(avg(`p`.`valor_total`),2) AS `ticket_medio` from (`clientes` `c` join `pedidos` `p` on((`p`.`clientes_id_cliente` = `c`.`id_cliente`))) group by `c`.`id_cliente`,`c`.`nome`,`c`.`email` order by `total_gasto` desc
;

-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `vw_itens_pedido_completo`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_itens_pedido_completo` AS select `ip`.`pedidos_id_pedidos` AS `id_pedido`,`pr`.`nome` AS `produto`,`pr`.`nota_media` AS `nota_media`,`ip`.`quantidade` AS `quantidade`,`ip`.`preco_unitario` AS `preco_unitario`,(`ip`.`quantidade` * `ip`.`preco_unitario`) AS `subtotal` from (`itens_pedido` `ip` join `produtos` `pr` on((`pr`.`id_produto` = `ip`.`produtos_id_produto`)))
;

-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `vw_pedidos_detalhados`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_pedidos_detalhados` AS select `p`.`id_pedidos` AS `id_pedidos`,`c`.`nome` AS `cliente`,`c`.`email` AS `email`,`c`.`telefone` AS `telefone`,`p`.`data` AS `data`,`p`.`status` AS `status`,`p`.`valor_total` AS `valor_total`,concat(`e`.`rua`,', ',`e`.`numero`,' - ',`e`.`bairro`,', ',`e`.`cidade`,'/',`e`.`estado`) AS `endereco_entrega` from ((`pedidos` `p` join `clientes` `c` on((`c`.`id_cliente` = `p`.`clientes_id_cliente`))) join `enderecos` `e` on((`e`.`id_endereco` = `p`.`enderecos_id_endereco`)))
;

-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `vw_produtos_estoque_baixo`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_produtos_estoque_baixo` AS select `p`.`id_produto` AS `id_produto`,`p`.`nome` AS `nome`,`p`.`estoque` AS `estoque`,`p`.`preco` AS `preco`,`c`.`nome` AS `categoria`,`m`.`nome` AS `marca` from ((`produtos` `p` join `categorias` `c` on((`c`.`id_categoria` = `p`.`categorias_id_categoria`))) join `marcas` `m` on((`m`.`id_marca` = `p`.`marcas_id_marca`))) where (`p`.`estoque` < 10) order by `p`.`estoque`
;

-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `vw_ranking_produtos`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_ranking_produtos` AS select `pr`.`id_produto` AS `id_produto`,`pr`.`nome` AS `nome`,`pr`.`preco` AS `preco`,`pr`.`nota_media` AS `nota_media`,`c`.`nome` AS `categoria`,sum(`ip`.`quantidade`) AS `total_vendido`,round(sum((`ip`.`quantidade` * `ip`.`preco_unitario`)),2) AS `receita_gerada` from ((`itens_pedido` `ip` join `produtos` `pr` on((`pr`.`id_produto` = `ip`.`produtos_id_produto`))) join `categorias` `c` on((`c`.`id_categoria` = `pr`.`categorias_id_categoria`))) group by `pr`.`id_produto`,`pr`.`nome`,`pr`.`preco`,`pr`.`nota_media`,`c`.`nome` order by `total_vendido` desc
;

-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `vw_receita_por_metodo_pagamento`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_receita_por_metodo_pagamento` AS select `pagamentos`.`metodo` AS `metodo`,count(0) AS `total_transacoes`,round(sum(`pagamentos`.`valor`),2) AS `receita_total`,round(avg(`pagamentos`.`valor`),2) AS `ticket_medio` from `pagamentos` where (`pagamentos`.`status` = 'Aprovado') group by `pagamentos`.`metodo` order by `receita_total` desc
;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
