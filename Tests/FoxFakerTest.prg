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
		bResult = Faker.Boolean()
		This.MessageOut("Random Boolean is: " + TRANSFORM(bResult))
		This.AssertTrue(Type("bResult") == "L", "LastErrorText: " + Faker.LastErrorText)
		
*========================================================================================
Enddefine
