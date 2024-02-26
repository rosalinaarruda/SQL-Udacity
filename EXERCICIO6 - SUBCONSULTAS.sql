-- Qual é o valor médio gasto ao longo da vida em termos de total_amt_usd , 
-- incluindo apenas as empresas que gastaram mais por pedido, em média, do que a média de todos os pedidos.

-- extraindo a media de todas as contas 

SELECT AVG(o.total_amt_usd) mediatotal
FROM orders o

-- agora apenas as contas com mais que isso de quantidade media
SELECT o.account_id, AVG(o.total_amt_usd) media_usd
FROM ORDERS O
GROUP BY 1
HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) mediatotal
							   FROM orders o)

-- agora, apenas a media desses valores
SELECT AVG(media_usd) 
FROM (SELECT o.account_id, AVG(o.total_amt_usd) media_usd
	FROM ORDERS O
	GROUP BY 1
	HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) mediatotal
							   FROM orders o)) tab