local this=
{
mapid=2008,born_group=100,
groups=
{
[100]={10301},
[101]={10203,10305},
[102]={10104},
[103]={10204},
[104]={10206}
},
monsters=
{
{id=200081,born_group=101,wave=1},
{id=200081,born_group=101,wave=1},
{id=200082,born_group=102,wave=2},
{id=200084,born_group=103,wave=3}
},
props=
{
{born_group=104,wave=2,rate=100,nPropID=1,float_content="攻击+10%",use_sound="ui_buff_attack",name="攻击补给",icon="MapProps_006",desc="基地投送的作战补给，获得后队伍全体攻击力+10%。",res="GridProps/buff/Buff_Attack",get_eff="get_eff_blue",eBlockState=1,nStep=0,state=1,type=13,param={4002}}
},
}
return this;