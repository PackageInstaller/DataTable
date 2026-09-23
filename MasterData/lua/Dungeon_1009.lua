local this=
{
mapid=1009,born_group=100,
groups=
{
[100]={10201},
[101]={10103,10405},
[102]={10304},
[103]={10106},
[104]={10205}
},
monsters=
{
{id=100091,born_pos=10103,wave=1},
{id=100092,born_pos=10405,wave=1},
{id=100094,born_group=103,wave=2}
},
props=
{
{born_group=104,wave=2,rate=100,nPropID=1,icon="MapProps_001",desc="一次性宝箱",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=104,wave=2,rate=75,nPropID=2,icon="MapProps_001",desc="二次宝箱",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}}
},
}
return this;