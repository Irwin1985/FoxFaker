*-- FoxFakerClass
Define Class FoxFaker As Collection
	FactoryBase 	= Addbs(Getenv("TEMP")) + "FactoryBase.dbf"
	LastErrorText 	= ""
	TableCreated	= .F.
	SafAct			= ""
	Dimension aMaleName[1]
	Dimension aFemaleName[1]
	Hidden bWrite

	#Define MALE					'male'
	#Define FEMALE					'female'
	#Define TRUE					.T.
	#Define FALSE 					.F.
	#Define DECODED_BASE64_BINARY	14
	#Define FAKE_MAX_ROWS			1000

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
				Select mName From __factoryBase Into Array This.aMaleName
				Select fName From __factoryBase Into Array This.aFemaleName
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
			Return Iif(This.RandomBoolean(), This.aFemaleName[This.RandomArrayPos()], This.aMaleName[This.RandomArrayPos()])
		Else &&Empty(tcGender) Or Isnull(tcGender)
			Return Iif(Lower(tcGender) == FEMALE, This.aFemaleName[This.RandomArrayPos()], This.aMaleName[This.RandomArrayPos()])
		Endif &&Empty(tcGender) Or Isnull(tcGender)

*========================================================================================
	Function Boolean As Boolean
		Return This.RandomBoolean()
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

*========================================================================================
	Hidden Function RandomArrayPos As Integer
		Return Int(1+Rand()*FAKE_MAX_ROWS)

*========================================================================================
	Hidden Function RandomBoolean As Boolean
		Return Iif(Int(1+Rand()*2)=1, .T., .F.)

Enddefine
