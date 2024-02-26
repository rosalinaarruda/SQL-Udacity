-- encontrando a conta que mais comprou papel standard

SELECT a.name conta, SUM(o.standard_qty) qtde_standard, SUM(o.total) qtde_total
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

-- faz um segundo select para agrupar por nome e com o having comparar com o primeiro select as contas com 
-- total de compras maior que a conta que comprou mais standard

SELECT a.name 
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY 1
HAVING SUM(o.total) > (SELECT qtde_total
					   FROM ( SELECT a.name conta, SUM(o.standard_qty) qtde_standard, SUM(o.total) qtde_total
							  FROM accounts a
						      JOIN orders o
							  ON a.id = o.account_id
							  GROUP BY 1
							  ORDER BY 2 DESC
							  LIMIT 1) qtde_st)

-- faz uma ultima subsequencia, para obter a contagem

SELECT COUNT(*)
FROM (
	SELECT a.name 
	FROM orders o
	JOIN accounts a
	ON a.id = o.account_id
	GROUP BY 1
	HAVING SUM(o.total) > (SELECT qtde_total
		FROM (
			SELECT a.name conta, SUM(o.standard_qty) qtde_standard, SUM(o.total) qtde_total
			FROM accounts a
			JOIN orders o
			ON a.id = o.account_id
			GROUP BY 1
			ORDER BY 2 DESC
			LIMIT 1) qtde_st)
		) contagem;
