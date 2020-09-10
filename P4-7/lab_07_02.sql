SELECT region_id, country_name
FROM HR.countries
WHERE country_id IN (
      SELECT country_id
      FROM HR.locations 
      WHERE location_id IN (
            SELECT location_id FROM HR.locations
            MINUS
            SELECT location_id FROM HR.departments)
            );
