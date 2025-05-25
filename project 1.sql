-- Top 3 most ordered pizza types based on revenue for each pizza category

WITH ranked_pizzas AS (
    SELECT pt.category, pt.name, 
           ROUND(SUM(o.quantity * p.price), 2) AS total_revenue,
           RANK() OVER (PARTITION BY pt.category ORDER BY SUM(o.quantity * p.price) DESC) AS rank_no
    FROM order_details o
    JOIN pizzas p ON o.pizza_id = p.pizza_id
    JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category, pt.name
)
SELECT category, name, total_revenue
FROM ranked_pizzas
WHERE rank_no <= 3;




