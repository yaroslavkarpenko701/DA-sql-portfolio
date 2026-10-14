WITH union_sum_price_revenue_predict_per_day AS(
  SELECT
      rp.date AS day_date,
      SUM(rp.predict) AS sum_predict,
      0 AS sum_price
FROM `data-analytics-mate.DA.revenue_predict` AS rp

GROUP BY day_date


UNION ALL


SELECT
      s.date,
      0 AS sum_predict,
      SUM(pr.price) AS sum_price

FROM `data-analytics-mate.DA.product` as pr

JOIN `data-analytics-mate.DA.order` as o
  ON pr.item_id = o.item_id
JOIN `data-analytics-mate.DA.session` as s
  ON s.ga_session_id = o.ga_session_id

GROUP BY s.date

), 
-- виконали union all та взяли суму по ціні та sum_predict

sum_all AS(
SELECT
      day_date,
      SUM(sum_predict) AS sum_predict,
      SUM(sum_price) AS sum_price
 
FROM union_sum_price_revenue_predict_per_day 

GROUP BY day_date

),
-- обєднали все разом, щоб не було нулів


accumulated_price_predict AS(

SELECT 
      day_date,
      SUM(sum_price) OVER(ORDER BY day_date) AS a_sum_price,
      SUM(sum_predict) OVER(ORDER BY day_date) AS a_sum_predict

FROM sum_all
)
-- знайшли накопичення по днях


SELECT 
      day_date,
      a_sum_price,
      a_sum_predict,
      ROUND(a_sum_price / a_sum_predict * 100, 2) AS percent_between_revenue_predict
FROM accumulated_price_predict

-- обрахували відсоток та вивели суму з накопиченням для прогнозованої та ціни
