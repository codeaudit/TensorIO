ã)
¸
:
Add
x"T
y"T
z"T"
Ttype:
2	
x
Assign
ref"T

value"T

output_ref"T"	
Ttype"
validate_shapebool("
use_lockingbool(
8
Const
output"dtype"
valuetensor"
dtypetype
.
Identity

input"T
output"T"	
Ttype
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
H
ShardedFilename
basename	
shard

num_shards
filename
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
s

VariableV2
ref"dtype"
shapeshape"
dtypetype"
	containerstring "
shared_namestring "serve*1.9.02v1.9.0-0-g25c197e023Ú
X
input_xPlaceholder*
shape
:*
dtype0*
_output_shapes

:
p
w/initial_valueConst*)
value B"  ?      ?    *
dtype0*
_output_shapes

:
u
w
VariableV2*
dtype0*
	container *
_output_shapes

:*
shape
:*
shared_name 

w/AssignAssignww/initial_value*
use_locking(*
T0*
_class

loc:@w*
validate_shape(*
_output_shapes

:
T
w/readIdentityw*
_output_shapes

:*
T0*
_class

loc:@w
I
output_zAddinput_xw/read*
T0*
_output_shapes

:

initNoOp	^w/Assign
P

save/ConstConst*
valueB Bmodel*
dtype0*
_output_shapes
: 
b
save/SaveV2/tensor_namesConst*
dtype0*
_output_shapes
:*
valueBBw
e
save/SaveV2/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
m
save/SaveV2SaveV2
save/Constsave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesw*
dtypes
2
}
save/control_dependencyIdentity
save/Const^save/SaveV2*
T0*
_class
loc:@save/Const*
_output_shapes
: 
e
save/RestoreV2/tensor_namesConst*
valueBBw*
dtype0*
_output_shapes
:
h
save/RestoreV2/shape_and_slicesConst*
dtype0*
_output_shapes
:*
valueB
B 

save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices*
_output_shapes
:*
dtypes
2

save/AssignAssignwsave/RestoreV2*
use_locking(*
T0*
_class

loc:@w*
validate_shape(*
_output_shapes

:
&
save/restore_allNoOp^save/Assign
R
save_1/ConstConst*
dtype0*
_output_shapes
: *
valueB Bmodel

save_1/StringJoin/inputs_1Const*<
value3B1 B+_temp_fb1d8a1b695e4d70b62c83ca498ee4c0/part*
dtype0*
_output_shapes
: 
{
save_1/StringJoin
StringJoinsave_1/Constsave_1/StringJoin/inputs_1*
N*
_output_shapes
: *
	separator 
S
save_1/num_shardsConst*
value	B :*
dtype0*
_output_shapes
: 
^
save_1/ShardedFilename/shardConst*
dtype0*
_output_shapes
: *
value	B : 

save_1/ShardedFilenameShardedFilenamesave_1/StringJoinsave_1/ShardedFilename/shardsave_1/num_shards*
_output_shapes
: 
d
save_1/SaveV2/tensor_namesConst*
dtype0*
_output_shapes
:*
valueBBw
g
save_1/SaveV2/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save_1/SaveV2SaveV2save_1/ShardedFilenamesave_1/SaveV2/tensor_namessave_1/SaveV2/shape_and_slicesw*
dtypes
2

save_1/control_dependencyIdentitysave_1/ShardedFilename^save_1/SaveV2*
T0*)
_class
loc:@save_1/ShardedFilename*
_output_shapes
: 
£
-save_1/MergeV2Checkpoints/checkpoint_prefixesPacksave_1/ShardedFilename^save_1/control_dependency*
T0*

axis *
N*
_output_shapes
:

save_1/MergeV2CheckpointsMergeV2Checkpoints-save_1/MergeV2Checkpoints/checkpoint_prefixessave_1/Const*
delete_old_dirs(

save_1/IdentityIdentitysave_1/Const^save_1/MergeV2Checkpoints^save_1/control_dependency*
T0*
_output_shapes
: 
g
save_1/RestoreV2/tensor_namesConst*
dtype0*
_output_shapes
:*
valueBBw
j
!save_1/RestoreV2/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:

save_1/RestoreV2	RestoreV2save_1/Constsave_1/RestoreV2/tensor_names!save_1/RestoreV2/shape_and_slices*
_output_shapes
:*
dtypes
2

save_1/AssignAssignwsave_1/RestoreV2*
use_locking(*
T0*
_class

loc:@w*
validate_shape(*
_output_shapes

:
,
save_1/restore_shardNoOp^save_1/Assign
1
save_1/restore_allNoOp^save_1/restore_shard "B
save_1/Const:0save_1/Identity:0save_1/restore_all (5 @F8"I
trainable_variables20
.
w:0w/Assignw/read:02w/initial_value:08"?
	variables20
.
w:0w/Assignw/read:02w/initial_value:08*y
serving_defaultf
"
input_x
	input_x:0$
output_z

output_z:0tensorflow/serving/predict