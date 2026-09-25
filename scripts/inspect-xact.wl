Print["=== Wolfram / xAct inspection ==="];
Print["Version: ", $Version];
Print["FrontEnd: ", ToString[$FrontEnd, InputForm]];
redact[value_] := StringReplace[
  ToString[value, InputForm],
  {ToString[$UserBaseDirectory] -> "<USER_BASE>", ToString[$HomeDirectory] -> "<HOME>"}
];
Print["xAct paths: ", redact[Select[$Path, StringContainsQ[#, "xAct", IgnoreCase -> True] &]]];

packages = {
  {"xAct`xTensor`", "xAct`xTensor`$Version", {"xAct`xTensor`DefManifold", "xAct`xTensor`DefMetric", "xAct`xTensor`DefTensor", "xAct`xTensor`ToCanonical", "xAct`xTensor`ContractMetric"}, "xCore, xPerm"},
  {"xAct`xCoba`", "xAct`xCoba`$Version", {"xAct`xCoba`DefChart", "xAct`xCoba`CTensor", "xAct`xCoba`ComponentArray", "xAct`xCoba`ToValues", "xAct`xCoba`MetricCompute", "xAct`xCoba`TensorValues"}, "xTensor, xPerm, xCore, ExpressionManipulation"},
  {"xAct`xPert`", "xAct`xPert`$Version", {"xAct`xPert`DefMetricPerturbation", "xAct`xPert`Perturbed", "xAct`xPert`ExpandPerturbation"}, "xTensor, xPerm, xCore, ExpressionManipulation"},
  {"xAct`xTras`", "xAct`xTras`$Version", {"xAct`xTensor`VarD", "xAct`xTras`VarL", "xAct`xTras`CollectTensors"}, "xTensor, xPert, xCoba, Invar, SymManipulator (observed in the compatibility baseline)"}
};

scanPackage[{context_, versionName_, symbols_, dependencies_}] := Module[{before, loadClean, loaded, messages, version, file, contexts},
  Print["\n--- ", context, " ---"];
  before = Length[$MessageList];
  loadClean = Check[Needs[context]; True, False];
  messages = Drop[$MessageList, before];
  file = FindFile[context];
  loaded = StringQ[file] && NameQ[versionName];
  version = If[NameQ[versionName], ToExpression[versionName], Missing["NotAvailable"]];
  contexts = Select[Contexts[], StringStartsQ[#, context] &];
  Print["loaded: ", loaded, "; load without messages: ", loadClean, "; package file: ", redact[file]];
  Print["version/release: ", version];
  Print["contexts: ", contexts];
  Print["declared dependencies (local package source): ", dependencies];
  Print["required symbols:"];
  Scan[Function[name, Print["  ", name, " exists=", NameQ[name], " context=", StringReplace[name, RegularExpression["[^`]+$"] -> ""]]], symbols];
  Print["messages: ", If[messages === {}, "none", messages]];
];
Scan[scanPackage, packages];
Print["\nEngine-only status: this script uses no FrontEnd operation; $FrontEnd above records availability."];
Exit[];
