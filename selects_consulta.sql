/**Problema: Quero calcular o total de itens disponíveis para cada categoria no almoxarifado.*/

SELECT c.titulo AS categoria, 
SUM(m.quantidade_disponivel) AS total_itens_disponiveis
FROM categorias c
JOIN materiais m ON c.id = m.id_categoria
GROUP BY c.titulo;



/**Histórico de Saídas de um Item Específico:
Problema: Desejo visualizar o histórico de todas as saídas de um item específico do estoque.

A consulta a seguir busca o histórico de todas as saídas do item “Notebook Dell Inspiron 15"” e apresenta cada saída em ordem decrescente, ou seja, da mais recente para a mais antiga. */

SELECT materiais.titulo, pedidos.data_criacao AS data_pedido, pedidos_materiais.quantidade 
FROM pedidos_materiais 
INNER JOIN pedidos ON pedidos.id = pedidos_materiais.id_pedido 
INNER JOIN materiais ON materiais.id = pedidos_materiais.id_material 
WHERE pedidos_materiais.id_material = 5 ORDER BY data_pedido DESC;



/* Itens Próximos à Data de Vencimento:
Problema: Preciso identificar os itens que estão próximos da data de vencimento. */

SELECT materiais.id, materiais.titulo, data_vencimento, 
DATEDIFF(data_vencimento, NOW()) AS dias_restantes  
FROM itens_com_vencimento
JOIN materiais ON itens_com_vencimento.id_material = materiais.id 
WHERE DATEDIFF(data_vencimento, NOW()) < 60 ;


