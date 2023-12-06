WITH StringencyIndex(Date, Continent_Code, Maximum, Minimum) AS(
	SELECT
		Date,
		Continent_Code,
		MAX(StringencyIndex_Average_ForDisplay),
		Min(StringencyIndex_Average_ForDisplay)
	FROM
		Indices NATURAL JOIN Country_Continent
	WHERE 
		Date = 20200401 OR Date = 20210401 OR Date = 20220401 
	GROUP BY
		Date, Continent_Code
	),
	CountryCode_Index AS(
	SELECT 
		S.Date,
		S.Continent_Code,
		S.Maximum,
		MaxCountry_Continent.Two_Letter_Country_Code AS Max_CountryCode,
		S.Minimum,
		MinCountry_Continent.Two_Letter_Country_Code AS Min_CountryCode
	FROM
		StringencyIndex AS S
		LEFT JOIN (Indices NATURAL JOIN Country_Continent) AS MaxCountry_Continent
			ON (S.Maximum = MaxCountry_Continent.StringencyIndex_Average_ForDisplay 
				AND S.Date = MaxCountry_Continent.Date
			   	AND S.Continent_Code = MaxCountry_Continent.Continent_Code)
		LEFT JOIN (Indices NATURAL JOIN Country_Continent) AS MinCountry_Continent
			ON (S.Minimum = MinCountry_Continent.StringencyIndex_Average_ForDisplay 
				AND S.Date = MinCountry_Continent.Date
			   	AND S.Continent_Code = MinCountry_Continent.Continent_Code)
	ORDER BY
		S.Date, S.Continent_Code
	),
	Country_N_Continent AS(
	SELECT
		Countries.Two_Letter_Country_Code,
		Countries.Country_Name,
		Continents.Continent_Code,
		Continents.Continent_Name
	FROM
		Countries NATURAL JOIN Country_Continent NATURAL JOIN Continents
	)
SELECT
	S.Date,
	MaxCountryName.Continent_Name,
	S.Maximum AS Max_Stringency_Index, 
	MaxCountryName.Country_Name AS Max_Country_Name,
	S.Minimum AS Min_Stringency_Index,
	MinCountryName.Country_Name AS Min_Country_Name
FROM
	CountryCode_Index AS S
	LEFT JOIN Country_N_Continent AS MaxCountryName
		ON (S.Max_CountryCode = MaxCountryName.Two_Letter_Country_Code
			AND S.Continent_Code = MaxCountryName.Continent_Code)
	LEFT JOIN Country_N_Continent AS MinCountryName
		ON (S.Min_CountryCode = MinCountryName.Two_Letter_Country_Code
			AND S.Continent_Code = MinCountryName.Continent_Code)
ORDER BY
	S.Date, MaxCountryName.Continent_Name
