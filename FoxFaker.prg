*-- FoxFakerClass
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
	#Define FAKE_MAX_ROWS			1000
	#Define FNAME					1
	#Define mname					2
	#Define address					3
	#Define Text					4
	#Define Word					5
	#Define sentence				6
	#Define mfirstname				7
	#Define ffirstname				8
	#Define mlastname				9
	#Define flastname				10
	#Define sndaddress				11
	#Define state					12
	#Define city					13
	#Define stname					14
	#Define staddress				15
	#Define postcode				16
	#Define country					17
	#Define latitude				18
	#Define longitude				19
	#Define phone					20
	#Define company					21
	#Define jobtitle				22
	#Define email					23
	#Define safeemail				24
	#Define username				25
	#Define domain					26
	#Define url						27
	#Define ipv4					28
	#Define localipv4				29
	#Define ipv6					30
	#Define macaddress				31
	#Define tdcnumber				32
	#Define hexcolor				33
	#Define rgbcolor				34
	#Define colorname				35
	#Define uuid					36
	#Define ean13					37
	#Define ean8					38
	#Define md5						39
	#Define sha1					40
	#Define sha256					41
	Dimension aFaker[1]
	Procedure Init
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

	Function fakeRandomDigit As Integer
		Return This.Random(10)

*========================================================================================
	Function fakeRandomNumber(tnLength As Integer) As Integer
		nRand = This.Random(100000000)
		nSeed = Iif(Empty(tnLength), This.Random(9), 3)

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
	FUNCTION fakeWord as String
		RETURN THIS.aFaker[This.RandomArrayPos(), WORD]
		
	Function fakeRandomLetter As String
		Return Lower(Chr(This.fakeNumberBetween(65, 90)))

*========================================================================================
	FUNCTION fakeWords(tnHowMany as Integer) as string
		LOCAL cWords as string
		cWords = ""
		IF EMPTY(tnHowMany)
			tnHowMany = 2
		ELSE
		ENDIF
		*SET STEP ON
		FOR x=1 TO tnHowMany STEP 1
			IF !EMPTY(cWords)
				cWords = cWords + ","
			ELSE
			ENDIF
			cWords = cWords + ALLTRIM(This.FakeWord())
		ENDFOR
		RETURN cWords
	Procedure LastErrorText_Assign(vNewVal)
		If This.bWrite
			This.bWrite = .F.
			This.LastErrorText = m.vNewVal
		Else &&This.bWrite
		Endif &&This.bWrite

*========================================================================================
	Function LastErrorText_Access
		Return This.LastErrorText

*========================================================================================
	Hidden Function RandomArrayPos As Integer
		Return Int(1+Rand()*FAKE_MAX_ROWS)

*========================================================================================
	Hidden Function RandomBoolean As Boolean
		Return Iif(Int(1+Rand()*2)=1, .T., .F.)

*========================================================================================
	Hidden Function Random(nSeed As Integer, bExcludeZero As Boolean) As Integer
		Return Int(Iif(bExcludeZero, 1+Rand()*nSeed, Rand()*nSeed))
Enddefine
