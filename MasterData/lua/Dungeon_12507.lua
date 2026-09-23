local this=
{
mapid=12507,born_group=100,
groups=
{
[100]={10101,10105},
[101]={10302},
[102]={10603},
[103]={10304},
[104]={10402},
[105]={10404},
[106]={10403}
},
monsters=
{
{id=603073,born_pos=10603,wave=1},
{id=603071,born_pos=10302,wave=1},
{id=603072,born_pos=10501,wave=1},
{id=603071,born_pos=10304,wave=1},
{id=603072,born_pos=10505,wave=1}
},
props=
{
{born_pos=10503,wave=1,rate=100,nPropID=1,float_content="NP+50",float_content_id=72030,use_sound="ui_buff_attack",name="NP补给",name_id=70030,icon="MapProps_003",desc="基地投送的作战补给，获得后队伍NP+50。",desc_id=71030,res="GridProps/buff/Buff_NP",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=34,param={0.1},nNp=50}
},
}
return this;