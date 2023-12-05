\copy public.OxCGRT_nat_latest
FROM '/Library/PostgreSQL/15/bin/HW2_Datas/OxCGRT_nat_latest.csv'
WITH (FORMAT csv, HEADER, DELIMITER ',');

\copy public.country_and_continent_codes_list
FROM '/Library/PostgreSQL/15/bin/HW2_Datas/country-and-continent-codes-list-csv.csv'
WITH (FORMAT csv, HEADER, DELIMITER ',');

INSERT INTO
	country_and_continent_codes_list
VALUES
	('Europe', 'EU', 'Kosovo, Republic of', 'KS', 'RKS', 383);

INSERT INTO 
    public.Countries
SELECT DISTINCT
    Two_Letter_Country_Code,
    Three_Letter_Country_Code, 
    Country_Name,
    Country_Number 
FROM 
    country_and_continent_codes_list;

UPDATE 
	Countries
SET 
	Country_Name = OxCGRT_nat_latest.CountryName
FROM
	OxCGRT_nat_latest
WHERE
    OxCGRT_nat_latest.CountryCode = Countries.Three_Letter_Country_Code;

INSERT INTO 
    public.Continents
SELECT DISTINCT
    Continent_Code,
    Continent_Name
FROM 
    country_and_continent_codes_list;

INSERT INTO 
    public.Country_Continent
SELECT DISTINCT
    Two_Letter_Country_Code,
    Continent_Code
FROM 
    country_and_continent_codes_list;

INSERT INTO 
    public.Policy_Indicators
SELECT DISTINCT
    Two_Letter_Country_Code,
    Date_,
    C1M,
    C2M,
    C3M,
    C4M,
    C5M,
    C6M,
    C7M,
    C8EV,
    C1M_Flag,
    C2M_Flag,
    C3M_Flag,
    C4M_Flag,
    C5M_Flag,
    C6M_Flag,
    C7M_Flag,
    E1,
    E2,
    E3,
    E4,
    E1_Flag,
    H1,
    H2,
    H3,
    H4,
    H5,
    H6M,
    H7,
    H8M,
    H1_Flag,
    H6M_Flag,
    H7_Flag,
    H8M_Flag,
    M1,
    V1,
    V2A,
    V2C,
    V2D,
    V2E,
    V2F,
    V2G,
    V3,
    V4
FROM 
    OxCGRT_nat_latest JOIN Countries ON
        OxCGRT_nat_latest.CountryCode = Countries.Three_Letter_Country_Code;

INSERT INTO
    public.Statistic
SELECT DISTINCT
    Two_Letter_Country_Code,
    Date_,
    PopulationVaccinated,
    ConfirmedCases,
    ConfirmedDeaths
FROM
    OxCGRT_nat_latest JOIN Countries ON
        OxCGRT_nat_latest.CountryCode = Countries.Three_Letter_Country_Code;

INSERT INTO
    public.Indices
SELECT DISTINCT
    Two_Letter_Country_Code,
    Date_,
	StringencyIndex_Average_ForDisplay,
    GovernmentResponseIndex_Average_ForDisplay,
    ContainmentHealthIndex_Average_ForDisplay,
    EconomicSupportIndex_ForDisplay
FROM
    OxCGRT_nat_latest JOIN Countries ON
        OxCGRT_nat_latest.CountryCode = Countries.Three_Letter_Country_Code;

