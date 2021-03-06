﻿namespace EUnit.Tests;

interface

uses
  RemObjects.Elements.EUnit;

type
  ExceptionAssert = public class (Test) 
  public
    method Throws;
    method DoesNotThrows;
    method Catch;
  end;

implementation

method ExceptionAssert.Throws;
begin
  Assert.Throws(->raise new ArgumentException("", ""));
  Assert.Throws(->Assert.Fail(nil)); 
  Assert.Throws(->Assert.Throws(->Assert.AreEqual(true, true)));
  Assert.Throws(->raise new ArgumentException("", ""), typeOf(ArgumentException));
  Assert.Throws(->Assert.Throws(->raise new ArgumentException("", ""), typeOf(RunnerException)));
  Assert.Throws(->Assert.Throws(nil), typeOf(ArgumentNilException));
end;

method ExceptionAssert.DoesNotThrows;
begin
  Assert.DoesNotThrows(->Assert.AreEqual(true, true));
  Assert.Throws(->Assert.DoesNotThrows(->Assert.AreEqual(true, false)));
  Assert.Throws(->Assert.DoesNotThrows(nil), typeOf(ArgumentNilException));
end;

method ExceptionAssert.Catch;
begin
  var Ex := ArgumentException(Assert.Catch(->raise new ArgumentException("Item", "Error")));
  Assert.IsNotNil(Ex);
  Assert.AreEqual(Ex.Argument, "Item"); 
  Assert.AreEqual(Ex.Message, "Error");
  Assert.Throws(->Assert.Catch(->Assert.AreEqual(true, true)));
  Assert.Throws(->Assert.Catch(nil), typeOf(ArgumentNilException));
end;

end.    