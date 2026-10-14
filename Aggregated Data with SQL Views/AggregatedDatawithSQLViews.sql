-- створення представлення

CREATE VIEW `data-analytics-mate.Students.v_agr_date_Karpenko` AS
WITH found_date AS(
SELECT  
      --s.date AS sent_month,
      DATE_ADD(s.date, INTERVAL es.sent_date DAY) AS new_date,
      DATE_TRUNC(DATE_ADD(s.date, INTERVAL es.sent_date DAY), MONTH) AS sent_month,
      es.id_account,
      es.id_message

FROM `data-analytics-mate.DA.email_sent` AS es
JOIN `data-analytics-mate.DA.account_session` AS acs
  ON es.id_account = acs.account_id
JOIN `data-analytics-mate.DA.session` AS s
  ON s.ga_session_id = acs.ga_session_id
),

cnt_email_first_last_day AS(
SELECT 
      sent_month,
      id_account,
      COUNT(id_message) AS cnt_em,
      MIN(new_date) AS first_sent_date,
      MAX(new_date) AS last_sent_date

FROM found_date

GROUP BY sent_month, id_account
),

msg_from_this_month AS(
SELECT
      sent_month,
      COUNT(id_message) AS cnt_email_total

FROM found_date
GROUP BY found_date.sent_month

)

SELECT 
      cnt_email_first_last_day.sent_month,
      cnt_email_first_last_day.id_account,
      ROUND(cnt_email_first_last_day.cnt_em / msg_from_this_month.cnt_email_total * 100,5) AS sent_msg_percent_from_this_month,
      first_sent_date,
      last_sent_date
FROM cnt_email_first_last_day
JOIN msg_from_this_month
  On cnt_email_first_last_day.sent_month = msg_from_this_month.sent_month
ORDER BY sent_month DESC, id_account ASC;




/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


--  результат

SELECT *
FROM `Students.v_agr_date_Karpenko`
