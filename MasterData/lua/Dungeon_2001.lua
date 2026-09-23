local this=
{
mapid=2001,born_group=100,
groups=
{
[101]={10202,10104},
[100]={10101},
[102]={10205},
[103]={10203}
},
monsters=
{
{id=200011,born_group=101,wave=1},
{id=200011,born_group=101,wave=1},
{id=200014,born_group=102,wave=2}
},
props=
{
{born_group=103,wave=2,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=2,rate=50,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}}
},
}
return this;