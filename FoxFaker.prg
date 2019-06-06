*---------------------------------------------------------------------------------------------------------------*
*
* @title:		FoxFaker Library
* @description:	FoxFaker is a VFP library that generates fake data for you 
* @version:		1.2
* @author:		Irwin Rodríguez
* @email:		rodriguez.irwin@gmail.com
* @license:		MIT
*
*---------------------------------------------------------------------------------------------------------------*
* Version Log:
* Release 2019-06-05	v.1.2	- Official Release at https://github.com/Irwin1985/FoxFaker
*---------------------------------------------------------------------------------------------------------------*
Define Class FoxFaker As Collection
	FactoryBase 	= Addbs(Getenv("TEMP")) + "FactoryBase.dbf"
	LastErrorText 	= ""
	TableCreated	= .F.
	SafAct			= ""

	Hidden bWrite

	#Define MALE					'male'
	#Define FEMALE					'female'
	#Define TRUE					.T.
	#Define FALSE 					.F.
	#Define DECODED_BASE64_BINARY	14
	#Define FAKE_MAX_ROWS			500
	#Define FNAME					1
	#Define mname					2
	#Define address					3
	#Define Text					4
	#Define Word					5
	#Define sentence				6
	#Define mfirstname				7
	#Define ffirstname				8
	#Define lastname				9
	#Define sndaddress				10
	#Define state					11
	#Define city					12
	#Define stname					13
	#Define staddress				14
	#Define postcode				15
	#Define country					16
	#Define latitude				17
	#Define longitude				18
	#Define phone					19
	#Define company					20
	#Define jobtitle				21
	#Define email					22
	#Define safeemail				23
	#Define username				24
	#Define domain					25
	#Define url						26
	#Define ipv4					27
	#Define localipv4				28
	#Define ipv6					29
	#Define macaddress				30
	#Define tdcnumber				31
	#Define hexcolor				32
	#Define rgbcolor				33
	#Define colorname				34
	#Define uuid					35
	#Define ean13					36
	#Define ean8					37
	#Define md5						38
	#Define sha1					39
	#Define sha256					40
	#Define FILE_EXT				41
	#Define mimetype				42
	#Define country_code			43
	#Define currency_code			44

*-- Array List
	Dimension aFaker[1]
	Dimension aMTitle[3]
	Dimension aFTitle[5]
	Dimension aSuffix[11]
	Dimension aCreditCardType[4]
	Dimension aDayOfWeek[7]
	Dimension aMonthName[12]

	Procedure Init
		This.FillArrays()
		Try
			Local lnSelect As Integer, loEx As Exception
			This.SafAct = Set("Safety")
			Set Safety Off
			lnSelect = Select()
			Select 0
			Use FakerFactory Alias __fakerFactory Shared Again Noupdate
			=Strtofile(Strconv(__fakerFactory.cresource, DECODED_BASE64_BINARY), This.FactoryBase)
			If !File(This.FactoryBase)
				This.bWrite = .T.
				This.LastErrorText = "Could not fetch FactoryBase Table!"
			Else &&!File(This.FactoryBase)
				This.TableCreated = .T.
				Use (This.FactoryBase) Alias __factoryBase Shared Again Noupdate
				Select * From __factoryBase Into Array This.aFaker
				Use In (Select("__factoryBase"))
				Delete File (This.FactoryBase)
			Endif &&!File(This.FactoryBase)
		Catch To loEx
			This.bWrite = .T.
			This.LastErrorText = loEx.Message
		Finally
			Use In (Select("__fakerFactory"))
			Select (lnSelect)
			lcSaf = This.SafAct
			Set Safety &lcSaf
		Endtry

	*========================================================================================
	Function fakeName(tcGender As Variant) As String
		If Empty(tcGender) Or Isnull(tcGender)
			Return Iif(This.RandomBoolean(), This.aFaker[This.RandomArrayPos(), FNAME], This.aFaker[This.RandomArrayPos(), MNAME])
		Else &&Empty(tcGender) Or Isnull(tcGender)
			Return Iif(Lower(tcGender) == FEMALE, This.aFaker[This.RandomArrayPos(), FNAME], This.aFaker[This.RandomArrayPos(), MNAME])
		Endif &&Empty(tcGender) Or Isnull(tcGender)

	*========================================================================================
	Function fakeBoolean As Boolean
		Return This.RandomBoolean()

	*========================================================================================
	Function fakeAddress As String
		Return This.aFaker[This.RandomArrayPos(), ADDRESS]

	*========================================================================================
	Function fakeWord As String
		Return This.aFaker[This.RandomArrayPos(), WORD]

	*========================================================================================
	Function fakeRandomLetter As String
		Return Lower(Chr(This.fakeNumberBetween(65, 90)))

	*========================================================================================
	Function fakeWords(tnHowMany As Integer) As String
		Local cWords As String
		cWords = ""
		If Empty(tnHowMany) Or Isnull(tnHowMany)
			tnHowMany = 2
		Else &&Empty(tnHowMany)
		Endif &&Empty(tnHowMany)
		For x=1 To tnHowMany Step 1
			If !Empty(cWords) And !Isnull(cWords)
				cWords = cWords + ","
			Else &&!Empty(cWords) And !Isnull(cWords)
			Endif &&!Empty(cWords) And !Isnull(cWords)
			cWords = cWords + Alltrim(This.fakeWord())
		Endfor
		Return cWords

	*========================================================================================
	Function fakeSentence(tnHowMany) As String
		Local cSentence As String
		cSentence = This.aFaker[This.RandomArrayPos(), SENTENCE]
		If Type("tnHowMany") = "N"
			If tnHowMany > 6
				tnHowMany = 6
			Else &&tnHowMany > 6
			Endif &&tnHowMany > 6
			=Alines(aSentence, cSentence, 5, Space(1))
			lcAux = ""
			For i=1 To tnHowMany
				If !Empty(lcAux)
					lcAux = lcAux + Space(1)
				Else &&!Empty(lcAux)
				Endif &&!Empty(lcAux)
				lcAux = lcAux + aSentence[i]
			Endfor &&i=1 To tnHowMany
			cSentence = lcAux
		Else &&!Empty(tnHowMany) Or !Isnull(tnHowMany)
		Endif &&!Empty(tnHowMany) Or !Isnull(tnHowMany)
		Return cSentence

	*========================================================================================
	Function fakeText(tnLength As Integer) As String
		Return Iif(Type("tnLength") = "N", Substr(This.aFaker[This.RandomArrayPos(), TEXT], 1, tnLength), This.aFaker[This.RandomArrayPos(), TEXT])

	*========================================================================================
	Function fakeTitle(tcGender As String) As String
		cGender = ""
		Do Case
		Case Type("tcGender") = "C" And Lower(tcGender) == MALE
			cGender = "M"
		Case Type("tcGender") = "C" And Lower(tcGender) == FEMALE
			cGender = "F"
		Otherwise
			cGender = Iif(This.fakeBoolean(), "M", "F")
		Endcase
		nLowVal = 1
		nMaxVal = Iif(cGender = "M", 3, 5)
		Return Evaluate("This." + Iif(cGender = "M", "aMTitle", "aFTitle") + "[This.fakeNumberBetween(nLowVal, nMaxVal)]")

	*========================================================================================
	Function fakeTitleMale As String
		Return This.fakeTitle('male')

	*========================================================================================
	Function fakeTitleFemale As String
		Return This.fakeTitle('female')

	*========================================================================================
	Function fakeSuffix As String
		Return This.aSuffix[This.fakeNumberBetween(1, 11)]

	*========================================================================================
	Function fakeFirstName(tcGender As String) As String
		cGender = ""
		Do Case
		Case Type("tcGender") = "C" And Lower(tcGender) == MALE
			cGender = "M"
		Case Type("tcGender") = "C" And Lower(tcGender) == FEMALE
			cGender = "F"
		Otherwise
			cGender = Iif(This.fakeBoolean(), "M", "F")
		Endcase
		Return Iif(cGender = "M", This.aFaker[This.RandomArrayPos(), MFIRSTNAME], This.aFaker[This.RandomArrayPos(), FFIRSTNAME])

	*========================================================================================
	Function fakeFirstNameMale As String
		Return This.fakeFirstName('male')

	*========================================================================================
	Function fakeFirstNameFemale As String
		Return This.fakeFirstName('female')

	*========================================================================================
	Function fakeLastName As String
		Return This.aFaker[This.RandomArrayPos(), LASTNAME]

	*========================================================================================
	Function fakeSecondaryAddress As String
		Return This.aFaker[This.RandomArrayPos(), SNDADDRESS]

	*========================================================================================
	Function fakeCity As String
		Return This.aFaker[This.RandomArrayPos(), CITY]

	*========================================================================================
	Function fakeState As String
		Return This.aFaker[This.RandomArrayPos(), STATE]

	*========================================================================================
	Function fakeStreetName As String
		Return This.aFaker[This.RandomArrayPos(), STNAME]

	*========================================================================================
	Function fakeStreetAddress As String
		Return This.aFaker[This.RandomArrayPos(), STADDRESS]

	*========================================================================================
	Function fakePostCode As String
		Return This.aFaker[This.RandomArrayPos(), POSTCODE]

	*========================================================================================
	Function fakeCountry As String
		Return This.aFaker[This.RandomArrayPos(), COUNTRY]

	*========================================================================================
	Function fakeLatitude As String
		Return This.aFaker[This.RandomArrayPos(), LATITUDE]

	*========================================================================================
	Function fakeLongitude As String
		Return This.aFaker[This.RandomArrayPos(), LONGITUDE]

	*========================================================================================
	Function fakePhoneNumber As String
		Return This.aFaker[This.RandomArrayPos(), PHONE]

	*========================================================================================
	Function fakeCompany As String
		Return This.aFaker[This.RandomArrayPos(), COMPANY]

	*========================================================================================
	Function fakeJobTitle As String
		Return This.aFaker[This.RandomArrayPos(), JOBTITLE]

	*========================================================================================
	Function fakeEmail As String
		Return This.aFaker[This.RandomArrayPos(), EMAIL]

	*========================================================================================
	Function fakeSafeEmail As String
		Return This.aFaker[This.RandomArrayPos(), SAFEEMAIL]

	*========================================================================================
	Function fakeUserName As String
		Return This.aFaker[This.RandomArrayPos(), USERNAME]

	*========================================================================================
	Function fakeDomain As String
		Return This.aFaker[This.RandomArrayPos(), DOMAIN]

	*========================================================================================
	Function fakeUrl As String
		Return This.aFaker[This.RandomArrayPos(), URL]

	*========================================================================================
	Function fakeIpv4 As String
		Return This.aFaker[This.RandomArrayPos(), IPV4]

	*========================================================================================
	Function fakeLocalIpv4 As String
		Return This.aFaker[This.RandomArrayPos(), LOCALIPV4]

	*========================================================================================
	Function fakeIpv6 As String
		Return This.aFaker[This.RandomArrayPos(), IPV6]

	*========================================================================================
	Function fakeMacAddress As String
		Return This.aFaker[This.RandomArrayPos(), MACADDRESS]

	*========================================================================================
	Function fakeCreditCardtype As String
		Return This.aCreditCardType[This.fakeNumberBetween(1, 4)]

	*========================================================================================
	Function fakeCreditCardNumber As String
		Return This.aFaker[This.RandomArrayPos(), TDCNUMBER]

	*========================================================================================
	Function fakeHexColor As String
		Return This.aFaker[This.RandomArrayPos(), HEXCOLOR]

	*========================================================================================
	Function fakeRgbColor As String
		Return This.aFaker[This.RandomArrayPos(), RGBCOLOR]

	*========================================================================================
	Function fakeColorName As String
		Return This.aFaker[This.RandomArrayPos(), COLORNAME]

	*========================================================================================
	Function fakeUuid As String
		Return This.aFaker[This.RandomArrayPos(), UUID]

	*========================================================================================
	Function fakeEAN13 As String
		Return This.aFaker[This.RandomArrayPos(), EAN13]

	*========================================================================================
	Function fakeEAN8 As String
		Return This.aFaker[This.RandomArrayPos(), EAN8]

	*========================================================================================
	Function fakeMD5 As String
		Return This.aFaker[This.RandomArrayPos(), MD5]

	*========================================================================================
	Function fakeSHA1 As String
		Return This.aFaker[This.RandomArrayPos(), SHA1]

	*========================================================================================
	Function fakeSHA256 As String
		Return This.aFaker[This.RandomArrayPos(), SHA256]

	*========================================================================================
	Function fakeFileExtension As String
		Return This.aFaker[This.RandomArrayPos(), FILE_EXT]

	*========================================================================================
	Function fakeMIMEType As String
		Return This.aFaker[This.RandomArrayPos(), MIMETYPE]

	*========================================================================================
	Function fakeCountryCode As String
		Return This.aFaker[This.RandomArrayPos(), COUNTRY_CODE]

	*========================================================================================
	Function fakeCurrencyCode As String
		Return This.aFaker[This.RandomArrayPos(), CURRENCY_CODE]

	*========================================================================================
	Function fakeDate As Date
		CenturyAct = Set("Century")
		Set Century On
		nYear 	= This.fakeNumberBetween(1970, Year(Date()))
		nMonth 	= This.fakeNumberBetween(1, 12)
		nDay	= This.fakeNumberBetween(1, Iif(nMonth = 2, 28, 30))
		dDate 	= Date(nYear, nMonth, nDay)
		Set Century &CenturyAct
		Return dDate

	*========================================================================================
	Function fakeTime As String
		nHour 	= This.fakeNumberBetween(1, 24)
		nMin 	= This.fakeNumberBetween(1, 59)
		nSec	= This.fakeNumberBetween(1, 59)
		Return Padl(Alltrim(Str(nHour)),2,'0') + ":" + Padl(Alltrim(Str(nMin)),2,'0') + ":" + Padl(Alltrim(Str(nSec)),2,'0')

	*========================================================================================
	Function fakeAmPm As String
		Return Iif(This.fakeBoolean(), "am", "pm")

	*========================================================================================
	Function fakeDayOfMonth As Integer
		Return This.fakeNumberBetween(1, 31)

	*========================================================================================
	Function fakeDayOfWeek As String
		Return This.aDayOfWeek[This.fakeNumberBetween(1, 7)]

	*========================================================================================
	Function fakeMonth As Integer
		Return This.fakeNumberBetween(1, 12)

	*========================================================================================
	Function fakeMonthName As String
		Return This.aMonthName[This.fakeNumberBetween(1, 12)]

	*========================================================================================
	Function fakeYear As String
		CenturyAct = Set("Century")
		Set Century On
		nYear = This.fakeNumberBetween(1970, Year(Date()))
		Set Century &CenturyAct
		Return nYear

	*========================================================================================
	Function fakeRandomDigit As Integer
		Return This.Random(10)

	*========================================================================================
	Function fakeRandomNumber(tnLength As Integer) As Integer
		nRand = This.Random(100000000)
		nSeed = Iif(Empty(tnLength) Or Isnull(tnLength), This.Random(9), 3)
		nRand = Val(Substr(Transform(nRand), 1, nSeed))
		Return nRand

	*========================================================================================
	Function fakeNumberBetween(tnLowVal As Integer, tnHighVal As Integer) As Integer
		Local nRand As Integer
		nRand = 0
		Do While .T.
			nRand = This.Random(tnHighVal+1)
			If Between(nRand, tnLowVal, tnHighVal)
				Exit
			Else &&Between(nRand, tnLowVal, tnHighVal)
				Loop
			Endif &&Between(nRand, tnLowVal, tnHighVal)
		Enddo
		Return nRand

	*========================================================================================
	Hidden Function RandomArrayPos As Integer
		Return Int(1+Rand()*FAKE_MAX_ROWS)

	*========================================================================================
	Hidden Function RandomBoolean As Boolean
		Return Iif(Int(1+Rand()*2)=1, .T., .F.)

	*========================================================================================
	Hidden Function Random(nSeed As Integer, bExcludeZero As Boolean) As Integer
		Return Int(Iif(bExcludeZero, 1+Rand()*nSeed, Rand()*nSeed))

	*========================================================================================
	Hidden Procedure FillArrays As VOID
*-- Male Title
		This.aMTitle[1] = "Mr."
		This.aMTitle[2] = "Dr."
		This.aMTitle[3] = "Prof."

*-- Female Title
		This.aFTitle[1] = "Ms."
		This.aFTitle[2] = "Mrs."
		This.aFTitle[3] = "Miss"
		This.aFTitle[4] = "Dr."
		This.aFTitle[5] = "Prof."

*-- Suffix
		This.aSuffix[1] = "I"
		This.aSuffix[2] = "II"
		This.aSuffix[3] = "III"
		This.aSuffix[4] = "IV"
		This.aSuffix[5] = "V"
		This.aSuffix[6] = "Sr."
		This.aSuffix[7] = "Jr."
		This.aSuffix[8] = "PhD"
		This.aSuffix[9] = "DDS"
		This.aSuffix[10] = "MD"
		This.aSuffix[11] = "DVM"

*-- CreditCardTypes
		This.aCreditCardType[1] = "MasterCard"
		This.aCreditCardType[2] = "Visa"
		This.aCreditCardType[3] = "American Express"
		This.aCreditCardType[4] = "Visa Retired"

*-- Day of Week
		This.aDayOfWeek[1]	= "Monday"
		This.aDayOfWeek[2]	= "Tuesday"
		This.aDayOfWeek[3]	= "Wednesday"
		This.aDayOfWeek[4]	= "Thursday"
		This.aDayOfWeek[5]	= "Friday"
		This.aDayOfWeek[6]	= "Saturday"
		This.aDayOfWeek[7]	= "Sunday"

*-- Month Name
		This.aMonthName[1]	= "January"
		This.aMonthName[2]	= "February"
		This.aMonthName[3]	= "March"
		This.aMonthName[4]	= "April"
		This.aMonthName[5]	= "May"
		This.aMonthName[6]	= "June"
		This.aMonthName[7]	= "July"
		This.aMonthName[8]	= "August"
		This.aMonthName[9]	= "September"
		This.aMonthName[10]	= "October"
		This.aMonthName[11]	= "November"
		This.aMonthName[12]	= "December"
	*========================================================================================
	Procedure LastErrorText_Assign(vNewVal)
		If This.bWrite
			This.bWrite = .F.
			This.LastErrorText = m.vNewVal
		Else &&This.bWrite
		Endif &&This.bWrite

	*========================================================================================
	Function LastErrorText_Access
		Return This.LastErrorText

Enddefine