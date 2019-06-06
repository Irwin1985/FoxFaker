*========================================================================================
* FoxFaker Unit Tests
*========================================================================================
Define Class FoxFakerTest As FxuTestCase Of FxuTestCase.prg
	#If .F.
		Local This As FoxFakerTest Of FoxFakerTest.prg
	#Endif

	*========================================================================================
	Procedure Setup
		Public Faker
		Faker = Newobject("foxFaker", "FoxFaker\FoxFaker.prg")

	*========================================================================================
	Procedure TearDown
		Release Faker

	*========================================================================================
	Procedure test_should_create_faker_object_and_factory_base_tables
		This.MessageOut("LastErrorText: " + Faker.LastErrorText)
		This.AssertTrue(Empty(Faker.LastErrorText), "LastErrorText is not empty")

	*========================================================================================
	Procedure test_should_fail_when_write_lastErrorText
		Faker.LastErrorText = "this is not allowed by the faker class"
		This.AssertTrue(Empty(Faker.LastErrorText), "LastErrorText should not be writen out of the class")

	*========================================================================================
	Procedure test_should_verity_table_created
		This.MessageOut("LastErrorText: " + Faker.LastErrorText)
		This.AssertTrue(Faker.TableCreated, "Table was not created")

	*========================================================================================
	Procedure test_should_return_a_random_gender_name_without_parameter
		cName = Faker.fakeName()
		This.MessageOut("cName: " + cName)
		This.AssertTrue(!Empty(cName), "Name is empty")

	*========================================================================================
	Procedure test_should_return_a_random_boolean
		bResult = 15 && Just for mutable type from integer to bool.
		bResult = Faker.fakeBoolean()
		This.MessageOut("Faker.fakeBoolean: " + Transform(bResult))
		This.AssertTrue(Type("bResult") == "L", "LastErrorText: " + Faker.LastErrorText)
		
	*========================================================================================
	Procedure test_should_return_a_valid_address
		cAddress = Faker.fakeAddress()
		This.MessageOut("Faker.fakeAddress: " + cAddress)
		This.AssertTrue(Len(cAddress) > 5, "LastErrorText: " + Faker.LastErrorText)

	*========================================================================================
	Procedure test_should_return_a_random_digit_between_0_and_9
		nResult = Faker.fakeRandomDigit()
		This.MessageOut("Faker.randomDigit: " + Transform(nResult))
		This.AssertTrue(Between(nResult, 0, 9), "SomeThing Went Rong")

	*========================================================================================
	Procedure test_should_return_random_numbers_with_any_length_between_0_and_9
		nResult = Faker.fakeRandomNumber()
		This.MessageOut("Faker.fakeRandomNumber: " + Transform(nResult))
		This.AssertTrue(Type("nResult") = "N", "Something went wrong!")

	*========================================================================================
	Procedure test_should_return_random_numbers_passing_custom_length
		nCustomLength = 3
		nResult = Faker.fakeRandomNumber(nCustomLength)
		This.MessageOut("Faker.fakeRandomNumber: " + Transform(nResult))
		This.AssertTrue(Between(Int(nResult/100), 1, 9), "Something went wrong")

	*========================================================================================
	Procedure test_should_return_a_random_numbers_between_custom_range
		nLowValue  = 65
		nHighValue = 90
		nResult    = Faker.fakeNumberBetween(nLowValue, nHighValue)
		This.MessageOut("Faker.fakeNumberBetween: " + Transform(nResult))
		This.AssertTrue(Between(nResult, nLowValue, nHighValue), "Something went Wrong")

	*========================================================================================
	Procedure test_should_return_a_random_letter_in_lowercase
		cLetter = Faker.fakeRandomLetter()
		This.MessageOut("Faker.fakeRandomLetter: " + cLetter)
		This.AssertTrue(Isalpha(cLetter), "The result is not a string")

	*========================================================================================
	Procedure test_should_return_a_valid_word
		cWord = Faker.fakeWord()
		This.MessageOut("Faker.fakeWord: " + cWord)
		This.AssertTrue(!Empty(cWord), "Word is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_list_of_words_delimited_by_colon
		cWords = Faker.fakeWords(3)
		This.MessageOut("cWords: " + cWords)
		This.AssertTrue(Getwordcount(cWords, ",") = 3, "Something went wrong")
		
	*========================================================================================
	Procedure test_should_return_a_full_sentence
		cSentence = Faker.fakeSentence()
		This.MessageOut("Faker.fakeSentence: " + cSentence)
		This.AssertTrue(!Empty(cSentence), "The result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_custom_number_of_sentences
		cSentence = Faker.fakeSentence(3)
		This.MessageOut("Faker.fakeSencente(3): " + cSentence)
		This.AssertTrue(!Empty(cSentence), "The result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_text
		cText = Faker.fakeText()
		This.MessageOut("Faker.fakeText: " + cText)
		This.AssertTrue(!Empty(cText), "The result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_custom_text_passing_the_max_length
		cText = Faker.fakeText(120)
		This.MessageOut("Faker.fakeText: " + cText)
		This.AssertTrue(Len(cText) = 120, "The Length of the result is not 120")

	*========================================================================================
	Procedure test_should_return_a_random_title
		cTitle = Faker.fakeTitle()
		This.MessageOut("Faker.fakeTitle: " + cTitle)
		This.AssertTrue(!Empty(cTitle), "The result is not a valid string")

	*========================================================================================
	Procedure test_sould_return_a_male_title
		cTitle = Faker.fakeTitle('male')
		This.MessageOut("Faker.fakeTitle: " + cTitle)
		This.AssertTrue(!Empty(cTitle), "The result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_female_title
		cTitle = Faker.fakeTitle('female')
		This.MessageOut("Faker.fakeTitle: " + cTitle)
		This.AssertTrue(!Empty(cTitle), "The result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_male_title_usig_titlemale_function
		cTitle = Faker.fakeTitleMale()
		This.MessageOut("Faker.fakeTitleMale: " + cTitle)
		This.AssertTrue(!Empty(cTitle), "this is not a valid string title")

	*========================================================================================
	Procedure test_should_return_a_female_title_using_titlefemale_function
		cTitle = Faker.fakeTitleFemale()
		This.MessageOut("Faker.fakeTitleFemale: " + cTitle)
		This.AssertTrue(!Empty(cTitle), "This is not a valid female title")

	*========================================================================================
	Procedure test_should_return_a_suffix
		cSuffix = Faker.fakeSuffix()
		This.MessageOut("Faker.fakeSuffix: " + cSuffix)
		This.AssertTrue(!Empty(cSuffix), "The result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_random_first_name
		cName = Faker.fakeFirstName()
		This.MessageOut("Faker.fakeFirstName: " + cName)
		This.AssertTrue(!Empty(cName), "The result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_random_first_name_passing_null
		cName = Faker.fakeFirstName()
		This.MessageOut("Faker.fakeFirstName: " + cName)
		This.AssertTrue(!Empty(cName), "The result is not a valid string")

	*========================================================================================
	Procedure test_should_return_first_name_male_passing_parameter
		cName = Faker.fakeFirstName('male')
		This.MessageOut("Faker.fakeFirstName: " + cName)
		This.AssertTrue(!Empty(cName), "The result is not a valid string")

	*========================================================================================
	Procedure test_should_return_first_name_female_passing_parameter
		cName = Faker.fakeFirstName('female')
		This.MessageOut("Faker.fakeFirstName: " + cName)
		This.AssertTrue(!Empty(cName), "The result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_male_first_name_calling_his_own_function
		cName = Faker.fakeFirstNameMale()
		This.MessageOut("Faker.fakeFirstNameMale: " + cName)
		This.AssertTrue(!Empty(cName), "This is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_female_first_name_calling_her_own_function
		cName = Faker.fakeFirstNameFemale()
		This.MessageOut("Faker.fakeFirstNameFemale: " + cName)
		This.AssertTrue(!Empty(cName), "This is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_last_name
		cLastName = Faker.fakeLastName()
		This.MessageOut("Faker.fakeLastName: " + cLastName)
		This.AssertTrue(!Empty(cLastName), "This is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_secondary_address
		cAddress = Faker.FakeSecondaryAddress()
		This.MessageOut("Faker.FakeSecondaryAddress: " + cAddress)
		This.AssertTrue(!Empty(cAddress), "The result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_state
		cState = Faker.fakeState()
		This.MessageOut("Faker.fakeState: " + cState)
		This.AssertTrue(!Empty(cState), "The result is empty")

	*========================================================================================
	Procedure test_should_return_a_city
		cCity = Faker.fakeCity()
		This.MessageOut("Faker.fakeCity: " + cCity)
		This.AssertTrue(!Empty(cCity), "The result is empty")

	*========================================================================================
	Procedure test_should_return_a_street_name
		cStreet = Faker.fakeStreetName()
		This.MessageOut("Faker.fakeStreetName: " + cStreet)
		This.AssertTrue(Type("cStreet") = "C", "The result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_street_address
		cStreetAddress = Faker.fakeStreetAddress()
		This.MessageOut("Faker.fakeStreetAddress: " + cStreetAddress)
		This.AssertTrue(Type("cStreetAddress") = "C", "The result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_post_code
		cPostCode = Faker.fakePostCode()
		This.MessageOut("Faker.fakePostCode: " + cPostCode)
		This.AssertTrue(Type("cPostCode") = "C", "The result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_country
		cCountry = Faker.fakeCountry()
		This.MessageOut("Faker.fakeCountry: " + cCountry)
		This.AssertTrue(Type("cCountry") = "C", "The result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_valid_latitude
		cLatitude = Faker.fakeLatitude()
		This.MessageOut("Faker.fakeLatitude: " + cLatitude)
		This.AssertTrue(Type("cLatitude") = "C", "The result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_valid_longitude
		cLongitude = Faker.fakeLongitude()
		This.MessageOut("Faker.fakeLongitude: " + cLongitude)
		This.AssertTrue(Type("cLongitude") = "C", "The result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_phone_number
		cPhone = Faker.fakePhoneNumber()
		This.MessageOut("Faker.fakePhoneNumber: " + cPhone)
		This.AssertTrue(Type("cPhone")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_company
		cCompany = Faker.fakeCompany()
		This.MessageOut("Faker.fakeCompany: " + cCompany)
		This.AssertTrue(Type("cCompany")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_job_title
		cJob = Faker.fakeJobTitle()
		This.MessageOut("Faker.fakeJobTitle: " + cJob)
		This.AssertTrue(Type("cJob")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_valid_email
		cEmail = Faker.fakeEmail()
		This.MessageOut("Faker.fakeEmail: " + cEmail)
		This.AssertTrue(Type("cEmail")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_safe_email
		cSafeEmail = Faker.fakeSafeEmail()
		This.MessageOut("Faker.fakeSafeEmail: " + cSafeEmail)
		This.AssertTrue(Type("cSafeEmail")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_user_name
		cUserName = Faker.fakeUserName()
		This.MessageOut("Faker.fakeUserName: " + cUserName)
		This.AssertTrue(Type("cUserName")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_domain
		cDomain = Faker.fakeDomain()
		This.MessageOut("Faker.fakeDomain: " + cDomain)
		This.AssertTrue(Type("cDomain")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_url
		cUri = Faker.fakeUrl()
		This.MessageOut("Faker.fakeUrl: " + cUri)
		This.AssertTrue(Type("cUri")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_ipv4
		cIpv4 = Faker.fakeIpv4()
		This.MessageOut("Faker.fakeIpv4: " + cIpv4)
		This.AssertTrue(Type("cIpv4")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_localIpv4
		cLocalIpv4 = Faker.fakeLocalIpv4()
		This.MessageOut("Faker.fakeLocalIpv4: " + cLocalIpv4)
		This.AssertTrue(Type("cLocalIpv4")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_ipv6
		cIpv6 = Faker.fakeIpv6()
		This.MessageOut("Faker.fakeIpv6: " + cIpv6)
		This.AssertTrue(Type("cIpv6")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_mac_address
		cMac = Faker.fakeMacAddress()
		This.MessageOut("Faker.fakeMacAddress: " + cMac)
		This.AssertTrue(Type("cMac")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_credit_card_type
		cCreditCardType = Faker.fakeCreditCardType()
		This.MessageOut("Faker.fakeCreditCardType: " + cCreditCardType)
		This.AssertTrue(Type("cCreditCardType")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_credit_card_number
		cCreditCard = Faker.fakeCreditCardNumber()
		This.MessageOut("Faker.fakeCreditCardNumber: " + cCreditCard)
		This.AssertTrue(Type("cCreditCard")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_hex_color
		cHexColor = Faker.fakeHexColor()
		This.MessageOut("Faker.fakeHexColor: " + cHexColor)
		This.AssertTrue(Type("cHexColor")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_rgb_color
		cRgbColor = Faker.fakeRgbColor()
		This.MessageOut("Faker.fakeRgbColor: " + cRgbColor)
		This.AssertTrue(Type("cRgbColor")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_color_name
		cColor = Faker.fakeColorName()
		This.MessageOut("Faker.fakeColorName: " + cColor)
		This.AssertTrue(Type("cColor")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_uuid
		cUuid = Faker.fakeUuid()
		This.MessageOut("Faker.fakeUuid: " + cUuid)
		This.AssertTrue(Type("cUuid")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_ean13
		cEan13 = Faker.fakeEAN13()
		This.MessageOut("Faker.fakeEAN13: " + cEan13)
		This.AssertTrue(Type("cEan13")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_ean8
		cEan8 = Faker.fakeEAN8()
		This.MessageOut("Faker.fakeEAN8: " + cEan8)
		This.AssertTrue(Type("cEan8")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_md5
		cMD5 = Faker.fakeMD5()
		This.MessageOut("Faker.fakeMD5: " + cMD5)
		This.AssertTrue(Type("cMD5")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_sha1
		cSHA1 = Faker.fakeSHA1()
		This.MessageOut("Faker.fakeSHA1: " + cSHA1)
		This.AssertTrue(Type("cSHA1")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_sha256
		cSHA256 = Faker.fakeSHA256()
		This.MessageOut("Faker.fakeSHA256: " + cSHA256)
		This.AssertTrue(Type("cSHA256")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_file_extension
		cFileExt = Faker.fakeFileExtension()
		This.MessageOut("Faker.fakeFileExtension: " + cFileExt)
		This.AssertTrue(Type("cFileExt")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_mime_type
		cMime = Faker.fakeMimeType()
		This.MessageOut("Faker.fakeMimeType: " + cMime)
		This.AssertTrue(Type("cMime")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_country_code
		cCountryCode = Faker.fakeCountryCode()
		This.MessageOut("Faker.fakeCountryCode: " + cCountryCode)
		This.AssertTrue(Type("cCountryCode")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_currency_code
		cCurrencyCode = Faker.fakeCurrencyCode()
		This.MessageOut("Faker.fakeCurrencyCode: " + cCurrencyCode)
		This.AssertTrue(Type("cCurrencyCode")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_valid_date_format
		dDate = Faker.fakeDate()
		This.MessageOut("Faker.fakeDate: " + Transform(dDate))
		This.AssertTrue(Type("dDate")= "D", "the result is not a valid date format")

	*========================================================================================
	Procedure test_should_return_a_valid_time_format
		cTime = Faker.fakeTime()
		This.MessageOut("Faker.fakeTime: " + Transform(cTime))
		This.AssertTrue(Type("cTime")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_valid_am_pm
		cAmPm = Faker.fakeAmPm()
		This.MessageOut("Faker.fakeAmPm: " + Transform(cAmPm))
		This.AssertTrue(Type("cAmPm")= "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_day_of_month
		nDay = Faker.fakeDayOfMonth()
		This.MessageOut("Faker.fakeDayOfMonth: " + Transform(nDay))
		This.AssertTrue(Between(nDay, 1, 31), "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_day_of_week
		cDay = Faker.fakeDayOfWeek()
		This.MessageOut("Faker.fakeDayOfWeek: " + Transform(cDay))
		This.AssertTrue(Type("cDay") = "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_random_month_number
		nMonth = Faker.fakeMonth()
		This.MessageOut("Faker.fakeMonth: " + Transform(nMonth))
		This.AssertTrue(Type("nMonth") = "N", "the result is not a valid number")

	*========================================================================================
	Procedure test_should_return_a_random_month_name
		cMonthName = Faker.fakeMonthName()
		This.MessageOut("Faker.fakeMonthName: " + Transform(cMonthName))
		This.AssertTrue(Type("cMonthName") = "C", "the result is not a valid string")

	*========================================================================================
	Procedure test_should_return_a_random_year
		nYear = Faker.fakeYear()
		This.MessageOut("Faker.fakeYear: " + Transform(nYear))
		This.AssertTrue(Type("nYear") = "N", "the result is not a valid number")
		
Enddefine
