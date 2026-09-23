local this=
{
mapid=1125,born_group=100,
groups=
{
[100]={10106,10101},
[101]={10302,10305},
[104]={10402,10504},
[102]={10603},
[103]={10405},
[105]={10606}
},
monsters=
{
{id=101251,born_group=101,wave=1},
{id=101252,born_group=101,wave=1},
{id=101252,born_group=104,wave=2},
{id=101253,born_group=104,wave=2},
{id=101254,born_group=102,wave=3}
},
props=
{
{born_group=103,wave=2,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=2,rate=75,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_group=105,wave=3,rate=100,nPropID=3,float_content="HP+50%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+50%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.5}}
},
}
return this;