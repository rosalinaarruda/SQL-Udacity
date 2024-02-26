-- Qual é o valor médio vitalício gasto em termos de total_amt_usd para as 10 principais contas com gastos totais ?

-- selecionando os 10 clientes com mais gastos totais

SELECT a.id, a.name, SUM(o.total_amt_usd) total_gasto
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 10

-- calculando o valor medio vitalicio gasto

SELECT AVG(total_gasto)
FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) total_gasto
	FROM accounts a
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY 1,2
	ORDER BY 3 DESC
	LIMIT 10) media