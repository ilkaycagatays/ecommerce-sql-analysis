-- ============================================================
-- E-Commerce SQL Analysis
-- Dataset: UCI Online Retail II (2009-2011)
-- ============================================================


-- 1. TOPLAM SATIR SAYISI
-- Tablodaki toplam kayıt sayısını döndürür
SELECT COUNT(*) AS toplam_satir
FROM orders;


-- 2. TOP 10 MÜŞTERİ (REVENUE'YE GÖRE)
-- En çok gelir getiren 10 müşteriyi listeler
SELECT
    "Customer ID",
    ROUND(SUM(Revenue), 2) AS total_revenue,
    COUNT(DISTINCT Invoice)  AS total_orders
FROM orders
GROUP BY "Customer ID"
ORDER BY total_revenue DESC
LIMIT 10;


-- 3. AYLIK REVENUE TRENDİ
-- Her aya ait toplam gelir ve sipariş sayısını döndürür
SELECT
    SUBSTR(InvoiceDate, 1, 7) AS month,
    ROUND(SUM(Revenue), 2)    AS monthly_revenue,
    COUNT(DISTINCT Invoice)   AS order_count
FROM orders
GROUP BY month
ORDER BY month;


-- 4. ÜLKE BAZINDA REVENUE (TOP 10)
-- En çok gelir getiren 10 ülkeyi listeler
SELECT
    Country,
    ROUND(SUM(Revenue), 2)          AS total_revenue,
    COUNT(DISTINCT "Customer ID")   AS customer_count
FROM orders
GROUP BY Country
ORDER BY total_revenue DESC
LIMIT 10;


-- 5. EN ÇOK SATAN ÜRÜNLER (TOP 10)
-- Satış adedine göre en popüler 10 ürünü listeler
SELECT
    Description,
    SUM(Quantity)          AS total_quantity,
    ROUND(SUM(Revenue), 2) AS total_revenue
FROM orders
GROUP BY Description
ORDER BY total_quantity DESC
LIMIT 10;


-- 6. RFM MÜŞTERİ SEGMENTASYONU (TOP 20)
-- Recency, Frequency ve Monetary değerlerine göre
-- en değerli 20 müşteriyi listeler
SELECT
    "Customer ID",
    ROUND(julianday('2011-12-31') - julianday(MAX(InvoiceDate)), 0) AS recency,
    COUNT(DISTINCT Invoice)                                          AS frequency,
    ROUND(SUM(Revenue), 2)                                          AS monetary
FROM orders
GROUP BY "Customer ID"
ORDER BY monetary DESC
LIMIT 20;
