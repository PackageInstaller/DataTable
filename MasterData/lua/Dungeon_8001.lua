local this=
{
mapid=8001,born_group=100,
groups=
{
[100]={10101},
[102]={10105}
},
monsters=
{
{id=800011,born_group=102,wave=1}
},
props=
{
{born_pos=10103,wave=1,rate=100,nPropID=1,float_content="NP+50",use_sound="ui_buff_attack",name="NP补给",icon="MapProps_003",desc="基地投送的作战补给，获得后队伍NP+50。",res="GridProps/buff/Buff_NP",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=34,param={0.1},nNp=50}
},
}
return this;