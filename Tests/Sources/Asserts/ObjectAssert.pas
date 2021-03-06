﻿namespace EUnit.Tests;

interface

uses
  RemObjects.Elements.EUnit;

type
  ObjectAssertTest = public class (Test) 
  public
    method AreEqual;
    method AreNotEqual;
    method IsNil;
    method IsNotNil;
  end;

implementation

method ObjectAssertTest.AreEqual;
begin
  var Expected := new CodeObject(1);
 
  Assert.AreEqual(Expected, Expected);
  Assert.AreEqual(new CodeObject(1), Expected);
  Assert.AreEqual(Object("a"), Object("a"));
  Expected := nil;
  Assert.AreEqual(nil, Expected);   

  Assert.Throws(->Assert.AreEqual(new CodeObject(2), new CodeObject(1)), typeOf(AssertException));
  Assert.Throws(->Assert.AreEqual(nil, new CodeObject(1)), typeOf(AssertException));
  Assert.Throws(->Assert.AreEqual(new CodeObject(1), nil), typeOf(AssertException));
end;

method ObjectAssertTest.AreNotEqual;
begin
  var Expected := new CodeObject(1);
 
  Assert.AreNotEqual(Expected, nil);
  Assert.AreNotEqual(nil, Expected);
  Assert.AreNotEqual(new CodeObject(2), Expected);

  Assert.Throws(->Assert.AreNotEqual(Expected, Expected), typeOf(AssertException));
  Assert.Throws(->Assert.AreNotEqual(new CodeObject(1), new CodeObject(1)), typeOf(AssertException));
end;

method ObjectAssertTest.IsNil;
begin
  Assert.IsNil(nil);
  Assert.Throws(->Assert.IsNil(new CodeObject(1)), typeOf(AssertException)); 
end;

method ObjectAssertTest.IsNotNil;
begin
  Assert.IsNotNil(new CodeObject(1));
  Assert.Throws(->Assert.IsNotNil(nil), typeOf(AssertException)); 
end;

end.    