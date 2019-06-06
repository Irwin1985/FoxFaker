# FoxFaker

Faker is a VFP library that generates fake data for you. Whether you need to bootstrap your database, create good-looking XML documents, fill-in your persistence to stress test it, or anonymize data taken from a production service, Faker is for you.

Faker is heavily inspired by PHP's [Data::Faker](http://search.cpan.org/~jasonk/Data-Faker-0.07/), and by ruby's [Faker](https://rubygems.org/gems/faker).

FoxFaker works quite good on VFP >= 7

# Table of Contents

- [Installation](#installation)
- [Basic Usage](#basic-usage)
- [Formatters](#formatters)
	- [Base](#foxfakerproviderbase)
	- [Lorem Ipsum Text](#foxfakerproviderlorem)
	- [Person](#foxfakerprovideren_usperson)
	- [Address](#foxfakerprovideren_usaddress)
	- [Phone Number](#foxfakerprovideren_usphonenumber)
	- [Company](#foxfakerprovideren_uscompany)
	- [Date and Time](#foxfakerproviderdatetime)
	- [Internet](#foxfakerproviderinternet)
	- [Payment](#foxfakerproviderpayment)
	- [Color](#foxfakerprovidercolor)
	- [File](#foxfakerproviderfile)
	- [Uuid](#foxfakerprovideruuid)
	- [Barcode](#foxfakerproviderbarcode)
	- [Miscellaneous](#foxfakerprovidermiscellaneous)
- [License](#license)


## Installation

```
Just copy FoxFaker.prg, FakerFactory.dbf, FakerFactory.fpt files anywhere into your project path folder.
```

## Basic Usage

Use a Public Variable or a _Screen Property to instantiate `FoxFaker.prg`.

```vfp
Public Faker
*// require the FoxFaker Prg
Set Procedure to "FoxFaker" Additive

*// Instantiate FoxFaker Object
Faker = NewObject(FoxFaker, "FoxFaker.prg")

*// generate data by accessing properties. All methods are written using 'fake' prefix.

?Faker.fakeName() && 'Jhon Doe'

?Faker.fakeAddress() &&"426 Jordy Lodge Cartwrightshire, SC 88120-6700"
?Faker.text()
  *// Dolores sit sint laboriosam dolorem culpa et autem. Beatae nam sunt fugit
  *// et sit et mollitia sed.
  *// Fuga deserunt tempora facere magni omnis. Omnis quia temporibus laudantium
  *// sit minima sint.
```
## Formatters

Each of the generator properties (like `name`, `address`, and `lorem`) are called "formatters". A faker generator has many of them, packaged in "providers". Here is a list of the bundled formatters in the default locale.

### `FoxFaker\Provider\Base`

    fakeRandomDigit             *// 9
    fakeRandomNumber(tnLength)  *// 16795371    
    fakeNumberBetween(tnLowVal, tnHighVal) *// 1985
    fakeRandomLetter()          *// 'i'

### `FoxFaker\Provider\Lorem`

    word                                  *// 'aut'
    fakeWords(tnHowMany)                  *// Laborum vero a officia id corporis.
    fakeSentence(tnHowMany)  		  *// 'Sit vitae voluptas sint non voluptates.'
    fakeText(tnLength)                    *// 'Fuga totam reiciendis qui architecto fugiat nemo.'

### `FoxFaker\Provider\en_US\Person`

    fakeTitle(tcGender = null|'male'|'female') 	   *// 'Ms.'
    fakeTitleMale                                  *// 'Mr.'
    fakeTitleFemale                                *// 'Ms.'
    fakeSuffix                                     *// 'Jr.'
    fakeName(tcGender = null|'male'|'female')      *// 'Dr. Zane Stroman'
    fakeFirstName(tcGender = null|'male'|'female') *// 'Maynard'
    fakeFirstNameMale                              *// 'Maynard'
    fakeFirstNameFemale                            *// 'Rachel'
    fakeLastName                                   *// 'Zulauf'

### `FoxFaker\Provider\en_US\Address`
    
    fakeSecondaryAddress	*// 'Suite 961'
    fakeState			*// 'NewMexico'    
    fakeCity			*// 'West Judge'
    fakeStreetName		*// 'Keegan Trail'
    fakeStreetAddress		*// '439 Karley Loaf Suite 897'
    fakePostcode		*// '17916'
    fakeAddress			*// '8888 Cummings Vista Apt. 101, Susanbury, NY 95473'
    fakeCountry			*// 'Falkland Islands (Malvinas)'
    fakeLatitude()		*// 77.147489
    fakeLongitude()		*// 86.211205

### `FoxFaker\Provider\en_US\PhoneNumber`

    phoneNumber             	*// '201-886-0269 x3767'

### `FoxFaker\Provider\en_US\Company`

    company		*// 'Bogan-Treutel'
    jobTitle		*// 'Cashier'

### `FoxFaker\Provider\DateTime`

    fakeDate()		*// '1979-06-09'
    fakeTime() 		*// '20:49:42'
    fakeAmPm()          *// 'pm'
    fakeDayOfMonth()    *// '04'
    fakeDayOfWeek()     *// 'Friday'
    fakeMonth()         *// '06'
    fakeMonthName()     *// 'January'
    fakeYear()          *// '1993'

### `FoxFaker\Provider\Internet`

    fakeEmail               *// 'tkshlerin@collins.com'
    fakeSafeEmail           *// 'king.alford@example.org'
    fakeUserName            *// 'wade55'
    fakeDomain              *// 'wolffdeckow.net'
    fakeUrl                 *// 'http://www.skilesdonnelly.biz/aut-accusantium-ut-architecto-sit-et.html'
    ipv4                    *// '109.133.32.252'
    localIpv4               *// '10.242.58.8'
    ipv6                    *// '8e65:933d:22ee:a232:f1c1:2741:1f10:117c'
    macAddress              *// '43:85:B7:08:10:CA'

### `FoxFaker\Provider\Payment`

    creditCardType          // 'MasterCard'
    creditCardNumber        // '4485480221084675'

### `FoxFaker\Provider\Color`

    hexcolor               // '#fa3cc2'
    rgbcolor               // '0,255,122'
    colorName              // 'Gainsbor'

### `FoxFaker\Provider\File`

    fileExtension          // 'avi'
    mimeType               // 'video/x-msvideo'

### `Faker\Provider\Uuid`

    uuid                   // '7e57d004-2b97-0e7a-b45f-5387367791cd'

### `Faker\Provider\Barcode`

    ean13          // '4006381333931'
    ean8           // '73513537'

### `Faker\Provider\Miscellaneous`

    boolean // false
    md5           // 'de99a620c50f2990e87144735cd357e7'
    sha1          // 'f08e7f04ca1a413807ebc47551a40a20a0b4de5c'
    sha256        // '0061e4c60dac5c1d82db0135a42e00c89ae3a333e7c26485321f24348c7e98a5'
    countryCode   // UK
    currencyCode  // EUR

## License

Faker is released under the MIT Licence.
