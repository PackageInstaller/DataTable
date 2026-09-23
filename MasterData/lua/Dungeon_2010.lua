local this=
{
mapid=2010,born_group=100,
groups=
{
[100]={10201},
[101]={10302,10204},
[102]={10105},
[103]={10207},
[104]={10107},
[105]={10305}
},
monsters=
{
{id=200101,born_group=101,wave=1},
{id=200101,born_group=101,wave=1},
{id=200102,born_group=102,wave=2},
{id=200104,born_group=103,wave=3}
},
props=
{
{born_group=105,wave=3,rate=100,nPropID=1,icon="MapProps_001",desc="一次性宝箱",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=105,wave=3,rate=50,nPropID=2,icon="MapProps_001",desc="二次宝箱",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_group=105,wave=3,rate=75,nPropID=3,float_content="HP+30%",use_sound="ui_buff_attack",name="补给HP+30%",icon="MapProps_002",desc="加30%血",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}}
},
}
return this;