local this=
{
mapid=1102,born_group=100,
groups=
{
[101]={10302,10304},
[100]={10102,10104},
[102]={10404},
[103]={10401},
[104]={10403}
},
monsters=
{
{id=101021,born_group=101,wave=1},
{id=101021,born_group=101,wave=1},
{id=101022,born_group=104,wave=2},
{id=101024,born_group=102,wave=3}
},
props=
{
{born_group=103,wave=2,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=2,rate=75,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}}
},
}
return this;