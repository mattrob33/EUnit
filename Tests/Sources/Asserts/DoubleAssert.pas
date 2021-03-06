﻿namespace EUnit.Tests;

interface

uses
  Sugar,
  RemObjects.Elements.EUnit;

type
  DoubleAssert = public class (Test) 
  public
    method AreEqual;
    method AreNotEqual;
    method Greater;
    method GreaterOrEquals;
    method Less;
    method LessOrEquals;
    method IsNaN;
    method IsNotNaN;
    method IsInfinity;
    method IsNotInfinity;
  end;

implementation

method DoubleAssert.AreEqual;
begin
  Assert.AreEqual(1.5, 1.5);
  Assert.AreEqual(-1.1, -1.1);
  Assert.Throws(->Assert.AreEqual(1.5, 1.6), typeOf(AssertException));
  Assert.AreEqual(1 - Consts.PositiveInfinity, Consts.NegativeInfinity);
  Assert.AreEqual(Math.Asin(0.75), 0.84806, 0.00001);  
end;

method DoubleAssert.AreNotEqual;
begin
  Assert.AreNotEqual(1.5, 1.6);
  Assert.AreNotEqual(-1.1, 1.1);
  Assert.Throws(->Assert.AreNotEqual(1.1, 1.1), typeOf(AssertException));
  Assert.AreNotEqual(Consts.PositiveInfinity, Consts.NegativeInfinity);
  Assert.AreNotEqual(1, Consts.NaN);
  Assert.AreNotEqual(Consts.NaN, Consts.NaN);
end;


method DoubleAssert.Greater;
begin
  Assert.Greater(5.0, 4.0);
  Assert.Greater(4.2, 4.1);
  Assert.Greater(Consts.PositiveInfinity, Consts.NegativeInfinity);
  Assert.Throws(->Assert.Greater(4.1, 4.2), typeOf(AssertException));
  Assert.Throws(->Assert.Greater(4.1, 4.1), typeOf(AssertException));
end;

method DoubleAssert.GreaterOrEquals;
begin
  Assert.GreaterOrEquals(5.0, 4.0);
  Assert.GreaterOrEquals(4.2, 4.1);
  Assert.GreaterOrEquals(4.2, 4.2);
  Assert.GreaterOrEquals(Consts.PositiveInfinity, Consts.NegativeInfinity);
  Assert.Throws(->Assert.GreaterOrEquals(4.1, 4.2), typeOf(AssertException));  
end;

method DoubleAssert.Less;
begin
  Assert.Less(4.0, 5.0);
  Assert.Less(4.1, 4.2);
  Assert.Less(Consts.NegativeInfinity, Consts.PositiveInfinity);
  Assert.Throws(->Assert.Less(4.2, 4.1), typeOf(AssertException));
  Assert.Throws(->Assert.Less(4.1, 4.1), typeOf(AssertException));
end;

method DoubleAssert.LessOrEquals;
begin
  Assert.LessOrEquals(4.0, 5.0);
  Assert.LessOrEquals(4.1, 4.2);
  Assert.LessOrEquals(4.1, 4.1);
  Assert.LessOrEquals(Consts.NegativeInfinity, Consts.PositiveInfinity);
  Assert.Throws(->Assert.LessOrEquals(4.2, 4.1), typeOf(AssertException));
end;

method DoubleAssert.IsNaN;
begin
  Assert.IsNaN(Consts.NaN);
  Assert.IsNaN(Consts.PositiveInfinity/Consts.PositiveInfinity); 
  Assert.Throws(->Assert.IsNaN(1), typeOf(AssertException)); 
end;

method DoubleAssert.IsNotNaN;
begin
  Assert.IsNotNaN(1);
  Assert.IsNotNaN(Consts.PositiveInfinity); 
  Assert.Throws(->Assert.IsNotNaN(Consts.PositiveInfinity/Consts.PositiveInfinity), typeOf(AssertException)); 
end;

method DoubleAssert.IsInfinity;
begin
  Assert.IsInfinity(Consts.PositiveInfinity); 
  Assert.IsInfinity(Consts.NegativeInfinity); 
  Assert.IsInfinity(Math.Log10(0));
  Assert.Throws(->Assert.IsInfinity(1), typeOf(AssertException));
end;

method DoubleAssert.IsNotInfinity;
begin
  Assert.IsNotInfinity(Consts.NaN);
  Assert.IsNotInfinity(1);
  Assert.Throws(->Assert.IsNotInfinity(Consts.PositiveInfinity), typeOf(AssertException));
  Assert.Throws(->Assert.IsNotInfinity(Consts.NegativeInfinity), typeOf(AssertException));
  Assert.Throws(->Assert.IsNotInfinity(Math.Log10(0)), typeOf(AssertException));
end;

end.    