
X
input_xPlaceholder*
dtype0*
_output_shapes

:*
shape
:
X
input_yPlaceholder*
shape
:*
dtype0*
_output_shapes

:
B
wConst*)
value B"  �?      �?    *
dtype0
T
w/readIdentityw*
_output_shapes

:*
T0*
_class

loc:@w
B
bConst*)
value B"      �?      �?*
dtype0
T
b/readIdentityb*
T0*
_class

loc:@b*
_output_shapes

:
?
transpose/RankRankw/read*
_output_shapes
: *
T0
Q
transpose/sub/yConst*
value	B :*
dtype0*
_output_shapes
: 
V
transpose/subSubtranspose/Ranktranspose/sub/y*
_output_shapes
: *
T0
W
transpose/Range/startConst*
dtype0*
_output_shapes
: *
value	B : 
W
transpose/Range/deltaConst*
value	B :*
dtype0*
_output_shapes
: 
~
transpose/RangeRangetranspose/Range/starttranspose/Ranktranspose/Range/delta*
_output_shapes
:*

Tidx0
[
transpose/sub_1Subtranspose/subtranspose/Range*
T0*
_output_shapes
:
e
	transpose	Transposew/readtranspose/sub_1*
T0*
_output_shapes

:*
Tperm0
s
MatMulMatMulinput_x	transpose*
_output_shapes

:*
transpose_a( *
transpose_b( *
T0
A
transpose_1/RankRankb/read*
T0*
_output_shapes
: 
S
transpose_1/sub/yConst*
value	B :*
dtype0*
_output_shapes
: 
\
transpose_1/subSubtranspose_1/Ranktranspose_1/sub/y*
T0*
_output_shapes
: 
Y
transpose_1/Range/startConst*
value	B : *
dtype0*
_output_shapes
: 
Y
transpose_1/Range/deltaConst*
value	B :*
dtype0*
_output_shapes
: 
�
transpose_1/RangeRangetranspose_1/Range/starttranspose_1/Ranktranspose_1/Range/delta*

Tidx0*
_output_shapes
:
a
transpose_1/sub_1Subtranspose_1/subtranspose_1/Range*
T0*
_output_shapes
:
i
transpose_1	Transposeb/readtranspose_1/sub_1*
T0*
_output_shapes

:*
Tperm0
w
MatMul_1MatMulinput_ytranspose_1*
_output_shapes

:*
transpose_a( *
transpose_b( *
T0
J
output_zMulMatMulMatMul_1*
T0*
_output_shapes

:
J
output_sAddMatMulMatMul_1*
T0*
_output_shapes

: 