﻿namespace EUnit.Tests;

interface

uses
  RemObjects.Elements.EUnit;

type
  SequenceAssertTest = public class (Test) 
  public
    method AreEqual;
    method AreNotEqual;
    method Contains;
    method DoesNotContains;
    method IsEmpty;
    method IsNotEmpty;
  end;

implementation

method SequenceAssertTest.AreEqual;
begin
  Assert.AreEqual<Integer>([1, 2, 3], [1, 2, 3]);
  var List := new Sugar.Collections.List<String>;
  List.Add("Hello");
  List.Add("World");
  Assert.AreEqual(["Hello", "World"], List);
  Assert.AreEqual<String>(nil, nil);
  Assert.AreEqual<CodeObject>([new CodeObject(1), new CodeObject(2)], [new CodeObject(1), new CodeObject(2)]);
  Assert.AreEqual<CodeObject>([new CodeObject(1), nil], [new CodeObject(1), nil]);

  Assert.Throws(->Assert.AreEqual<Integer>([1, 2, 3], [3, 2, 1]), typeOf(AssertException));
  Assert.AreEqual<Integer>([1, 2, 3], [3, 2, 1], true);

  var Expected: array of Byte := [1, 2, 3];
  Assert.AreEqual([1, 2, 3], Expected);

  Assert.Throws(->Assert.AreEqual<Integer>([0, 1, 2], [1, 2, 3]), typeOf(AssertException));
  Assert.Throws(->Assert.AreEqual<Integer>(nil, [1, 2, 3]), typeOf(AssertException));
  Assert.Throws(->Assert.AreEqual<Integer>([0, 1, 2], nil), typeOf(AssertException));
end;

method SequenceAssertTest.AreNotEqual;
begin
  Assert.AreNotEqual<Integer>([1, 2, 3], [0, 2, 3]);
  var List := new Sugar.Collections.List<String>;
  List.Add("Hello");
  List.Add("World"); 
  Assert.AreNotEqual(["World", "Hello"], List);
  Assert.AreNotEqual<Integer>([0, 1, 2], nil);
  Assert.AreNotEqual<Integer>(nil, [0, 1, 2]);
  Assert.AreNotEqual<Integer>([1, 2], [2, 1]);

  Assert.Throws(->Assert.AreNotEqual<Integer>([1, 2], [2, 1], true), typeOf(AssertException));
  Assert.Throws(->Assert.AreNotEqual<Integer>([1, 2, 3], [1, 2, 3]), typeOf(AssertException));
  Assert.Throws(->Assert.AreNotEqual<String>(nil, nil), typeOf(AssertException));
end;

method SequenceAssertTest.Contains;
begin
  Assert.Contains<Integer>(1, [2, 4, 1, 8]);
  var List := new Sugar.Collections.List<String>;
  List.AddRange(["Abc", "Bca", "Cab"]);
  Assert.Contains("Bca", List);

  List.Add(nil);
  Assert.Contains(nil, List);

  Assert.Throws(->Assert.Contains<String>("abc", nil), typeOf(ArgumentNilException));
  Assert.Throws(->Assert.Contains<String>("xyz", List), typeOf(AssertException));
  Assert.Throws(->Assert.Contains<Integer>(0, [1, 2, 3]), typeOf(AssertException));
end;

method SequenceAssertTest.DoesNotContains;
begin
  Assert.DoesNotContains<Integer>(1, [2, 3, 4]);
  var List := new Sugar.Collections.List<String>;
  List.AddRange(["Abc", "Bca", "Cab"]);
  Assert.DoesNotContains("xyz", List);
  Assert.DoesNotContains(nil, List);

  Assert.Throws(->Assert.DoesNotContains<Integer>(1, [1, 2, 3]), typeOf(AssertException));
  Assert.Throws(->Assert.DoesNotContains<String>("abc", nil), typeOf(ArgumentNilException));
end;

method SequenceAssertTest.IsEmpty;
begin
  Assert.IsEmpty<String>([]);
  var List := new Sugar.Collections.List<String>;
  List.AddRange(["Abc", "Bca", "Cab"]);
  Assert.Throws(->Assert.IsEmpty(List)); 
  List.Clear;
  Assert.IsEmpty(List);
  Assert.Throws(->Assert.IsEmpty(nil), typeOf(ArgumentNilException));
  Assert.Throws(->Assert.IsEmpty<Integer>([0]), typeOf(AssertException)); 
end;

method SequenceAssertTest.IsNotEmpty;
begin
  Assert.IsNotEmpty<String>(["Abc"]);
  var List := new Sugar.Collections.List<String>;  
  List.AddRange(["Abc", "Bca", "Cab"]);
  Assert.IsNotEmpty(List);  
  List.Clear;
  Assert.Throws(->Assert.IsNotEmpty(List), typeOf(AssertException));
  Assert.Throws(->Assert.IsNotEmpty(nil), typeOf(ArgumentNilException));
  Assert.Throws(->Assert.IsNotEmpty<Integer>([]), typeOf(AssertException)); 
end;

end.    