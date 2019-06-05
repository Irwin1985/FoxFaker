*========================================================================================
* FoxMock unit tests
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
	PROCEDURE test_should_return_a_random_letter_in_lowercase
		cLetter = Faker.fakeRandomLetter()
		This.MessageOut("Faker.fakeRandomLetter: " + cLetter)
		This.AssertTrue(ISALPHA(cLetter), "The result is not a string")

*========================================================================================
	PROCEDURE test_should_return_a_valid_word
		cWord = Faker.fakeWord()
		This.MessageOut("Faker.fakeWord: " + cWord)
		This.AssertTrue(!EMPTY(cWord), "Word is not a valid string")
		
*========================================================================================
	PROCEDURE test_should_return_a_list_of_words_delimited_by_colon
		cWords = Faker.fakeWords(3)
		This.MessageOut("cWords: " + cWords)
		This.AssertTrue(getwordcount(cWords, ",") = 3, "Something went wrong")
Enddefine