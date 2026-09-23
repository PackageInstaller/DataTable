local this=
{
mapid=2005,born_group=100,
groups=
{
[100]={10105},
[101]={10204,10405},
[102]={10403},
[104]={10502},
[103]={10505}
},
monsters=
{
{id=200051,born_group=101,wave=1},
{id=200051,born_group=101,wave=1},
{id=200052,born_group=102,wave=2},
{id=200054,born_group=103,wave=3}
},
props=
{
{born_group=104,wave=2,rate=100,nPropID=1,float_content="HP+30%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}}
},
}
return this;