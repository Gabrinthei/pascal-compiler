module Parser.ParsingData where

import Scanner.TokenTable
import Scanner.ScannerData

data ParsingData = ParsingData {  lookAheadToken :: Token
                                , hasFailed :: Bool
                                , line :: Int
                                , column :: Int
                                , errorString :: String
                                , input :: [ScannerData]
                                , symbolTables :: [SymbolTable]
                                } deriving (Show)

data SymbolTable = SymbolTable {  values :: [ScopeData] } deriving (Show)

data ScopeData = ScopeData {  name :: String
                            , kind :: String
                            , varType :: String
                            , attribute :: String
                            , offset :: Int
                            } deriving (Show)

create :: ParsingData -> ParsingData
create parsingData
    = ParsingData { lookAheadToken=(lookAheadToken parsingData)
                  , hasFailed=(hasFailed parsingData)
                  , line=(line parsingData)
                  , column=(column parsingData)
                  , input=(input parsingData)
                  , symbolTables=(symbolTables parsingData ++ [SymbolTable { values=[] }])
                }

destroy :: ParsingData -> ParsingData
destroy parsingData
    = ParsingData { lookAheadToken=(lookAheadToken parsingData)
                  , hasFailed=(hasFailed parsingData)
                  , line=(line parsingData)
                  , column=(column parsingData)
                  , input=(input parsingData)
                  , symbolTables=(init (symbolTables parsingData))
                }

insertData :: ParsingData -> ScopeData -> ParsingData
insertData parsingData scopeData
    = ParsingData { lookAheadToken=(lookAheadToken parsingData)
                  , hasFailed=(hasFailed parsingData)
                  , line=(line parsingData)
                  , column=(column parsingData)
                  , input=(input parsingData)
                  , symbolTables=(newTables ++ [SymbolTable { values=newVals }])
                }
              where
                newTables = init (symbolTables parsingData)
                oldTable = last (symbolTables parsingData)
                newVals = values (last (symbolTables parsingData)) ++ [scopeData]
