CREATE DATABASE almoxarifado;

USE almoxarifado;

CREATE TABLE `categorias` (
  `id` int NOT NULL,
  `titulo` varchar(50) DEFAULT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `materiais` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(50) DEFAULT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `observacao` varchar(100) DEFAULT NULL,
  `id_categoria` int DEFAULT NULL,
  `quantidade` int DEFAULT NULL,
  `quantidade_disponivel` int DEFAULT NULL,
  `data_criacao` date DEFAULT NULL,
  `data_atualizacao` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_categoria` (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `alertas_estoque` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_material` int NOT NULL,
  `mensagem` varchar(255) DEFAULT NULL,
  `data_alerta` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alerta_material_idx` (`id_material`),
  CONSTRAINT `alerta_material` FOREIGN KEY (`id_material`) REFERENCES `materiais` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `fornecedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rasao_social` varchar(255) COLLATE utf8mb4_is_0900_ai_ci DEFAULT NULL,
  `cnpj` varchar(18) COLLATE utf8mb4_is_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_is_0900_ai_ci;

CREATE TABLE `compras` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_fornecedor` int NOT NULL,
  `id_material` int NOT NULL,
  `quantidade` int NOT NULL,
  `data_compra` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forncedor_compra_key_idx` (`id_fornecedor`),
  KEY `produto_compra_key_idx` (`id_material`),
  CONSTRAINT `forncedor_compra_key` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id`),
  CONSTRAINT `produto_compra_key` FOREIGN KEY (`id_material`) REFERENCES `materiais` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `usuarios` (
  `id` int NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `matricula` varchar(10) DEFAULT NULL,
  `id_setor` int DEFAULT NULL,
  `funcao` varchar(50) DEFAULT NULL,
  `senha` varchar(10) DEFAULT NULL,
  `data_criacao` date DEFAULT NULL,
  `data_atualizacao` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_setor` (`id_setor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `codigos_acesso` (
  `id` int NOT NULL,
  `id_usuario` int DEFAULT NULL,
  `codigo` int DEFAULT NULL,
  `data_criacao` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `enderecos_email_usuarios` (
  `id` int NOT NULL,
  `id_usuario` int DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `principal` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `enderecos_usuarios` (
  `id` int NOT NULL,
  `id_usuario` int DEFAULT NULL,
  `logradouro` varchar(20) DEFAULT NULL,
  `numero` varchar(5) DEFAULT NULL,
  `complemento` varchar(20) DEFAULT NULL,
  `bairro` varchar(20) DEFAULT NULL,
  `cidade` varchar(20) DEFAULT NULL,
  `estado` varchar(2) DEFAULT NULL,
  `cep` varchar(9) DEFAULT NULL,
  `principal` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `estoque_minimo` (
  `id` int NOT NULL,
  `id_material` int DEFAULT NULL,
  `quantidade_minima` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_material` (`id_material`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `forncedores_materiais` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_fornecedor` int NOT NULL,
  `id_material` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fornecedor_key_idx` (`id_fornecedor`),
  KEY `material_key_idx` (`id_material`),
  CONSTRAINT `fornecedor_key` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id`),
  CONSTRAINT `material_key` FOREIGN KEY (`id_material`) REFERENCES `materiais` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `itens_com_vencimento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_material` int NOT NULL,
  `data_vencimento` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vencimento_material_key_idx` (`id_material`),
  CONSTRAINT `vencimento_material_key` FOREIGN KEY (`id_material`) REFERENCES `materiais` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `materiais_aguardando_devolucao` (
  `id` int NOT NULL,
  `id_pedido_material` int DEFAULT NULL,
  `quantidade` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `data_devolucao` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_pedido_material` (`id_pedido_material`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `numeros_telefones_usuarios` (
  `id` int NOT NULL,
  `id_usuario` int DEFAULT NULL,
  `telefone` varchar(11) DEFAULT NULL,
  `principal` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pedidos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `observacao` varchar(100) DEFAULT NULL,
  `tipo_pedido` int DEFAULT NULL,
  `data_criacao` date DEFAULT NULL,
  `data_atualizacao` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pedidos_materiais` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_pedido` int DEFAULT NULL,
  `id_material` int DEFAULT NULL,
  `quantidade` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_material` (`id_material`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `registros_estoque` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_material` int NOT NULL,
  `tipo_movimento` varchar(45) DEFAULT NULL,
  `quantidade` int DEFAULT NULL,
  `data_registro` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `registro_material_idx` (`id_material`),
  CONSTRAINT `registro_material` FOREIGN KEY (`id_material`) REFERENCES `materiais` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `setores` (
  `id` int NOT NULL,
  `titulo` varchar(50) DEFAULT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
