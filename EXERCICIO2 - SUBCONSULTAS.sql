#Para a região com a maior (soma) de vendas total_amt_usd , quantos pedidos totais (contagem) foram feitos?


SELECT r.name regiao, 	COUNT(o.total) total_pedidos    #CONTA AS QUANTIDADES POR REGIAO
FROM accounts a
JOIN orders o
ON a.id = o.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY 1
HAVING sum(o.total_amt_usd) = (
		SELECT  MAX(total_usd) total_max   #DESCOBRE POR REGIAO O TOTAL MAXIMO EM DOLAR
		FROM (
			SELECT r.name regiao, SUM(o.total_amt_usd) total_usd  #SOMA DO TOTAL EM DOLAR POR REGIAO
			FROM accounts a
			JOIN orders o
			ON a.id = o.account_id
			JOIN sales_reps s
			ON s.id = a.sales_rep_id
			JOIN region r
			ON r.id = s.region_id
			GROUP BY 1 ) tbl1)

