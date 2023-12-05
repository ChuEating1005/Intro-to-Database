WITH StringencyIndex(Date, Maximum, Minimum) AS(
	SELECT
		Date,
		MAX(StringencyIndex_Average_ForDisplay),
		Min(StringencyIndex_Average_ForDisplay)
	FROM
		Indices
	WHERE 
		Date = 20220401 OR Date = 20210401 OR Date = 20200401
	GROUP BY
		Date
	),
	CountryCode_Index AS(
	SELECT 
		S.Date,
		MaxCountryCode.Two_Letter_Country_Code AS Max_CountryCode,
		MinCountryCode.Two_Letter_Country_Code As Min_CountryCode
	FROM
		StringencyIndex AS S
		LEFT JOIN Indices AS MaxCountryCode 
			ON (S.Maximum = MaxCountryCode.StringencyIndex_Average_ForDisplay AND S.Date = MaxCountryCode.Date)
		LEFT JOIN Indices AS MinCountryCode 
			ON (S.Minimum = MinCountryCode.StringencyIndex_Average_ForDisplay AND S.Date = MinCountryCode.Date)
	ORDER BY
		S.Date
	),
	Country_N_Continent AS(
	SELECT
		Countries.Two_Letter_Country_Code,
		Countries.Country_Name,
		Continents.Continent_Name
	FROM
		Countries NATURAL JOIN Country_Continent NATURAL JOIN Continents
	)
SELECT
	S.Date,
	MaxCountryName.Continent_Name AS Max_CountryName,
	MaxCountryName.Country_Name AS Max_CotinentName,
	MinCountryName.Continent_Name AS Min_CountryName,
	MinCountryName.Country_Name AS Min_CotinentName
FROM
	CountryCode_Index AS S
	LEFT JOIN Country_N_Continent AS MaxCountryName
		ON S.Max_CountryCode = MaxCountryName.Two_Letter_Country_Code
	LEFT JOIN Country_N_Continent AS MinCountryName
		ON S.Min_CountryCode = MinCountryName.Two_Letter_Country_Code
ORDER BY
	S.Date