local this=
{
mapid=1109,born_group=101,
groups=
{
[101]={10102,10104},
[100]={10402,10504},
[102]={10503},
[103]={10303},
[104]={10103},
[105]={10204}
},
monsters=
{
{id=101091,born_group=100,wave=1},
{id=101091,born_group=100,wave=1},
{id=101093,born_group=104,wave=2},
{id=101094,born_group=102,wave=3}
},
props=
{
{born_group=103,wave=2,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=2,rate=75,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_group=105,wave=3,rate=100,nPropID=3,float_content="HP+50%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+50%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.5}}
},
}
return this;