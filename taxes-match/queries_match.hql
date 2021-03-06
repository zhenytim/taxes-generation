
# DROP TABLE seller_errors;
# DROP TABLE customer_errors;
# DROP TABLE seller_correct;
# DROP TABLE customer_correct;
# DROP TABLE seller_correct_correct_completely;
# DROP TABLE customer_correct_correct_completely;
# DROP TABLE seller_errors_seller_has_pair;
# DROP TABLE seller_errors_customer_has_pair;
# DROP TABLE customer_errors_customer_has_pair;
# DROP TABLE customer_errors_seller_has_pair;


$ QUERY_SELLER_ERRORS $
CREATE TABLE IF NOT EXISTS seller_errors AS
SELECT s.seller_inn AS seller_inn_err,
       s.seller_kpp AS seller_kpp_err,
       s.customer_inn AS customer_inn_err,
       s.customer_kpp AS customer_kpp_err,
       s.total_with_tax AS total_with_tax_err,
       s.total_without_tax AS total_without_tax_err
FROM seller s
LEFT JOIN customer c ON s.customer_inn = c.customer_inn
AND s.seller_inn = c.seller_inn
AND s.customer_kpp = c.customer_kpp
AND s.seller_kpp = c.seller_kpp
WHERE c.customer_inn IS NULL
  AND c.seller_inn IS NULL
  AND c.customer_kpp IS NULL
  AND c.seller_kpp IS NULL;

$ QUERY_CUSTOMER_ERRORS $
CREATE TABLE IF NOT EXISTS customer_errors AS
SELECT c.customer_inn AS customer_inn_err,
       c.customer_kpp AS customer_kpp_err,
       c.seller_inn AS seller_inn_err,
       c.seller_kpp AS seller_kpp_err,
       c.total_with_tax AS total_with_tax_err,
       c.total_without_tax AS total_without_tax_err
FROM customer c
LEFT JOIN seller s ON C.customer_inn = s.customer_inn
AND c.seller_inn = s.seller_inn
AND s.customer_kpp = c.customer_kpp
AND s.seller_kpp = c.seller_kpp
WHERE s.customer_inn IS NULL
  AND s.seller_inn IS NULL
  AND s.customer_kpp IS NULL
  AND s.seller_kpp IS NULL;

$ QUERY_SELLER_CORRECT $
CREATE TABLE IF NOT EXISTS seller_correct AS
SELECT s.seller_inn AS seller_inn_corr,
       s.seller_kpp AS seller_kpp_corr,
       s.customer_inn AS customer_inn_corr,
       s.customer_kpp AS customer_kpp_corr,
       s.total_with_tax AS total_with_tax_corr,
       s.total_without_tax AS total_without_tax_corr
FROM seller s
INNER JOIN customer c ON s.customer_inn = c.customer_inn
AND s.seller_inn = c.seller_inn
AND s.customer_kpp = c.customer_kpp
AND s.seller_kpp = c.seller_kpp ;

$ QUERY_CUSTOMER_CORRECT $
CREATE TABLE IF NOT EXISTS customer_correct AS
SELECT c.customer_inn AS customer_inn_corr,
       c.customer_kpp AS customer_kpp_corr,
       c.seller_inn AS seller_inn_corr,
       c.seller_kpp AS seller_kpp_corr,
       c.total_with_tax AS total_with_tax_corr,
       c.total_without_tax AS total_without_tax_corr
FROM customer c
INNER JOIN seller s ON c.customer_inn = s.customer_inn
AND c.seller_inn = s.seller_inn
AND s.customer_kpp = c.customer_kpp
AND s.seller_kpp = c.seller_kpp;

$ QUERY_CORRECT_COMPLETELY $
CREATE TABLE IF NOT EXISTS correct_completely AS
SELECT s.seller_inn_corr AS seller_inn_corr,
       s.seller_kpp_corr AS seller_kpp_corr,
       s.customer_inn_corr AS customer_inn_corr,
       s.customer_kpp_corr AS customer_kpp_corr,
       s.total_with_tax_corr AS total_with_tax_corr,
       s.total_without_tax_corr AS total_without_tax_corr,
FROM seller_correct s
INNER JOIN customer_correct c ON s.customer_inn_corr = c.customer_inn_corr
AND s.seller_inn_corr = c.seller_inn_corr
AND s.customer_kpp_corr = c.customer_kpp_corr
AND s.seller_kpp_corr = c.seller_kpp_corr
AND s.total_with_tax_corr = c.total_with_tax_corr
AND s.total_without_tax_corr = c.total_without_tax_corr ;

$ QUERY_CORRECT_TOTAL_DIFF $
CREATE TABLE IF NOT EXISTS correct_total_diff AS
SELECT s.seller_inn_corr AS seller_inn_corr,
       s.seller_kpp_corr AS seller_kpp_corr,
       s.customer_inn_corr AS customer_inn_corr,
       s.customer_kpp_corr AS customer_kpp_corr,
       s.total_with_tax_corr AS total_with_tax_corr,
       s.total_without_tax_corr AS total_without_tax_corr
FROM seller_correct s
LEFT JOIN customer_correct c ON s.total_with_tax_corr = c.total_with_tax_corr
AND s.total_without_tax_corr = c.total_without_tax_corr
AND s.customer_inn_corr = c.customer_inn_corr
AND s.seller_inn_corr = c.seller_inn_corr
AND s.customer_kpp_corr = c.customer_kpp_corr
AND s.seller_kpp_corr = c.seller_kpp_corr
WHERE c.total_with_tax_corr IS NULL
  AND c.total_without_tax_corr IS NULL ;

$ QUERY_SELLER_ERRORS_SELLER_HAS_PAIR $
CREATE TABLE IF NOT EXISTS seller_errors_seller_has_pair AS
SELECT s.seller_inn_err AS seller_inn_err,
       s.seller_kpp_err AS seller_kpp_err,
       s.customer_inn_err AS customer_inn_err,
       s.customer_kpp_err AS customer_kpp_err,
       s.total_with_tax_err AS total_with_tax_err,
       s.total_without_tax_err AS total_without_tax_err
FROM seller_errors s
INNER JOIN customer_errors c ON s.seller_inn_err = c.seller_inn_err
AND s.seller_kpp_err = c.seller_kpp_err ;

$ QUERY_CUSTOMER_ERRORS_SELLER_HAR_PAIR $
CREATE TABLE IF NOT EXISTS customer_errors_seller_has_pair AS
SELECT c.customer_inn_err AS customer_inn_err,
       c.customer_kpp_err AS customer_kpp_err,
       c.seller_inn_err AS seller_inn_err,
       c.seller_kpp_err AS seller_kpp_err,
       c.total_with_tax_err AS total_with_tax_err,
       c.total_without_tax_err AS total_without_tax_err
FROM customer_errors c
INNER JOIN seller_errors s ON c.seller_inn_err = s.seller_inn_err
AND s.seller_kpp_err = c.seller_kpp_err ;

$ QUERY_SELLER_ERRORS_CUSTOMER_HAS_PAIR $
CREATE TABLE IF NOT EXISTS seller_errors_customer_has_pair AS
SELECT s.seller_inn_err AS seller_inn_err,
       s.seller_kpp_err AS seller_kpp_err,
       s.customer_inn_err AS customer_inn_err,
       s.customer_kpp_err AS customer_kpp_err,
       s.total_with_tax_err AS total_with_tax_err,
       s.total_without_tax_err AS total_without_tax_err
FROM seller_errors s
INNER JOIN customer_errors c ON s.customer_inn_err = c.customer_inn_err
AND s.customer_kpp_err = c.customer_kpp_err ;

$ QUERY_CUSTOMER_ERRORS_CUSTOMER_HAS_PAIR $
CREATE TABLE IF NOT EXISTS customer_errors_customer_has_pair AS
SELECT c.customer_inn_err AS customer_inn_err,
       c.customer_kpp_err AS customer_kpp_err,
       c.seller_inn_err AS seller_inn_err,
       c.seller_kpp_err AS seller_kpp_err,
       c.total_with_tax_err AS total_with_tax_err,
       c.total_without_tax_err AS total_without_tax_err
FROM customer_errors c
INNER JOIN seller_errors s ON c.customer_inn_err = s.customer_inn_err
AND s.customer_kpp_err = c.customer_kpp_err ;
