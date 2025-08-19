-- Lambda calculus encoding of booleans in Haskell
-- Church booleans
-- These encode boolean values as functions
true :: a-> a-> a
true = \x y-> x-- example: returns the first argument
 
false :: a-> a-> a
false = \x y-> y-- returns the second argument
 
-- ifThenElse using a Church boolean
-- It should return one of the two values depending on the boolean
ifThenElse :: (a-> a-> a)-> a-> a-> a
ifThenElse = \b x y -> b x y
 
-- Logical operations using Church booleans
churchAnd :: (a-> a-> a)-> (a-> a-> a)-> a-> a-> a
churchAnd p q = \x y -> p (q x y) y

churchOr :: (a-> a-> a)-> (a-> a-> a)-> a-> a-> a
churchOr p q = \x y -> p x (q x y)
 
churchNot :: (a-> a-> a)-> a-> a-> a
churchNot p = \x y -> p y x
 
-- Converts a Church boolean to a string
-- This helps visualize the output
showBool :: (String-> String-> String)-> String
showBool b = b "True" "False"
 
-- Run tests
main :: IO ()
main = do
  putStrLn $ "true AND false = " ++ showBool (churchAnd true false)
  putStrLn $ "true OR false = " ++ showBool (churchOr true false)
  putStrLn $ "NOT true = " ++ showBool (churchNot true)
  putStrLn $ "NOT false = " ++ showBool (churchNot false)
  putStrLn $ "ifThenElse true \"yes\" \"no\" = " ++ ifThenElse true "yes" "no"
  putStrLn $ "ifThenElse false \"yes\" \"no\" = " ++ ifThenElse false "yes" "no"