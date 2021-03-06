﻿namespace RemObjects.Elements.EUnit;

interface

type
  StringWriter = public class (BaseWriter)
  private
    Offset: Integer := 0;
    Builder: StringBuilder := new StringBuilder;

    method StringOffset: String;
    method StateToString(State: TestState): String;
  protected
    method WriteElement(Item: ITestResult); virtual;
    method WriteNode(Node: ITestResult; Filter: Predicate<ITestResult>); override;

    method WriteSuite(Item: ITestResult); override;
    method WriteTest(Item: ITestResult); override;
    method WriteTestcase(Item: ITestResult); override;
  public
    method WriteLine(Item: String); override;

    [ToString]
    method ToString: String; override;

    property Output: String read Builder.ToString;
  end;

implementation

method StringWriter.WriteSuite(Item: ITestResult);
begin
  WriteElement(Item);
  inc(Offset, 2);
end;

method StringWriter.WriteTest(Item: ITestResult);
begin
  WriteElement(Item);
  inc(Offset, 2);
end;

method StringWriter.WriteTestcase(Item: ITestResult);
begin
  WriteElement(Item);
end;

method StringWriter.WriteLine(Item: String);
begin
  if Item = nil then
    Item := "";

  Builder.AppendLine(Item);
end;

method StringWriter.WriteNode(Node: ITestResult; Filter: Predicate<ITestResult>);
begin
  if Node = nil then
    exit;

  inherited WriteNode(Node, Filter);

  if Node.Test.Kind <> TestKind.Testcase then
    dec(Offset, 2);
end;

method StringWriter.StringOffset: String;
begin
  if Offset <= 0 then
    exit "";

  exit new StringBuilder().Append(' ', Offset).ToString;
end;

method StringWriter.WriteElement(Item: ITestResult);
begin
  if Item.State = TestState.Succeeded then begin
    if ConsoleTestListener.EmitSuccessMessages then
      WriteLine(String.Format("{0}{1} State: {2}", StringOffset, Item.Name, StateToString(Item.State)))
  end
  else
    WriteLine(String.Format("{0}{1} State: {2} Message: {3}", StringOffset, Item.Name, StateToString(Item.State), Item.Message));
end;

method StringWriter.StateToString(State: TestState): String;
begin
  case State of
    TestState.Untested: exit "Untested";
    TestState.Skipped: exit "Skipped";
    TestState.Failed: exit "Failed";
    TestState.Succeeded: exit "Succeeded";
  end;
end;

method StringWriter.ToString: String;
begin
  exit Output;
end;

end.    