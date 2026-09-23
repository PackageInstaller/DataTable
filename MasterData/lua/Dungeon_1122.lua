local this=
{
mapid=1122,born_group=100,
groups=
{
[100]={10103,10104},
[101]={10405,10202},
[104]={10504,10502},
[102]={10603},
[103]={10601},
[105]={10504,10404,10304,10204,10104},
[106]={10604}
},
monsters=
{
{id=101221,born_group=101,wave=1},
{id=101222,born_group=101,wave=1},
{id=101222,born_group=104,wave=2},
{id=101223,born_group=104,wave=2},
{id=101224,born_group=102,wave=3}
},
props=
{
{born_group=103,wave=3,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=3,rate=75,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}}
},
}
return this;