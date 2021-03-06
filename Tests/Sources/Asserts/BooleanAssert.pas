﻿namespace EUnit.Tests;

interface

uses
  RemObjects.Elements.EUnit;

type
  BooleanAssertTest = public class (Test) 
  public
    method AreEqual;
    method AreNotEqual;
    method IsTrue;
    method IsFalse;
  end;

implementation

method BooleanAssertTest.AreEqual;
begin
  Assert.AreEqual(true, true);
  Assert.AreEqual(false, false);
  Assert.Throws(->Assert.AreEqual(true, false), typeOf(AssertException));
  Assert.Throws(->Assert.AreEqual(false, true), typeOf(AssertException));
end;

method BooleanAssertTest.AreNotEqual;
begin
  Assert.AreNotEqual(true, false);
  Assert.AreNotEqual(false, true);
  Assert.Throws(->Assert.AreNotEqual(true, true), typeOf(AssertException));
  Assert.Throws(->Assert.AreNotEqual(false, false), typeOf(AssertException));
end;

method BooleanAssertTest.IsTrue;
begin
  Assert.IsTrue(true);
  Assert.Throws(->Assert.IsTrue(false), typeOf(AssertException));
end;

method BooleanAssertTest.IsFalse;
begin
  Assert.IsFalse(false);
  Assert.Throws(->Assert.IsFalse(true), typeOf(AssertException));
end;

end.    