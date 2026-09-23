local this=
{
mapid=1007,born_group=100,
groups=
{
[100]={10201},
[101]={10302,10103},
[102]={10304},
[103]={10107},
[104]={10204}
},
monsters=
{
{id=100071,born_pos=10203,wave=1},
{id=100072,born_pos=10405,wave=1},
{id=100074,born_group=103,wave=2}
},
props=
{
{born_pos=10205,wave=2,rate=75,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_pos=10205,wave=2,rate=100,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}}
},
}
return this;