use Prueba2
GO

--CONTAR CUANTAS VECES SE REPITEN LOS AUTORES EN LA DATA------
SELECT [Twitter Author ID],
COUNT([Twitter Author ID]) cantidad
FROM dbo.Sheet0$
GROUP BY [Twitter Author ID]
HAVING COUNT([Twitter Author ID])>1;

GO

-- CONTAR CUANTOS TWEETS TIENE LOS AUTORES QUE SE REPITEN----------
SELECT [Twitter Author ID],[Author],[Full Text],[Query Id],[Query Name],[Resource Id]
FROM Sheet0$
WHERE [Twitter Author ID] = '110822488'
GO


-- CONTAR CUANDO TWEETS QUE NO TIENEN PAIS EXISTEN-----
SELECT [Resource Id],Author,[Twitter Retweets],[Twitter Likes],[Twitter Reply Count],[Mentioned Authors],Country
FROM Sheet0$
WHERE Country IN('')
-- WHERE Author= 'PTV_Noticias'
-- WHERE [Continent Code] = 'EUROPE'
GO
-- CONTAR CUANTOS TWEETS HAY POR PAIS-----
SELECT Country,
COUNT([Resource Id]) twets,
COUNT(distinct([Twitter Author ID])) autor
FROM Sheet0$
--WHERE [City Code] IN('PER.Lima Province.Lima')
GROUP BY Country
ORDER BY COUNT([Resource Id]) DESC
GO

-- CONTAR CUANTOS TWEETS POR CIUDAD EXISTEN---
SELECT Country,City,
COUNT([Resource Id]) twets
FROM Sheet0$
WHERE City IN('lima')
GROUP BY Country,City
ORDER BY COUNT([Resource Id]) DESC
GO

-- COMPROBANDO QUE HAY TWEETS QUE NO CITYCODE NI CITY, NI PAIS,SON 101 REGISTROS --
SELECT 
[Resource Id],[Twitter Author ID]ID_AUTOR,Author,[City Code],City,Country,[Country Code],Continent,[Continent Code]
FROM Sheet0$
WHERE Country IN('') or [City Code]=''
GO

-- CORROBORANDO PERU TIENE 55 REGISTROS QUE NO TIENEN CIUDAD, NI CITYCODE----
SELECT 
[Resource Id],[Twitter Author ID]ID_AUTOR,Author,[City Code],City,Country,[Country Code],Continent,[Continent Code]
FROM Sheet0$
WHERE Country = 'Peru' and [City Code] = ''
GO

-- CORROBORANDO QUE EXISTEN 45 REGISTROS QUE NO TIENEN NI CITYCODE,NI CITY,NI PAIS.
SELECT 
[Resource Id],[Twitter Author ID]ID_AUTOR,Author,[City Code],City,Country,[Country Code],Continent,[Continent Code]
FROM Sheet0$
WHERE Country = '' 

-- CORROBORANDO LOS 822 REGISTROS QUE SON DE PAIS PERU Y DE LA CIUDAD DE LIMA CON EL CODIGO PER.Lima Province.Lima---
SELECT 
[Resource Id],[Twitter Author ID]ID_AUTOR,Author,[City Code],City,Country,[Country Code],Continent,[Continent Code]
FROM Sheet0$
WHERE Country = 'Peru' and [City Code] = 'PER.Lima Province.Lima'

-- CORROBORANDO LOS 822 REGISTROS QUE SON DE LA CIUDAD DE LIMA FILTRADO CON CITY 'Lima'---
SELECT 
[Resource Id],[Twitter Author ID]ID_AUTOR,Author,[City Code],City,Country,[Country Code],Continent,[Continent Code],Region
FROM Sheet0$
WHERE City='Lima'

-- CORROBORANDO QUE SON 101 REGISTROS QUE NO TIENEN REGISTRADO CIUDAD
SELECT 
[Resource Id],[Twitter Author ID]ID_AUTOR,Author,[City Code],City,Country,[Country Code],Continent,[Continent Code],Region
FROM Sheet0$
WHERE City=''

-- VERIFICAR LOS HASTAGHS EN CUANTOS TWEETS SE HACEN PRESENTES--
SELECT 
[Resource Id],[Twitter Author ID]ID_AUTOR,Author,[City Code],City,Hashtags
FROM Sheet0$
WHERE Hashtags LIKE'%#jaimedelgado%'


-- LISTA DE HASTAGHS: #envivo, #24horas, #panamericanatelevisión, #panamericananoticias, #24horas


-- VERIFICAR LOS INTERESES EN TWEETS(RESULTADO 14 TWEETS)
SELECT [Resource Id],[Twitter Author ID]ID_AUTOR,Interest
FROM Sheet0$
WHERE Interest LIKE '%Science%' --Interest = ''
GO

-- LO QUE ME ARROJA EL POWERBI(RESULTADO 13 TWEETS)--
SELECT [Resource Id],[Twitter Author ID]ID_AUTOR,Interest
FROM Sheet0$
WHERE [Resource Id] IN('0e18ecc766e95fc74b648c41ab257d8e','0f09e61e0a5637de357b944e97cf7afb','2cff9a83b22d240fa9abbde8d57e7d08',
'3b2fdf6cd4094de923c3fdbab2f88cc0','506b5dd47e41ba1c26a418368aa678f8','79eb03ea640292b85165c083c394f212',
'84c2489952db44cf5691132e0096a073','856efabfd5779510f4661be25fea17b9','8f0870ac884f534e31e67d55116e33b3',
'c97c52d1cdf44931385c5176962f48bb','f010735ff02dcacaad131ebb3e9510b0','fb9dd42a5611a122b754ca5350570a9a',
'fc8df905eb5cf3ff078666bd4c6d068f')
GO

-- CRUZO TABLAS PARA VER CUAL ES EL QUE FALTA EL QUE FALTA ES  '288aca471dbe5d93c5db946a93b2d60a'--
SELECT *
FROM (SELECT [Resource Id],[Twitter Author ID]ID_AUTOR,Interest
FROM Sheet0$
WHERE Interest LIKE'%Food & Drinks%') AS A
LEFT JOIN 
(SELECT [Resource Id],[Twitter Author ID]ID_AUTOR,Interest
FROM Sheet0$
WHERE [Resource Id] IN('0e18ecc766e95fc74b648c41ab257d8e','0f09e61e0a5637de357b944e97cf7afb','2cff9a83b22d240fa9abbde8d57e7d08',
'3b2fdf6cd4094de923c3fdbab2f88cc0','506b5dd47e41ba1c26a418368aa678f8','79eb03ea640292b85165c083c394f212',
'84c2489952db44cf5691132e0096a073','856efabfd5779510f4661be25fea17b9','8f0870ac884f534e31e67d55116e33b3',
'c97c52d1cdf44931385c5176962f48bb','f010735ff02dcacaad131ebb3e9510b0','fb9dd42a5611a122b754ca5350570a9a',
'fc8df905eb5cf3ff078666bd4c6d068f')) AS B 
ON A.[Resource Id] = B.[Resource Id]
WHERE B.[Resource Id] IS NULL
GO

-- VERIFICO QUE SE DEBIÓ DIVIDIR EN 4COLUMNAS UNA PARA CADA INTEREST.
SELECT [Resource Id],[Twitter Author ID],Interest,Country,[Country Code],[City Code],City FROM 
Sheet0$
WHERE [Resource Id] = '288aca471dbe5d93c5db946a93b2d60a'
GO
-- VERIFICO QUE NO SOLO ESE ID TIENE 4 INTERESES, SINO QUE TAMBIÉN HAY OTRO ID QUE TIENE 7 INTERESES Y OTROS 5 ENTONCES DIVIDO POR LA CANTIDAD MÁXIMA
SELECT [Resource Id],[Twitter Author ID],Interest,Country,[Country Code],[City Code],City FROM 
Sheet0$
GO

-- VERIFICAR CANTIDAD DE TWEETS POR MES
SELECT [Resource Id],[Twitter Author ID]ID_AUTOR,Hashtags,MONTH(Date)
FROM Sheet0$
WHERE MONTH(Date) =1
GO

-- VERIFICAR CANTIDAD DE AUTORES POR MES
SELECT [Twitter Author ID]ID_AUTOR,
COUNT(DISTINCT([Twitter Author ID]))cantidad
,MONTH(Date) Mes
FROM Sheet0$
WHERE MONTH(Date) = 6 --enero
GROUP BY [Twitter Author ID],MONTH(Date)
ORDER BY MONTH(Date)
GO


SELECT 
[Resource Id],City,Hashtags,Interest
FROM Sheet0$
WHERE LEN(Interest) = (SELECT
MAX(LEN(Interest)) FROM Sheet0$)


-- VERIFICAR LOS HASTAGHS CANTIDAD DEL CAMPO MÁS LARGO--
SELECT 
[Resource Id],City,Hashtags
FROM Sheet0$
WHERE LEN(Hashtags) = (SELECT
MAX(LEN(Hashtags)) FROM Sheet0$)


-- LO MISMO DE ARRIBA, OTRA FORMA
SELECT TOP 5 [Resource Id]
FROM Sheet0$
ORDER BY LEN(Hashtags) DESC;


-- VERIFICAR LOS CAMPOS CON LA CANTIDAD MÁS ALTA DE COMAS(QUIERE DECIR CON MÁS INTERESES)
SELECT [Resource Id],Interest
FROM Sheet0$
WHERE LEN(Interest)-LEN(REPLACE(Interest,',','')) = 
(SELECT
MAX
(LEN(Interest)-LEN(REPLACE(Interest,',',''))) 
FROM Sheet0$)

-- LO MISMO DE ARRIBA, OTRA FORMA
SELECT TOP 3 [Resource Id],Interest
FROM Sheet0$
ORDER BY LEN(Interest)-LEN(REPLACE(Interest,',','')) DESC;

