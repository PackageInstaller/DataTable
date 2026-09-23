local this=
{
mapid=2121,born_group=100,
groups=
{
[100]={10102,10105},
[101]={10301,10306},
[104]={10502,10404},
[102]={10602},
[103]={10506},
[105]={10503,10403,10303,10203,10103},
[106]={10603}
},
monsters=
{
{id=201211,born_group=101,wave=1},
{id=201212,born_group=101,wave=1},
{id=201212,born_group=104,wave=2},
{id=201211,born_group=104,wave=2},
{id=201214,born_group=102,wave=3}
},
props=
{
{born_group=103,wave=2,rate=100,nPropID=1,flip=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=2,rate=75,nPropID=2,flip=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}}
},
}
return this;