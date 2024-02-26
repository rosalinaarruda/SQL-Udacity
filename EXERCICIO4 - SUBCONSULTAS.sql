-- Para o cliente que gastou mais (no total durante sua vida como cliente) total_amt_usd , quantos web_events ele teve para cada canal?

-- selecionando o cliente que mais gastou
SELECT a.id ID, a.name cliente, SUM(o.total_amt_usd)
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2
LIMIT 1

-- selecionando o numero de eventos deste cliente em cada canal, combinando apenas o ID
SELECT a.name cliente, w.channel canal, COUNT(*) qtde_eventos
FROM web_events w
JOIN accounts a
ON a.id = w.account_id AND a.id = (SELECT id
								   FROM (SELECT a.id ID, a.name cliente, SUM(o.total_amt_usd)
										FROM accounts a
										JOIN orders o
										ON a.id = o.account_id
										GROUP BY 1 , 2
										ORDER BY 3 DESC
										LIMIT 1) mais_gastou)
GROUP BY 1,2
ORDER BY 3 DESC