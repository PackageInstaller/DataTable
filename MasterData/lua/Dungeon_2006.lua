local this=
{
mapid=2006,born_group=100,
groups=
{
[100]={10201},
[101]={10304,10104},
[102]={10206},
[104]={10207},
[103]={10405},
[105]={10404}
},
monsters=
{
{id=200061,born_group=101,wave=1},
{id=200061,born_group=101,wave=1},
{id=200062,born_group=102,wave=2},
{id=200064,born_group=103,wave=3}
},
props=
{
{born_group=104,wave=2,rate=80,nPropID=1,float_content="HP+30%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_group=105,wave=3,rate=100,nPropID=2,float_content="HP+20%",name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=105,wave=3,rate=50,nPropID=3,float_content="HP+20%",name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}}
},
}
return this;