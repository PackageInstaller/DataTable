local this=
{
mapid=15010105,born_group=101,
groups=
{
[101]={10104},
[102]={10707,10607,10507,10407,10307,10207,10206,10205,10203,10202,10201,10301,10401,10501,10601,10701,10702,10602,10502,10402,10302,10303,10403,10503,10603,10703,10704,10604,10404,10304,10705,10605,10505,10305,10405,10306,10406,10506,10606,10706,10504,10204,10101,10102,10103,10105,10106,10107}
},
monsters=
{
{id=604083,born_group=102,wave=1}
},
props=
{
{born_pos=10403,wave=1,rate=100,nPropID=1,float_content="HP+100%",use_sound="ui_buff_attack",name="耐久补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体耐久+100%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={1}},
{born_pos=10407,wave=1,rate=100,nPropID=2,float_content="NP+50",use_sound="ui_buff_attack",name="NP补给",icon="MapProps_003",desc="基地投送的作战补给，获得后队伍NP+50。",res="GridProps/buff/Buff_NP",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=34,param={0.1},nNp=50}
},
}
return this;