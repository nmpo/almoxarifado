/***CRIAÇÃO DOS GATILHOS ***/

DELIMITER //
 CREATE TRIGGER `atualizar_quantidade` AFTER INSERT ON `compras` FOR EACH ROW BEGIN 	
    UPDATE materiais SET materiais.quantidade = materiais.quantidade + NEW.quantidade, quantidade_disponivel = materiais.quantidade_disponivel + NEW.quantidade 
    WHERE materiais.id = NEW.id_material;
END ; //
DELIMITER ;

DELIMITER //
CREATE TRIGGER `after_insert_materiais` AFTER INSERT ON `materiais` FOR EACH ROW BEGIN
    INSERT INTO registros_estoque (id_material, tipo_movimento, quantidade, data_registro)
    VALUES (NEW.id, 'Entrada', NEW.quantidade, NOW());
END ; //
DELIMITER;

DELIMITER //
CREATE TRIGGER `after_update_quantidade_disponivel` AFTER UPDATE ON `materiais` FOR EACH ROW BEGIN
DECLARE estoque_min INT;
    SELECT quantidade_minima INTO estoque_min
    FROM estoque_minimo
    WHERE id_material = NEW.id;

    IF NEW.quantidade_disponivel < estoque_min THEN 
        INSERT INTO alertas_estoque (id_material, mensagem, data_alerta)
        VALUES (NEW.id, 'Estoque baixo', NOW());
    END IF;
END ; //
DELIMITER ;