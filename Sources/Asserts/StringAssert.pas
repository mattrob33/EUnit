﻿namespace RemObjects.Elements.EUnit;

interface

type
  BaseAsserts = public partial abstract class
  public
    method AreEqual(Actual, Expected : String; IgnoreCase: Boolean := false; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method AreNotEqual(Actual, Expected: String; IgnoreCase: Boolean := false; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method Contains(SubString, InString: String; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method DoesNotContains(SubString, InString: String; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());

    method StartsWith(Prefix, SourceString: String; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method EndsWith(Suffix, SourceString: String; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());

    method IsEmpty(Actual: String; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method IsNotEmpty(Actual: String; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
  end;

implementation

method BaseAsserts.AreEqual(Actual: String; Expected: String; IgnoreCase: Boolean := false; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  if (Expected = nil) and (Actual = nil) then
    exit;

  if (Expected = nil) and (Actual <> nil) then
    FailComparison(Actual, Expected, coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod)
  else if IgnoreCase then
    FailComparisonIfNot(Expected.EqualsIgnoringCase(Actual), Actual, Expected, coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod)
  else
    FailComparisonIfNot(Expected.Equals(Actual), Actual, Expected, coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.AreNotEqual(Actual: String; Expected: String; IgnoreCase: Boolean := false; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  if (Expected = nil) and (Actual <> nil) then
    exit;
  if (Expected <> nil) and (Actual = nil) then
    exit;

  if (Expected = nil) and (Actual = nil) then
    FailComparison(Actual, Expected, coalesce(Message, AssertMessages.Equal), aFile, aLine, aClass, aMethod)
  else if IgnoreCase then
    FailComparisonIf(Expected.EqualsIgnoringCase(Actual), Actual, Expected, coalesce(Message, AssertMessages.Equal), aFile, aLine, aClass, aMethod)
  else
    FailComparisonIf(Expected.Equals(Actual), Actual, Expected, coalesce(Message, AssertMessages.Equal), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.Contains(SubString: String; InString: String; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  ArgumentNilException.RaiseIfNil(InString, "InString");
  ArgumentNilException.RaiseIfNil(SubString, "SubString");

  FailComparisonIfNot(InString.Contains(SubString), SubString, "String", coalesce(Message, AssertMessages.DoesNotContains), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.DoesNotContains(SubString: String; InString: String; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  ArgumentNilException.RaiseIfNil(InString, "InString");
  ArgumentNilException.RaiseIfNil(SubString, "SubString");

  FailComparisonIf(InString.Contains(SubString), SubString, "String", coalesce(Message, AssertMessages.UnexpectedContains), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.StartsWith(Prefix: String; SourceString: String; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  ArgumentNilException.RaiseIfNil(Prefix, "Prefix");
  ArgumentNilException.RaiseIfNil(SourceString, "SourceString");

  FailComparisonIfNot(SourceString.StartsWith(Prefix), Prefix, SourceString, coalesce(Message, AssertMessages.StringPrefixMissing), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.EndsWith(Suffix: String; SourceString: String; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  ArgumentNilException.RaiseIfNil(Suffix, "Suffix");
  ArgumentNilException.RaiseIfNil(SourceString, "SourceString");

  FailComparisonIfNot(SourceString.EndsWith(Suffix), Suffix, SourceString, coalesce(Message, AssertMessages.StringSufixMissing));
end;

method BaseAsserts.IsEmpty(Actual: String; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  ArgumentNilException.RaiseIfNil(Actual, "Actual");
  FailComparisonIfNot(Actual.Length = 0, Actual, "String", coalesce(Message, AssertMessages.IsNotEmpty), aFile, aLine, aClass, aMethod);
end;

  method BaseAsserts.IsNotEmpty(Actual: String; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  ArgumentNilException.RaiseIfNil(Actual, "Actual");
  FailComparisonIfNot(Actual.Length <> 0, Actual, "String", coalesce(Message, AssertMessages.IsEmpty), aFile, aLine, aClass, aMethod);
end;

end.