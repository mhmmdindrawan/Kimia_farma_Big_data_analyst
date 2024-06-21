CREATE OR REPLACE TABLE
  project-based-virtual-intern.projectkimiafarmaxrakamin.analysis_table AS
SELECT
  ft.transaction_id,
  ft.date,
  ft.branch_id,
  kc.branch_name,
  kc.kota,
  kc.provinsi,
  kc.rating AS rating_cabang,
  ft.customer_name,
  ft.product_id,
  p.product_name,
  ft.price AS actual_price,
  ft.rating AS rating_transaksi,
  ft.discount_percentage,
  CASE
    WHEN ft.price <= 50000 THEN 10
    WHEN ft.price > 50000 AND ft.price <= 100000 THEN 15
    WHEN ft.price > 100000 AND ft.price <= 300000 THEN 20
    WHEN ft.price > 300000 AND ft.price <= 500000 THEN 25
    ELSE 30
  END AS persentase_gross_laba,
  ft.price * (1 - ft.discount_percentage / 100) AS nett_sales,
  (ft.price * (1 - ft.discount_percentage / 100)) * (
    CASE
      WHEN ft.price <= 50000 THEN 0.10
      WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
      WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.20
      WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
      ELSE 0.30
  END) AS nett_profit
FROM
  project-based-virtual-intern.projectkimiafarmaxrakamin.kf_final_transaction AS ft
JOIN
  project-based-virtual-intern.projectkimiafarmaxrakamin.kf_product AS p
ON
  ft.product_id = p.product_id
JOIN
  project-based-virtual-intern.projectkimiafarmaxrakamin.kf_inventory AS inv
ON
  ft.product_id = inv.product_id
  AND ft.branch_id = inv.branch_id
JOIN
  project-based-virtual-intern.projectkimiafarmaxrakamin.kf_kantor_cabang AS kc
ON
  ft.branch_id = kc.branch_id;
