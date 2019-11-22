import 'dart:convert';

import 'package:currency_converter/model/rates.dart';

final country_currency_map =
    '{"Canada": "CAD", "Libyan Arab Jamahiriya": "LYD", "Turkmenistan": "TMT", "Saint Helena": "GBP", "Saint Pierre and Miquelon": "EUR", '
    '"Ethiopia": "ETB", "Swaziland": "SZL", "Svalbard and Jan Mayen Islands": "NOK", "Cameroon": "XAF", "Burkina Faso": "XOF", "Togo": "XOF", '
    '"United States Minor Outlying Islands": "USD", "Cocos (Keeling) Islands": "AUD", "Bosnia and Herzegovina": "BAM", "Russian Federation": "RUB", '
    '"Dominica": "XCD", "Liberia": "LRD", "Maldives": "MVR", "Tanzania": "TZS", "Palestinian Territory": "JOD", "Christmas Island": "AUD", '
    '"Monaco": "EUR", "Jersey": "GBP", "Macau": "MOP", "Tajikistan": "TJS", "Turkey": "TRY", "Afghanistan": "AFN", '
    '"Micronesia Federated States of": "USD", "France": "EUR", "Vanuatu": "VUV", "Nauru": "AUD", "Seychelles": "SCR", "Norway": "NOK", '
    '"Malawi": "MWK", "Korea South": "KRW", "Montenegro": "EUR", "Dominican Republic": "DOP", "Bahrain": "BHD", "Cayman Islands": "KYD", '
    '"Finland": "EUR", "Central African Republic": "XAF", "Liechtenstein": "CHF", "East Timor": "IDR", "United States": "USD", "Portugal": "EUR", '
    '"Fiji": "FJD", "Malaysia": "MYR", "Pitcairn": "NZD", "Congo Republic of the Democratic": "XAF", "Panama": "PAB", "Costa Rica": "CRC", '
    '"Luxembourg": "EUR", "American Samoa": "EUR", "Andorra": "EUR", "Gibraltar": "GIP", "Ireland": "EUR", "Italy": "EUR", "Nigeria": "NGN", '
    '"Ecuador": "ECS", "Australia": "AUD", "Vatican City State (Holy See)": "EUR", "El Salvador": "SVC", "Tuvalu": "AUD", "Netherlands Antilles": "ANG", '
    '"Thailand": "THB", "Belize": "BZD", "Hong Kong": "HKD", "Sierra Leone": "SLL", "Georgia": "GEL", "Denmark": "DKK", "Philippines": "PHP", '
    '"Morocco": "MAD", "Guernsey": "GGP", "Estonia": "EEK", "Lebanon": "LBP", "Uzbekistan": "UZS", "Falkland Islands (Malvinas)": "FKP", "Colombia": "COP", '
    '"Taiwan": "TWD", "Cyprus": "CYP", "Barbados": "BBD", "Madagascar": "MGA", "Palau": "USD", "Sudan": "SDG", "Nepal": "NPR", "Saint Vincent Grenadines": "XCD", '
    '"Netherlands": "EUR", "Virgin Islands (US)": "USD", "Suriname": "SRD", "Anguilla": "XCD", "Korea North": "KPW", "Aland Islands": "EUR", "Israel": "ILS", '
    '"Venezuela": "VEF", "Senegal": "XOF", "Papua New Guinea": "PGK", "Zimbabwe": "ZWD", "Jordan": "JOD", "Congo-Brazzaville": "CDF", "Martinique": "EUR", '
    '"Mauritania": "MRO", "Trinidad and Tobago": "TTD", "Latvia": "LVL", "Hungary": "HUF", "Guadeloupe": "EUR", "Mexico": "MXN", "Serbia": "RSD", '
    '"United Kingdom": "GBP", "Greece": "EUR", "Paraguay": "PYG", "Gabon": "XAF", "Botswana": "BWP", "Sao Tome and Principe": "STD", "Lithuania": "LTL", '
    '"Cambodia": "KHR", "Aruba": "ANG", "Argentina": "ARS", "Bolivia": "BOB", "Ghana": "GHS", "Saudi Arabia": "SAR", "Cape Verde": "CVE", "Slovenia": "EUR", '
    '"Guatemala": "GTQ", "Guinea": "GNF", "Saint Barthelemy": "EUR", "Spain": "EUR", "Congo (Kinshasa)": "CDF", "Jamaica": "JMD", "Oman": "OMR", "Greenland": "DKK", '
    '"French Guiana": "EUR", "Niue": "NZD", "Bahamas": "BSD", "Samoa": "EUR", "New Zealand": "NZD", "Yemen": "YER", "Pakistan": "PKR", "Albania": "ALL", '
    '"Moldova Republic of": "MDL", "Norfolk Island": "AUD", "United Arab Emirates": "AED", "Guam": "USD", "India": "INR", "Azerbaijan": "AZN", "Lesotho": "LSL", '
    '"Kenya": "KES", "Virgin Islands (British)": "USD", "Czech Republic": "CZK", "Eritrea": "ETB", "Iran (Islamic Republic of)": "IRR", "Turks and Caicos Islands": "USD", '
    '"Saint Lucia": "XCD", "San Marino": "EUR", "French Polynesia": "XPF", "Wallis and Futuna Islands": "XPF", "Syrian Arab Republic": "SYP", "Bermuda": "BMD", '
    '"Somalia": "SOS", "Peru": "PEN", "Laos": "LAK", "Cook Islands": "NZD", "Benin": "XOF", "Cuba": "CUP", "British Indian Ocean Territory": "USD", "China": "CNY", '
    '"Armenia": "AMD", "Ukraine": "UAH", "Tonga": "TOP", "Western Sahara": "MAD", "Indonesia": "IDR", "Mauritius": "MUR", "Sweden": "SEK", "Vietnam": "VND", '
    '"Macedonia": "MKD", "Mali": "XOF", "Slovakia (Slovak Republic)": "SKK", "Bulgaria": "BGN", "Romania": "RON", "Angola": "AOA", "French Southern Territories": "EUR", '
    '"Chad": "XAF", "South Africa": "ZAR", "Tokelau": "NZD", "South Georgia and the South Sandwich Islands": "GBP", "Brunei Darussalam": "BND", "Qatar": "QAR", '
    '"Austria": "EUR", "Saint Kitts": "XCD", "Mozambique": "MZN", "Uganda": "UGX", "Japan": "JPY", "Niger": "XOF", "Brazil": "BRL", "Faroe Islands": "DKK", '
    '"Ivory Coast": "XOF", "Bangladesh": "BDT", "Belarus": "BYR", "Macao S.A.R.": "MOP", "Algeria": "DZD", "Solomon Islands": "SBD", "Marshall Islands": "USD", '
    '"Chile": "CLP", "Puerto Rico": "USD", "Belgium": "EUR", "Kiribati": "AUD", "Haiti": "HTG", "Iraq": "IQD", "Gambia": "GMD", "Namibia": "NAD", "Mongolia": "MNT", '
    '"Guinea-Bissau": "XOF", "Switzerland": "CHF", "Grenada": "XCD", "Isle of Man": "GBP", "Myanmar": "MMK", "Uruguay": "UYU", "Equatorial Guinea": "XAF", '
    '"Tunisia": "TND", "Djibouti": "DJF", "Rwanda": "RWF", "Antigua and Barbuda": "XCD", "Reunion": "EUR", "Burundi": "BIF", "Nicaragua": "NIO", '
    '"Saint Martin (French part)": "ANG", "Bhutan": "INR", "Malta": "MTL", "Northern Mariana Islands": "USD", "Kuwait": "KWD", "Bouvet Island": "NOK", '
    '"Croatia (Hrvatska)": "HRK", "Iceland": "ISK", "Zambia": "ZMK", "Germany": "EUR", "Kazakhstan": "KZT", "Poland": "PLN", "Kyrgyzstan": "KGS", "Mayotte": "EUR", '
    '"Montserrat": "XCD", "New Caledonia": "XPF", "Heard and Mc Donald Islands": "AUD", "Guyana": "GYD", "US Armed Forces": "USD", "Honduras": "HNL", "Egypt": "EGP", '
    '"Singapore": "SGD", "Antarctica": "AQD", "Sri Lanka": "LKR", "Comoros": "KMF"}';

var currency_symbol_map = '{"DZD": "\\u062f\\u062c", "QAR": "\\ufdfc", "XBT": "\\u0243", "BGN": "\\u043b\\u0432", "BMD": "\$", "PAB": "B/.", "BWP": "P", "TZS": "TSh", "VND": '
    '"\\u20ab", "KYD": "\$", "UAH": "\\u20b4", "AWG": "\\u0192", "GIP": "\\u00a3", "BYR": "Br", "ALL": "L", "BYN": "Br", "DJF": "Fdj", "THB": "\\u0e3f", "BND": "\$", '
    '"NIO": "C\$", "LAK": "\\u20ad", "SYP": "\\u00a3", "MAD": "MAD", "MZN": "MT", "YER": "\\ufdfc", "ZAR": "R", "NPR": "\\u20a8", "CRC": "\\u20a1", "AED": "\\u062f.\\u0625",'
    ' "GBP": "\\u00a3", "HUF": "Ft", "LSL": "M", "TTD": "TT\$", "SBD": "\$", "KPW": "\\u20a9", "ANG": "\\u0192", "RWF": "R\\u20a3", "NOK": "kr", "MOP": "MOP\$", '
    '"INR": "\\u20b9", "MXN": "\$", "TJS": "SM", "COP": "\$", "TMT": "T", "HNL": "L", "FJD": "\$", "ETB": "Br", "PEN": "S/.", "BZD": "BZ\$", "ILS": "\\u20aa", "ETH": "\\u039e", '
    '"GGP": "\\u00a3", "MDL": "lei", "BSD": "\$", "TVD": "\$", "JEP": "\\u00a3", "AUD": "\$", "SRD": "\$", "KRW": "\\u20a9", "VEF": "Bs", "LTL": "Lt", "CDF": "FC", "RUB": "\\u20bd", '
    '"MMK": "K", "PLN": "z\\u0142", "MKD": "\\u0434\\u0435\\u043d", "TOP": "T\$", "GNF": "FG", "WST": "WS\$", "ERN": "Nfk", "BAM": "KM", "CAD": "\$", "CVE": "\$", "PGK": "K", "SOS": '
    '"S", "STD": "Db", "BTC": "\\u0e3f", "STN": "Db", "XPF": "\\u20a3", "XOF": "CFA", "NZD": "\$", "LVL": "Ls", "ARS": "\$", "RSD": "\\u0414\\u0438\\u043d.", "BHD": ".\\u062f.\\u0628", '
    '"SDG": "\\u062c.\\u0633.", "NAD": "\$", "GHS": "GH\\u20b5", "EGP": "\\u00a3", "GHC": "\\u20b5", "BOB": "\$b", "DKK": "kr", "LBP": "\\u00a3", "AOA": "Kz", "KHR": "\\u17db", "MYR": '
    '"RM", "LYD": "LD", "JOD": "JD", "SAR": "\\ufdfc", "HKD": "\$", "CHF": "CHF", "MRU": "UM", "SVC": "\$", "MRO": "UM", "HRK": "kn", "XAF": "FCFA", "VUV": "VT", "UYU": "\$U", "PYG": "Gs", '
    '"NGN": "\\u20a6", "ZWD": "Z\$", "EEK": "kr", "MWK": "MK", "LKR": "\\u20a8", "DOP": "RD\$", "PKR": "\\u20a8", "SZL": "E", "MNT": "\\u20ae", "AMD": "\\u058f", "UGX": "USh", "IRR": "\\ufdfc", '
    '"JMD": "J\$", "SCR": "\\u20a8", "SHP": "\\u00a3", "AFN": "\\u060b", "TRL": "\\u20a4", "TRY": "\\u20ba", "BDT": "\\u09f3", "HTG": "G", "MGA": "Ar", "PHP": "\\u20b1", "LRD": "\$", "XCD": "\$", '
    '"SSP": "\\u00a3", "CZK": "K\\u010d", "TWD": "NT\$", "BTN": "Nu.", "MUR": "\\u20a8", "IDR": "Rp", "ISK": "kr", "RMB": "\\uffe5", "SEK": "kr", "CUP": "\\u20b1", "BBD": "\$", "KMF": "CF", "GMD": "D", '
    '"IMP": "\\u00a3", "CUC": "\$", "GEL": "\\u20be", "CLP": "\$", "EUR": "\\u20ac", "KZT": "\\u043b\\u0432", "OMR": "\\ufdfc", "BRL": "R\$", "KES": "KSh", "USD": "\$", "AZN": "\\u20bc", "MVR": "Rf", '
    '"IQD": "\\u0639.\\u062f", "GYD": "\$", "KWD": "KD", "BIF": "FBu", "SGD": "\$", "UZS": "\\u043b\\u0432", "CNY": "\\u00a5", "SLL": "Le", "TND": "\\u062f.\\u062a", '
    '"FKP": "\\u00a3", "LTC": "\\u0141", "KGS": "\\u043b\\u0432", "RON": "lei", "GTQ": "Q", "JPY": "\\u00a5"}';

final parsed_country_currency = json.decode(country_currency_map);
final parsed_country_currency_symbol = json.decode(currency_symbol_map);


final recent_countries = [
  "United States",
  "Canada",
  "Australia",
  "United Kingdom"
];

final countries = [
  'Canada',
  'Ethiopia',
  'Swaziland',
  'Svalbard and Jan Mayen Islands',
  'Cameroon',
  'Burkina Faso',
  'United States Minor Outlying Islands',
  'Cocos (Keeling) Islands',
  'Bosnia and Herzegovina',
  'Russian Federation',
  'Dominica',
  'Liberia',
  'Netherlands',
  'Tanzania',
  'Palestinian Territory',
  'Christmas Island',
  'Cambodia',
  'Monaco',
  'Jersey',
  'Macau',
  'Tajikistan',
  'Turkey',
  'Afghanistan',
  'Micronesia Federated States of',
  'France',
  'Vanuatu',
  'Nauru',
  'Norway',
  'Malawi',
  'Korea South',
  'Montenegro',
  'Dominican Republic',
  'Ghana',
  'Cayman Islands',
  'Finland',
  'Central African Republic',
  'Liechtenstein',
  'Mauritius',
  'Portugal',
  'Fiji',
  'Malaysia',
  'Isle of Man',
  'Pitcairn',
  'Congo Republic of the Democratic',
  'Panama',
  'Costa Rica',
  'Luxembourg',
  'American Samoa',
  'Andorra',
  'Algeria',
  'Gibraltar',
  'Ireland',
  'Italy',
  'Nigeria',
  'Ecuador',
  'Australia',
  'Vatican City State (Holy See)',
  'El Salvador',
  'Tuvalu',
  'Netherlands Antilles',
  'Thailand',
  'Belize',
  'Hong Kong',
  'Sierra Leone',
  'Georgia',
  'Denmark',
  'Philippines',
  'Morocco',
  'Guernsey',
  'Estonia',
  'Lebanon',
  'Uzbekistan',
  'Falkland Islands (Malvinas)',
  'Colombia',
  'Taiwan',
  'Cyprus',
  'Barbados',
  'Madagascar',
  'Palau',
  'Sudan',
  'Nepal',
  'Saint Vincent Grenadines',
  'Maldives',
  'Virgin Islands (US)',
  'Suriname',
  'Anguilla',
  'Korea North',
  'Aland Islands',
  'Israel',
  'Austria',
  'Papua New Guinea',
  'Zimbabwe',
  'Jordan',
  'Congo-Brazzaville',
  'Martinique',
  'Eritrea',
  'Trinidad and Tobago',
  'Latvia',
  'Japan',
  'Guadeloupe',
  'Mexico',
  'Serbia',
  'United Kingdom',
  'Greece',
  'Paraguay',
  'Gabon',
  'Botswana',
  'Sao Tome and Principe',
  'Lithuania',
  'Bahamas',
  'Aruba',
  'Argentina',
  'Bolivia',
  'Bahrain',
  'Saudi Arabia',
  'Cape Verde',
  'Slovenia',
  'Guatemala',
  'Guinea',
  'Saint Barthelemy',
  'Spain',
  'Congo (Kinshasa)',
  'Jamaica',
  'Oman',
  'Albania',
  'French Guiana',
  'Niue',
  'Samoa',
  'New Zealand',
  'Yemen',
  'Pakistan',
  'Greenland',
  'Moldova Republic of',
  'Norfolk Island',
  'United Arab Emirates',
  'Guam',
  'India',
  'Azerbaijan',
  'Lesotho',
  'Kenya',
  'Virgin Islands (British)',
  'Czech Republic',
  'Mauritania',
  'Iran (Islamic Republic of)',
  'Saint Lucia',
  'San Marino',
  'French Polynesia',
  'Wallis and Futuna Islands',
  'Syrian Arab Republic',
  'Bermuda',
  'Somalia',
  'Peru',
  'Laos',
  'Cook Islands',
  'Benin',
  'Cuba',
  'Togo',
  'China',
  'Armenia',
  'Ukraine',
  'Tonga',
  'Western Sahara',
  'Indonesia',
  'United States',
  'Sweden',
  'Vietnam',
  'Heard and Mc Donald Islands',
  'Mali',
  'Slovakia (Slovak Republic)',
  'Bulgaria',
  'Romania',
  'Angola',
  'French Southern Territories',
  'Chad',
  'South Africa',
  'Tokelau',
  'South Georgia and the South Sandwich Islands',
  'Brunei Darussalam',
  'Qatar',
  'Senegal',
  'Saint Kitts',
  'Mozambique',
  'Uganda',
  'Hungary',
  'Niger',
  'Brazil',
  'Faroe Islands',
  'Ivory Coast',
  'Bangladesh',
  'Belarus',
  'Macao S.A.R.',
  'East Timor',
  'Solomon Islands',
  'Marshall Islands',
  'Chile',
  'Puerto Rico',
  'Belgium',
  'Kiribati',
  'Haiti',
  'Iraq',
  'Gambia',
  'Namibia',
  'Mongolia',
  'Guinea-Bissau',
  'Switzerland',
  'Grenada',
  'Seychelles',
  'Uruguay',
  'Equatorial Guinea',
  'Egypt',
  'Djibouti',
  'Rwanda',
  'Antigua and Barbuda',
  'Reunion',
  'Burundi',
  'Turks and Caicos Islands',
  'Saint Martin (French part)',
  'Bhutan',
  'Malta',
  'Kuwait',
  'Northern Mariana Islands',
  'Venezuela',
  'Bouvet Island',
  'Croatia (Hrvatska)',
  'Iceland',
  'Zambia',
  'Germany',
  'Kazakhstan',
  'Poland',
  'Kyrgyzstan',
  'Mayotte',
  'British Indian Ocean Territory',
  'Montserrat',
  'New Caledonia',
  'Macedonia',
  'Guyana',
  'US Armed Forces',
  'Honduras',
  'Myanmar',
  'Tunisia',
  'Nicaragua',
  'Singapore',
  'Antarctica',
  'Sri Lanka',
  'Comoros'
];

var ratesObject = new Rates();
