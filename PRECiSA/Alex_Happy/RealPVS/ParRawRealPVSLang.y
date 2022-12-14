-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParRawRealPVSLang where
import AbsRawRealPVSLang
import LexRawRealPVSLang
import ErrM

}

%name pProgram Program
-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype {Token}
%token
  '(' { PT _ (TS _ 1) }
  ')' { PT _ (TS _ 2) }
  '*' { PT _ (TS _ 3) }
  '+' { PT _ (TS _ 4) }
  ',' { PT _ (TS _ 5) }
  '-' { PT _ (TS _ 6) }
  '->' { PT _ (TS _ 7) }
  '/' { PT _ (TS _ 8) }
  '/=' { PT _ (TS _ 9) }
  ':' { PT _ (TS _ 10) }
  '<' { PT _ (TS _ 11) }
  '<=' { PT _ (TS _ 12) }
  '=' { PT _ (TS _ 13) }
  '>' { PT _ (TS _ 14) }
  '>=' { PT _ (TS _ 15) }
  'AND' { PT _ (TS _ 16) }
  'ARRAY' { PT _ (TS _ 17) }
  'BEGIN' { PT _ (TS _ 18) }
  'ELSE' { PT _ (TS _ 19) }
  'ELSIF' { PT _ (TS _ 20) }
  'END' { PT _ (TS _ 21) }
  'ENDIF' { PT _ (TS _ 22) }
  'FALSE' { PT _ (TS _ 23) }
  'IF' { PT _ (TS _ 24) }
  'IMPORTING' { PT _ (TS _ 25) }
  'IN' { PT _ (TS _ 26) }
  'ItoD' { PT _ (TS _ 27) }
  'ItoS' { PT _ (TS _ 28) }
  'LAMBDA' { PT _ (TS _ 29) }
  'LET' { PT _ (TS _ 30) }
  'NOT' { PT _ (TS _ 31) }
  'OR' { PT _ (TS _ 32) }
  'PI' { PT _ (TS _ 33) }
  'RECURSIVE' { PT _ (TS _ 34) }
  'RtoD' { PT _ (TS _ 35) }
  'RtoS' { PT _ (TS _ 36) }
  'THEN' { PT _ (TS _ 37) }
  'THEORY' { PT _ (TS _ 38) }
  'TRUE' { PT _ (TS _ 39) }
  'VAR' { PT _ (TS _ 40) }
  '[' { PT _ (TS _ 41) }
  ']' { PT _ (TS _ 42) }
  '^' { PT _ (TS _ 43) }
  'abs' { PT _ (TS _ 44) }
  'acos' { PT _ (TS _ 45) }
  'asin' { PT _ (TS _ 46) }
  'atan' { PT _ (TS _ 47) }
  'below' { PT _ (TS _ 48) }
  'bool' { PT _ (TS _ 49) }
  'cos' { PT _ (TS _ 50) }
  'exp' { PT _ (TS _ 51) }
  'floor' { PT _ (TS _ 52) }
  'for' { PT _ (TS _ 53) }
  'int' { PT _ (TS _ 54) }
  'integer' { PT _ (TS _ 55) }
  'ln' { PT _ (TS _ 56) }
  'mod' { PT _ (TS _ 57) }
  'mod.mod' { PT _ (TS _ 58) }
  'pi' { PT _ (TS _ 59) }
  'posnat' { PT _ (TS _ 60) }
  'real' { PT _ (TS _ 61) }
  'sin' { PT _ (TS _ 62) }
  'sqrt' { PT _ (TS _ 63) }
  'subrange' { PT _ (TS _ 64) }
  'tan' { PT _ (TS _ 65) }
  'warning' { PT _ (TS _ 66) }
  '|' { PT _ (TS _ 67) }
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

ElsIf :: { ElsIf }
ElsIf : 'ELSIF' BExpr 'THEN' AExpr { AbsRawRealPVSLang.ElsIf $2 $4 }
ListElsIf :: { [ElsIf] }
ListElsIf : ElsIf { (:[]) $1 } | ElsIf ListElsIf { (:) $1 $2 }
ListAExpr :: { [AExpr] }
ListAExpr : AExpr { (:[]) $1 } | AExpr ',' ListAExpr { (:) $1 $3 }
AExpr :: { AExpr }
AExpr : AExpr1 { $1 }
      | 'LET' Id ':' Type '=' AExpr 'IN' AExpr { AbsRawRealPVSLang.LetWithType $2 $4 $6 $8 }
      | 'LET' Id '=' AExpr 'IN' AExpr { AbsRawRealPVSLang.Let $2 $4 $6 }
AExpr1 :: { AExpr }
AExpr1 : AExpr2 { $1 }
       | AExpr1 '+' AExpr2 { AbsRawRealPVSLang.Add $1 $3 }
       | AExpr1 '-' AExpr2 { AbsRawRealPVSLang.Sub $1 $3 }
AExpr2 :: { AExpr }
AExpr2 : AExpr3 { $1 }
       | AExpr2 '*' AExpr3 { AbsRawRealPVSLang.Mul $1 $3 }
       | AExpr2 '/' AExpr3 { AbsRawRealPVSLang.Div $1 $3 }
AExpr3 :: { AExpr }
AExpr3 : AExpr4 { $1 } | '-' AExpr4 { AbsRawRealPVSLang.Neg $2 }
AExpr4 :: { AExpr }
AExpr4 : AExpr5 { $1 }
       | 'IF' BExpr 'THEN' AExpr 'ELSE' AExpr 'ENDIF' { AbsRawRealPVSLang.If $2 $4 $6 }
       | 'IF' BExpr 'THEN' AExpr ListElsIf 'ELSE' AExpr 'ENDIF' { AbsRawRealPVSLang.ListIf $2 $4 $5 $7 }
       | 'for' '[' Type ']' '(' AExpr ',' AExpr ',' AExpr ',' 'LAMBDA' '(' Id ':' 'subrange' '(' AExpr ',' AExpr ')' ',' Id ':' Type ')' ':' AExpr ')' { AbsRawRealPVSLang.For $3 $6 $8 $10 $14 $18 $20 $23 $25 $28 }
       | AExpr5 '^' AExpr4 { AbsRawRealPVSLang.Pow $1 $3 }
       | 'floor' '(' AExpr ')' { AbsRawRealPVSLang.Floor $3 }
       | 'sqrt' '(' AExpr ')' { AbsRawRealPVSLang.Sqrt $3 }
       | 'abs' '(' AExpr ')' { AbsRawRealPVSLang.Abs $3 }
       | 'sin' '(' AExpr ')' { AbsRawRealPVSLang.Sin $3 }
       | 'cos' '(' AExpr ')' { AbsRawRealPVSLang.Cos $3 }
       | 'tan' '(' AExpr ')' { AbsRawRealPVSLang.Tan $3 }
       | 'asin' '(' AExpr ')' { AbsRawRealPVSLang.ASin $3 }
       | 'acos' '(' AExpr ')' { AbsRawRealPVSLang.ACos $3 }
       | 'atan' '(' AExpr ')' { AbsRawRealPVSLang.ATan $3 }
       | 'ln' '(' AExpr ')' { AbsRawRealPVSLang.Ln $3 }
       | 'exp' '(' AExpr ')' { AbsRawRealPVSLang.Exp $3 }
       | 'mod' '(' AExpr ',' AExpr ')' { AbsRawRealPVSLang.Mod1 $3 $5 }
       | 'mod.mod' '(' AExpr ',' AExpr ')' { AbsRawRealPVSLang.Mod2 $3 $5 }
       | 'RtoS' '(' AExpr ')' { AbsRawRealPVSLang.RtoS $3 }
       | 'RtoD' '(' AExpr ')' { AbsRawRealPVSLang.RtoD $3 }
       | 'ItoS' '(' AExpr ')' { AbsRawRealPVSLang.ItoS $3 }
       | 'ItoD' '(' AExpr ')' { AbsRawRealPVSLang.ItoD $3 }
AExpr5 :: { AExpr }
AExpr5 : AExpr6 { $1 }
       | Id '(' ListAExpr ')' { AbsRawRealPVSLang.FCallN $1 $3 }
       | 'pi' { AbsRawRealPVSLang.Pi1 }
       | 'PI' { AbsRawRealPVSLang.Pi2 }
       | Integer { AbsRawRealPVSLang.Int $1 }
       | Double { AbsRawRealPVSLang.Rat $1 }
       | Id { AbsRawRealPVSLang.Var $1 }
       | 'warning' { AbsRawRealPVSLang.UnstWarning }
AExpr6 :: { AExpr }
AExpr6 : AExpr7 { $1 }
AExpr7 :: { AExpr }
AExpr7 : AExpr8 { $1 }
AExpr8 :: { AExpr }
AExpr8 : AExpr9 { $1 }
AExpr9 :: { AExpr }
AExpr9 : AExpr10 { $1 }
AExpr10 :: { AExpr }
AExpr10 : '(' AExpr ')' { $2 }
BExpr :: { BExpr }
BExpr : BExpr1 { $1 }
      | BExpr 'OR' BExpr1 { AbsRawRealPVSLang.Or $1 $3 }
BExpr1 :: { BExpr }
BExpr1 : BExpr2 { $1 }
       | BExpr1 'AND' BExpr2 { AbsRawRealPVSLang.And $1 $3 }
BExpr2 :: { BExpr }
BExpr2 : BExpr3 { $1 } | 'NOT' BExpr3 { AbsRawRealPVSLang.Not $2 }
BExpr3 :: { BExpr }
BExpr3 : BExpr4 { $1 }
       | Id '(' ListAExpr ')' { AbsRawRealPVSLang.FPredN $1 $3 }
       | AExpr '=' AExpr { AbsRawRealPVSLang.Eq $1 $3 }
       | AExpr '/=' AExpr { AbsRawRealPVSLang.Neq $1 $3 }
       | AExpr '<' AExpr { AbsRawRealPVSLang.Lt $1 $3 }
       | AExpr '<=' AExpr { AbsRawRealPVSLang.LtE $1 $3 }
       | AExpr '>' AExpr { AbsRawRealPVSLang.Gt $1 $3 }
       | AExpr '>=' AExpr { AbsRawRealPVSLang.GtE $1 $3 }
BExpr4 :: { BExpr }
BExpr4 : BExpr5 { $1 }
       | 'TRUE' { AbsRawRealPVSLang.BTrue }
       | 'FALSE' { AbsRawRealPVSLang.BFalse }
BExpr5 :: { BExpr }
BExpr5 : '(' BExpr ')' { $2 }
Type :: { Type }
Type : 'real' { AbsRawRealPVSLang.TypeReal }
     | 'int' { AbsRawRealPVSLang.TypeInt }
     | 'integer' { AbsRawRealPVSLang.TypeInteger }
     | 'posnat' { AbsRawRealPVSLang.TypePosNat }
     | 'below' '(' Integer ')' { AbsRawRealPVSLang.TypeBelow $3 }
     | 'ARRAY' '[' 'integer' '->' Type ']' { AbsRawRealPVSLang.TypeArrayInteger $5 }
     | 'ARRAY' '[' 'int' '->' Type ']' { AbsRawRealPVSLang.TypeArrayInt $5 }
     | 'ARRAY' '[' 'below' '(' AExpr ')' '->' Type ']' { AbsRawRealPVSLang.TypeArrayBelow $5 $8 }
Subrange :: { Subrange }
Subrange : 'subrange' '(' Integer ',' Integer ')' { AbsRawRealPVSLang.SubrageType $3 $5 }
ListId :: { [Id] }
ListId : Id { (:[]) $1 } | Id ',' ListId { (:) $1 $3 }
ListArg :: { [Arg] }
ListArg : Arg { (:[]) $1 } | Arg ',' ListArg { (:) $1 $3 }
Arg :: { Arg }
Arg : ListId ':' Type { AbsRawRealPVSLang.FArg $1 $3 }
    | ListId ':' Subrange { AbsRawRealPVSLang.FArgSubrange $1 $3 }
    | ListId ':' Type '|' BExpr { AbsRawRealPVSLang.FArgGuard $1 $3 $5 }
Args :: { Args }
Args : ListArg { AbsRawRealPVSLang.FArgs $1 }
     | ListId { AbsRawRealPVSLang.FArgsNoType $1 }
ListDecl :: { [Decl] }
ListDecl : Decl { (:[]) $1 } | Decl ListDecl { (:) $1 $2 }
Decl :: { Decl }
Decl : Id '(' Args ')' ':' Type '=' AExpr { AbsRawRealPVSLang.DeclN $1 $3 $6 $8 }
     | Id '(' Args ')' ':' 'RECURSIVE' Type '=' AExpr { AbsRawRealPVSLang.DeclRec $1 $3 $7 $9 }
     | Id ':' Type '=' AExpr { AbsRawRealPVSLang.Decl0 $1 $3 $5 }
     | Id '(' Args ')' ':' 'bool' '=' BExpr { AbsRawRealPVSLang.PredN $1 $3 $8 }
     | Id ':' 'bool' '=' BExpr { AbsRawRealPVSLang.Pred0 $1 $5 }
Imp :: { Imp }
Imp : 'IMPORTING' ListId { AbsRawRealPVSLang.LibImp $2 }
VarDecl :: { VarDecl }
VarDecl : Id ':' 'VAR' Type { AbsRawRealPVSLang.VarDeclaration $1 $4 }
ListVarDecl :: { [VarDecl] }
ListVarDecl : {- empty -} { [] }
            | ListVarDecl VarDecl { flip (:) $1 $2 }
Program :: { Program }
Program : Id ':' 'THEORY' 'BEGIN' Imp ListVarDecl ListDecl 'END' Id { AbsRawRealPVSLang.Prog $1 $5 (reverse $6) $7 $9 }
        | Id ':' 'THEORY' 'BEGIN' ListVarDecl ListDecl 'END' Id { AbsRawRealPVSLang.ProgImp $1 (reverse $5) $6 $8 }
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

