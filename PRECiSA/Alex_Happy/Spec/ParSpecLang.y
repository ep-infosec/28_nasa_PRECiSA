-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParSpecLang where
import AbsSpecLang
import LexSpecLang
import ErrM

}

%name pSpec Spec
-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype {Token}
%token
  '(' { PT _ (TS _ 1) }
  ')' { PT _ (TS _ 2) }
  '+inf' { PT _ (TS _ 3) }
  ',' { PT _ (TS _ 4) }
  '-' { PT _ (TS _ 5) }
  '-inf' { PT _ (TS _ 6) }
  ':' { PT _ (TS _ 7) }
  '[' { PT _ (TS _ 8) }
  ']' { PT _ (TS _ 9) }
  'in' { PT _ (TS _ 10) }
  L_integ  { PT _ (TI $$) }
  L_doubl  { PT _ (TD $$) }
  L_Id { PT _ (T_Id $$) }

%%

Integer :: { Integer }
Integer  : L_integ  { (read ( $1)) :: Integer }

Double  :: { Double }
Double   : L_doubl  { (read ( $1)) :: Double }

Id :: { Id}
Id  : L_Id { Id ($1)}

LBound :: { LBound }
LBound : Integer { AbsSpecLang.LBInt $1 }
       | Double { AbsSpecLang.LBDouble $1 }
       | '-' Integer { AbsSpecLang.LBNegInt $2 }
       | '-' Double { AbsSpecLang.LBNegDouble $2 }
       | '-inf' { AbsSpecLang.LInf }
UBound :: { UBound }
UBound : Integer { AbsSpecLang.UBInt $1 }
       | Double { AbsSpecLang.UBDouble $1 }
       | '-' Integer { AbsSpecLang.UBNegInt $2 }
       | '-' Double { AbsSpecLang.UBNegDouble $2 }
       | '+inf' { AbsSpecLang.UInf }
ListVarBind :: { [VarBind] }
ListVarBind : VarBind { (:[]) $1 }
            | VarBind ',' ListVarBind { (:) $1 $3 }
VarBind :: { VarBind }
VarBind : Id 'in' '[' LBound ',' UBound ']' { AbsSpecLang.VarSpec $1 $4 $6 }
ListId :: { [Id] }
ListId : Id { (:[]) $1 } | Id ',' ListId { (:) $1 $3 }
SpecBind :: { SpecBind }
SpecBind : Id '(' ListId ')' ':' ListVarBind { AbsSpecLang.SpecBindN $1 $3 $6 }
         | Id ':' ListVarBind { AbsSpecLang.SpecBind0 $1 $3 }
ListSpecBind :: { [SpecBind] }
ListSpecBind : SpecBind { (:[]) $1 }
             | SpecBind ListSpecBind { (:) $1 $2 }
Spec :: { Spec }
Spec : ListSpecBind { AbsSpecLang.Specification $1 }
{

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++
  case ts of
    []      -> []
    [Err _] -> " due to lexer error"
    t:_     -> " before `" ++ id(prToken t) ++ "'"

myLexer = tokens
}

