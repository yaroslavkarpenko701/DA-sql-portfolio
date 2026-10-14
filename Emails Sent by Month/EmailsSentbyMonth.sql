SELECT
      sent_month,
      id_account,
      sent_msg_percent_from_this_month,
      first_sent_date,
      last_sent_date

FROM
(
SELECT
      date_month.sent_month,
      id_account,
      COUNT(id_message) AS cnt_email_for_acc,
      --SUM(COUNT(id_message)) OVER(PARTITION BY sent_month) AS cnt_total_email_per_month,
      ROUND(COUNT(id_message) / MAX(cnt_total_email_per_month) * 100, 4) AS sent_msg_percent_from_this_month,
      MIN(actual_sent_date) AS first_sent_date,
      MAX(actual_sent_date) AS last_sent_date

FROM
(
SELECT  
--s.date,
es.id_account,
DATE_TRUNC(DATE_ADD(s.date, INTERVAL es.sent_date DAY), MONTH) AS sent_month, -- Змінив обрахунок дати
es.id_message,
DATE_ADD(s.date, INTERVAL es.sent_date DAY) AS actual_sent_date,
COUNT(es.id_message) OVER(PARTITION BY DATE_TRUNC(DATE_ADD(s.date, INTERVAL es.sent_date DAY), MONTH)) AS cnt_total_email_per_month

FROM `data-analytics-mate.DA.email_sent`  AS es
INNER JOIN `data-analytics-mate.DA.account_session`  AS acs
  ON es.id_account = acs.account_id
INNER JOIN `data-analytics-mate.DA.session`  AS s
  ON acs.ga_session_id = s.ga_session_id
) AS date_month

GROUP BY sent_month, id_account
) AS email_percent_for_acc

ORDER BY sent_month DESC, id_account ASC 
