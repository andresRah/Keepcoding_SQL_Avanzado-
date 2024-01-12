CREATE OR REPLACE TABLE keepcoding.ivr_summary AS
WITH phone_call_details AS (
    SELECT
        calls_ivr_id,
        calls_phone_number,
        calls_start_date,
        LAG(calls_start_date) OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date) AS previous_call,
        LEAD(calls_start_date) OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date) AS next_call
    FROM
        keepcoding.ivr_detail
)

SELECT
    d.calls_ivr_id AS ivr_id,
    MAX(d.calls_phone_number) AS phone_number,
    MAX(d.calls_ivr_result) AS ivr_result,
    CASE
        WHEN MAX(d.calls_vdn_label) LIKE 'ATC%' THEN 'FRONT'
        WHEN MAX(d.calls_vdn_label) LIKE 'TECH%' THEN 'TECH'
        WHEN MAX(d.calls_vdn_label) = 'ABSORPTION' THEN 'ABSORPTION'
        ELSE 'RESTO'
    END AS vdn_aggregation,
    MAX(d.calls_start_date) AS start_date,
    MAX(d.calls_end_date) AS end_date,
    MAX(d.calls_total_duration) AS total_duration,
    MAX(d.calls_customer_segment) AS customer_segment,
    MAX(d.calls_ivr_language) AS ivr_language,
    MAX(d.calls_steps_module) AS steps_module,
    MAX(d.calls_module_aggregation) AS module_aggregation,
    MAX(d.document_type) AS document_type,
    MAX(d.document_identification) AS document_identification,
    MAX(d.customer_phone) AS customer_phone,
    MAX(d.billing_account_id) AS billing_account_id,
    MAX(CASE WHEN d.module_name = 'AVERIA_MASIVA' THEN 1 ELSE 0 END) AS masiva_lg,
    MAX(CASE WHEN d.step_name = 'CUSTOMERINFOBYPHONE.TX' AND d.step_description_error = 'UNKNOWN' THEN 1 ELSE 0 END) AS info_by_phone_lg,
    MAX(CASE WHEN d.step_name = 'CUSTOMERINFOBYDNI.TX' AND d.step_description_error = 'UNKNOWN' THEN 1 ELSE 0 END) AS info_by_dni_lg,
    MAX(CASE
        WHEN TIMESTAMP_DIFF(d.calls_start_date, pcd.previous_call, HOUR) <= 24 THEN 1
        ELSE 0
    END) AS repeated_phone_24H,
    MAX(CASE
        WHEN TIMESTAMP_DIFF(pcd.next_call, d.calls_start_date, HOUR) <= 24 THEN 1
        ELSE 0
    END) AS cause_recall_phone_24H
FROM
    keepcoding.ivr_detail d
LEFT JOIN
    phone_call_details pcd ON d.calls_ivr_id = pcd.calls_ivr_id
GROUP BY
    d.calls_ivr_id;
