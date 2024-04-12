___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Remove Accents And Spaces",
  "description": "Removes accents and spaces from words, recommended for sending to the Facebook Conversion API",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "field_selector",
    "displayName": "Campo a ser modificado",
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_SERVER___

var createRegex = require('createRegex');

function removeAccentSpaces(value){
  value = convertSpecialChars(value);
  value = removeAccents(value);
  return value;
}  

function removeAccents(text) {
   var domainRegex = createRegex('([\u0300-\u036f]|[^0-9a-zA-Z])', 'g');
   text = removeDiacritics(text);
   return text.replace(domainRegex, "");
}


function convertSpecialChars(text) {
  text = text.toUpperCase();
    var charsMap = {
        "Ã¢": "â",
        "Ã©": "é",
        "Ã¨": "è",
        "Ãª": "ê",
        "Ã«": "ë",
        "Ã®": "î",
        "Ã¯": "ï",
        "Ã´": "ô",
        "Ã¶": "ö",
        "Ã¹": "ù",
        "Ã»": "û",
        "Ã¼": "ü",
        "Ã§": "ç",
        "Å?": "œ",
        "â¬": "€",
        "Â°": "°",
        "Ã": "à",
    };
    for (var key in charsMap) {
        if (charsMap.hasOwnProperty(key)) {
            text = text.split(key).join(charsMap[key]);
        }
    }
  
    return text.toLowerCase();
}

function removeDiacritics(str) {
    const diacriticsMap = {
        'À': 'A', 'Á': 'A', 'Â': 'A', 'Ã': 'A', 'Ä': 'A', 'Å': 'A',
        'à': 'a', 'á': 'a', 'â': 'a', 'ã': 'a', 'ä': 'a', 'å': 'a',
        'È': 'E', 'É': 'E', 'Ê': 'E', 'Ë': 'E',
        'è': 'e', 'é': 'e', 'ê': 'e', 'ë': 'e',
        'Ì': 'I', 'Í': 'I', 'Î': 'I', 'Ï': 'I',
        'ì': 'i', 'í': 'i', 'î': 'i', 'ï': 'i',
        'Ò': 'O', 'Ó': 'O', 'Ô': 'O', 'Õ': 'O', 'Ö': 'O',
        'ò': 'o', 'ó': 'o', 'ô': 'o', 'õ': 'o', 'ö': 'o',
        'Ù': 'U', 'Ú': 'U', 'Û': 'U', 'Ü': 'U',
        'ù': 'u', 'ú': 'u', 'û': 'u', 'ü': 'u',
        'Ý': 'Y', 'ý': 'y', 'ÿ': 'y',
        'Ñ': 'N', 'ñ': 'n', 'ç': 'c',  'Ç': 'C'
    };
  
  var regexAccents = createRegex('[^\u0000-\u007E]', 'g');    
    return str.replace(regexAccents, function(a) {
        return diacriticsMap[a] || a;
    });
}


var str = data.field_selector;
if(str) {
  return removeAccentSpaces(str);
}

return "";


___TESTS___

scenarios:
- name: Testar palavra com caracter especial
  code: |-
    const mockData = {
         field_selector: 'macaã©'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo('macae');
- name: Testar palavras com espaços e acentuações
  code: |-
    const mockData = {
         field_selector: 'Nova Iguaçu'
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo('novaiguacu');


___NOTES___

Created on 12/04/2024, 11:35:04


