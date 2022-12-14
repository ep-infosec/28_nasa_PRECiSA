-- Haskell data types for the abstract syntax.
-- Generated by the BNF converter.

module AbsRawPVSLang where

newtype Id = Id String
  deriving (Eq, Ord, Show, Read)

data ElsIf = ElsIf Expr Expr
  deriving (Eq, Ord, Show, Read)

data LetElem = LetElem Id Expr | LetElemType Id Id Expr
  deriving (Eq, Ord, Show, Read)

data Expr
    = Let [LetElem] Expr
    | Or Expr Expr
    | And Expr Expr
    | Not Expr
    | Eq Expr Expr
    | Neq Expr Expr
    | Lt Expr Expr
    | LtE Expr Expr
    | Gt Expr Expr
    | GtE Expr Expr
    | ExprAdd Expr Expr
    | ExprSub Expr Expr
    | ExprMul Expr Expr
    | ExprDiv Expr Expr
    | ExprNeg Expr
    | ExprPow Expr Expr
    | If Expr Expr Expr
    | ListIf Expr Expr [ElsIf] Expr
    | For Integer Integer Expr Id
    | Call Id [Expr]
    | ExprId Id
    | Int Integer
    | Rat Double
    | BTrue
    | BFalse
  deriving (Eq, Ord, Show, Read)

data Subrange = SubrageType Integer Integer
  deriving (Eq, Ord, Show, Read)

data Arg
    = FArg [Id] Id
    | FArgSubrange [Id] Subrange
    | FArgGuard [Id] Id Expr
  deriving (Eq, Ord, Show, Read)

data Args = FArgs [Arg] | FArgsNoType [Id]
  deriving (Eq, Ord, Show, Read)

data Decl = DeclN Id Args Id Expr | Decl0 Id Id Expr
  deriving (Eq, Ord, Show, Read)

data Imp = LibImp [Id]
  deriving (Eq, Ord, Show, Read)

data VarDecl = VarDeclaration Id Id
  deriving (Eq, Ord, Show, Read)

data Program
    = ProgImp Id Imp [VarDecl] [Decl] Id | Prog Id [VarDecl] [Decl] Id
  deriving (Eq, Ord, Show, Read)

