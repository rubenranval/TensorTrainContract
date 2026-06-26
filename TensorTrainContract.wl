(* ::Package:: *)

(* Title: TensorTrainContract *)
(* Author: Ruben Ranval *)
(* Summary:
     Contract a tensor train (TT) of low-rank cores back into the dense multidimensional array it represents. Reverse operation of TensorTrainDecomposition. *)
(* Version: 1.0.0 *)

(* Note: Also available as an isntant add-on function on https://resources.wolframcloud.com/FunctionRepository/resources/TensorTrainContract/ *)

BeginPackage["TensorTrainContract`"];


(* ::Section:: *)
(*Usage*)


TensorTrainContract::usage =
  "TensorTrainContract[{A1,A2\[Ellipsis],An}] contracts the tensor train formed by the rank-3 cores list {A1,A2\[Ellipsis],An} back into the dense array it represents.";


Begin["`Private`"];


(* ::Section:: *)
(*Messages*)


TensorTrainContract::notcores="Input must be a nonempty list of rank-3 arrays (tensor-train cores).";
TensorTrainContract::badbond="Adjacent cores have mismatched bond dimensions.";
TensorTrainContract::badboundary="The first and last cores must have boundary bond dimension 1.";


(* ::Section:: *)
(*Definition*)


TensorTrainContract[cores:{__?(ArrayQ[#,3]&)}]:=
Module[{dims=Dimensions/@cores},
Which[!AllTrue[Partition[dims,2,1],#[[1,3]]===#[[2,1]]&],
Message[TensorTrainContract::badbond];$Failed,
dims[[1,1]]=!=1||dims[[-1,-1]]=!=1,
Message[TensorTrainContract::badboundary];$Failed,
True,ArrayReshape[Fold[Dot,cores],dims[[All,2]]]]];

TensorTrainContract[___]:=(Message[TensorTrainContract::notcores];$Failed);


End[];
EndPackage[];
