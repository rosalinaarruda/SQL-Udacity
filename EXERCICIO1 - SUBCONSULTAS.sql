---Forneça o nome do representante de vendas em cada região com o maior valor de vendas total_amt_usd. 
---PARA ESTE, DESEJA-SE APENAS O MAIOR DE CADA REGIÃO, AÍ QUE ENTRA A A SUBCONSULTA.

SELECT tbl_2.regiao, tbl_3.representante, tbl_2.total_maximo
FROM	
    (SELECT regiao, MAX(total) total_maximo
	FROM (
		SELECT s.name representante, r.name regiao, SUM(o.total_amt_usd) total
		FROM accounts a
		JOIN orders o
		ON a.id = o.account_id
		JOIN sales_reps s
		ON s.id = a.sales_rep_id
		JOIN region r
		ON r.id = s.region_id
		GROUP BY 1,2
		ORDER BY 3 DESC ) tbl_1
	GROUP BY 1) tbl_2
JOIN (
	SELECT s.name representante, r.name regiao, SUM(o.total_amt_usd) total
	FROM accounts a
	JOIN orders o
	ON a.id = o.account_id
	JOIN sales_reps s
	ON s.id = a.sales_rep_id
	JOIN region r
	ON r.id = s.region_id
	GROUP BY 1,2
	ORDER BY 3 DESC) tbl_3
ON tbl_2.regiao = tbl_3.regiao AND tbl_2.total_maximo = tbl_3.total

