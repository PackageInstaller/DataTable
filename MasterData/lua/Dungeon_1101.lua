local this=
{
mapid=1101,born_group=100,
groups=
{
[101]={10303,10205},
[100]={10201,10102},
[102]={10405},
[103]={10105},
[104]={10401}
},
monsters=
{
{id=101011,born_group=101,wave=1},
{id=101011,born_group=101,wave=1},
{id=101012,born_group=104,wave=2},
{id=101014,born_group=102,wave=2}
},
props=
{
{born_group=103,wave=2,rate=100,nPropID=1,float_content="攻击+5%",name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=2,rate=75,nPropID=2,float_content="攻击+5%",name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}}
},
}
return this;