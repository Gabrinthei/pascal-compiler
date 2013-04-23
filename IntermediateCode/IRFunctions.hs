--Intermediate Code Generation Functions
--
--Authored by: Tyler J. Huffman
--
--Edited: Feb. 19, 2013

module IntermediateCode.IRFunctions where

import Debug.Trace
import Parser.ParsingData
import Parser.Helper
import Scanner.TokenTable

generatePopDestination :: ParsingData -> ScopeData -> ParsingData
generatePopDestination parsingData scopeData = ParsingData {   
                                      lookAheadToken = lookAheadToken parsingData
                                    , hasFailed = hasFailed parsingData
                                    , line = line parsingData
                                    , column = column parsingData
                                    , errorString = errorString parsingData
                                    , input = input parsingData
                                    , symbolTables = symbolTables parsingData 
                                    , current_lexeme = current_lexeme parsingData
                                    , intermediateCode = (intermediateCode parsingData) ++ ["POP " ++ show (offset scopeData) ++ "(D" ++ (show (level scopeData)) ++ ")"] 
                                    , tagAlong = tagAlong parsingData }

generatePushLiterals :: ParsingData -> ParsingData
generatePushLiterals parsingData = ParsingData {   
                                      lookAheadToken = lookAheadToken parsingData
                                    , hasFailed = hasFailed parsingData
                                    , line = line parsingData
                                    , column = column parsingData
                                    , errorString = errorString parsingData
                                    , input = input parsingData
                                    , symbolTables = symbolTables parsingData 
                                    , current_lexeme = current_lexeme parsingData
                                    , intermediateCode = (intermediateCode parsingData) ++ ["PUSH " ++ "#" ++ current_lexeme parsingData] 
                                    , tagAlong = tagAlong parsingData }

generatePushIdentifier :: ParsingData -> ScopeData -> ParsingData
generatePushIdentifier parsingData scopeData = ParsingData {   
                                      lookAheadToken = lookAheadToken parsingData
                                    , hasFailed = hasFailed parsingData
                                    , line = line parsingData
                                    , column = column parsingData
                                    , errorString = errorString parsingData
                                    , input = input parsingData
                                    , symbolTables = symbolTables parsingData 
                                    , current_lexeme = current_lexeme parsingData
                                    , intermediateCode = (intermediateCode parsingData) ++ ["PUSH " ++ (show (offset scopeData)) ++ "(D" ++ (show (level scopeData)) ++ ")"] 
                                    , tagAlong = tagAlong parsingData }

generateReadFunction :: ParsingData -> ScopeData -> ParsingData
generateReadFunction parsingData scopeData = ParsingData {   
                                      lookAheadToken = lookAheadToken parsingData
                                    , hasFailed = hasFailed parsingData
                                    , line = line parsingData
                                    , column = column parsingData
                                    , errorString = errorString parsingData
                                    , input = input parsingData
                                    , symbolTables = symbolTables parsingData 
                                    , current_lexeme = current_lexeme parsingData
                                    , intermediateCode = (intermediateCode parsingData) ++ ["RD " ++ (show (offset scopeData)) ++ "(D" ++ (show (level scopeData)) ++ ")"] 
                                    , tagAlong = tagAlong parsingData }

generateWriteFunction :: ParsingData -> ParsingData
generateWriteFunction parsingData = ParsingData {   
                                      lookAheadToken = lookAheadToken parsingData
                                    , hasFailed = hasFailed parsingData
                                    , line = line parsingData
                                    , column = column parsingData
                                    , errorString = errorString parsingData
                                    , input = input parsingData
                                    , symbolTables = symbolTables parsingData 
                                    , current_lexeme = current_lexeme parsingData
                                    , intermediateCode = (intermediateCode parsingData) ++ ["WRTS"] 
                                    , tagAlong = tagAlong parsingData }

--Need to determine if integer or float before doing it.
generateStackModifierInteger :: ParsingData -> String -> ParsingData
generateStackModifierInteger parsingData operator
      | operator ==  "MP_PLUS"
            = ParsingData {   
                    lookAheadToken = lookAheadToken parsingData
                  , hasFailed = hasFailed parsingData
                  , line = line parsingData
                  , column = column parsingData
                  , errorString = errorString parsingData
                  , input = input parsingData
                  , symbolTables = symbolTables parsingData 
                  , current_lexeme = current_lexeme parsingData
                  , intermediateCode = (intermediateCode parsingData) ++ ["ADDS"] 
                  , tagAlong = tagAlong parsingData }
      | operator ==  "MP_MINUS"
            = ParsingData {   
                    lookAheadToken = lookAheadToken parsingData
                  , hasFailed = hasFailed parsingData
                  , line = line parsingData
                  , column = column parsingData
                  , errorString = errorString parsingData
                  , input = input parsingData
                  , symbolTables = symbolTables parsingData 
                  , current_lexeme = current_lexeme parsingData
                  , intermediateCode = (intermediateCode parsingData) ++ ["SUBS"] 
                  , tagAlong = tagAlong parsingData }
      | operator ==  "MP_TIMES"
            = ParsingData {   
                    lookAheadToken = lookAheadToken parsingData
                  , hasFailed = hasFailed parsingData
                  , line = line parsingData
                  , column = column parsingData
                  , errorString = errorString parsingData
                  , input = input parsingData
                  , symbolTables = symbolTables parsingData 
                  , current_lexeme = current_lexeme parsingData
                  , intermediateCode = (intermediateCode parsingData) ++ ["MULS"] 
                  , tagAlong = tagAlong parsingData }
      | operator ==  "MP_DIV"
            = ParsingData {   
                    lookAheadToken = lookAheadToken parsingData
                  , hasFailed = hasFailed parsingData
                  , line = line parsingData
                  , column = column parsingData
                  , errorString = errorString parsingData
                  , input = input parsingData
                  , symbolTables = symbolTables parsingData 
                  , current_lexeme = current_lexeme parsingData
                  , intermediateCode = (intermediateCode parsingData) ++ ["DIVS"] 
                  , tagAlong = tagAlong parsingData }
      | operator ==  "MP_MOD"
            = ParsingData {   
                    lookAheadToken = lookAheadToken parsingData
                  , hasFailed = hasFailed parsingData
                  , line = line parsingData
                  , column = column parsingData
                  , errorString = errorString parsingData
                  , input = input parsingData
                  , symbolTables = symbolTables parsingData 
                  , current_lexeme = current_lexeme parsingData
                  , intermediateCode = (intermediateCode parsingData) ++ ["MODS"] 
                  , tagAlong = tagAlong parsingData }
      | operator ==  "MP_AND"
            = ParsingData {   
                    lookAheadToken = lookAheadToken parsingData
                  , hasFailed = hasFailed parsingData
                  , line = line parsingData
                  , column = column parsingData
                  , errorString = errorString parsingData
                  , input = input parsingData
                  , symbolTables = symbolTables parsingData 
                  , current_lexeme = current_lexeme parsingData
                  , intermediateCode = (intermediateCode parsingData) ++ ["ANDS"] 
                  , tagAlong = tagAlong parsingData }
      | operator ==  "MP_OR"
            = ParsingData {   
                    lookAheadToken = lookAheadToken parsingData
                  , hasFailed = hasFailed parsingData
                  , line = line parsingData
                  , column = column parsingData
                  , errorString = errorString parsingData
                  , input = input parsingData
                  , symbolTables = symbolTables parsingData 
                  , current_lexeme = current_lexeme parsingData
                  , intermediateCode = (intermediateCode parsingData) ++ ["ORS"] 
                  , tagAlong = tagAlong parsingData }
      | operator ==  "MP_NOT"
            = ParsingData {   
                    lookAheadToken = lookAheadToken parsingData
                  , hasFailed = hasFailed parsingData
                  , line = line parsingData
                  , column = column parsingData
                  , errorString = errorString parsingData
                  , input = input parsingData
                  , symbolTables = symbolTables parsingData 
                  , current_lexeme = current_lexeme parsingData
                  , intermediateCode = (intermediateCode parsingData) ++ ["NOTS"] 
                  , tagAlong = tagAlong parsingData }
      | otherwise
            = ParsingData {   
                    lookAheadToken = lookAheadToken parsingData
                  , hasFailed = hasFailed parsingData
                  , line = line parsingData
                  , column = column parsingData
                  , errorString = errorString parsingData
                  , input = input parsingData
                  , symbolTables = symbolTables parsingData 
                  , current_lexeme = current_lexeme parsingData
                  , intermediateCode = (intermediateCode parsingData) ++ ["ERROR"] 
                  , tagAlong = tagAlong parsingData }
