local this=
{
mapid=1008,born_group=100,
groups=
{
[100]={10201},
[101]={10303,10103},
[102]={10204},
[103]={10206},
[104]={10105},
[105]={10405}
},
monsters=
{
{id=100081,born_pos=10104,wave=1},
{id=100082,born_pos=10405,wave=1},
{id=100084,born_pos=10207,wave=2}
},
props=
{
{born_pos=10404,wave=2,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_pos=10404,wave=2,rate=100,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_pos=10105,wave=2,rate=100,nPropID=3,float_content="HP+30%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}}
},
}
return this;