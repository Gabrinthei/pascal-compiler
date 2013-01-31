--Authored by Tyler J. Huffman
--
--This is the list of functions used in the microPascal compiler
module DigitFSA (digitFSA) where
import Data.List
import Data.Char
import TokenTable

--Top-level state machine to obtain a valid token from the string
--
--Parameters: src - The source string from a text file
--            lexeme - The section that has a valid token
--            column_number - The distance inside of the src string
--            line_number - The line in the token
--Returns: Tuple containing the above
digitFSA :: (String, String, Int, Int) -> (String, String, Token, Int, Int)
digitFSA (src, lexeme, column_number, line_number)
    | stringHead `elem` ['0'..'9']
        = digitFSA          (tail src, lexeme ++ (charToString stringHead), column_number + 1, line_number)
    | (stringHead == 'e' && stringNext `elem` ['0'..'9']) || (stringHead == 'E' && stringNext `elem` ['0'..'9'])
        = digitFSAforE      (tail src, lexeme ++ (charToString stringHead), column_number + 1, line_number)
    | stringHead == '.' && stringNext `elem` ['0'..'9']
        = digitFSAforPeriod (tail src, lexeme ++ (charToString stringHead), column_number + 1, line_number)
    | otherwise
        = (src, lexeme, IdentifiersAndLiterals MP_INTEGER_LIT, column_number,  line_number)
    where stringHead = if src == [] then ' ' else head src
          stringNext
              | stringHead /= ' ' && tail src /= [] = src !! 1
              | otherwise = 'x' --This is the failure character.

--Sub-level state machine when an E or an e is found
--
--Parameters: src - The source string from a text file
--            lexeme - The section that has a valid token
--            column_number - The distance inside of the src string
--            line_number - The line in the token
--Returns: Tuple containing the above
digitFSAforE :: (String, String, Int, Int) -> (String, String, Token, Int, Int)
digitFSAforE (src, lexeme, column_number, line_number)
    | stringHead `elem` ['0'..'9']
        = digitFSAforE (tail src, lexeme ++ (charToString stringHead), column_number + 1, line_number)
    | otherwise
        = (src, lexeme, IdentifiersAndLiterals MP_FLOAT_LIT, column_number, line_number)
    where stringHead = if src == [] then ' ' else head src

--Sub-level state machine for when a period is found in the code
--
--Parameters: src - The source string from a text file
--            lexeme - The section that has a valid token
--            column_number - The distance inside of the src string
--            line_number - The line in the token
--Returns: Tuple containing the above
digitFSAforPeriod :: (String, String, Int, Int) -> (String, String, Token, Int, Int)
digitFSAforPeriod (src, lexeme, column_number, line_number)
    | stringHead `elem` ['0'..'9']
        = digitFSAforPeriod (tail src, lexeme ++ (charToString stringHead), column_number + 1, line_number)
    | stringHead == 'e' || stringHead == 'E'
        = digitFSAforE (tail src, lexeme ++ (charToString stringHead), column_number + 1, line_number)
    | otherwise
        = (src, lexeme, IdentifiersAndLiterals MP_FIXED_LIT, column_number, line_number)
    where stringHead = if src == [] then ' ' else head src

--Helper function that turns a Char into a String
--
--Parameters: Char
--Returns: String
charToString :: Char -> String
charToString c = [c]