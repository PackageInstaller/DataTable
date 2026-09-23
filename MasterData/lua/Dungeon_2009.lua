local this=
{
mapid=2009,born_group=100,
groups=
{
[100]={10201},
[101]={10203,10305},
[102]={10107},
[103]={10404},
[104]={10104},
[105]={10307}
},
monsters=
{
{id=200091,born_group=101,wave=1},
{id=200091,born_group=101,wave=1},
{id=200092,born_group=102,wave=2},
{id=200094,born_group=103,wave=3}
},
props=
{
{born_group=104,wave=2,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=104,wave=2,rate=50,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}}
},
}
return this;