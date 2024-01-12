CREATE OR REPLACE FUNCTION keepcoding.clean_integer(input_value INT64)
RETURNS INT64
AS (
  IFNULL(input_value, -999999)
);
