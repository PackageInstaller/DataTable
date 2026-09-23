local this=
{
mapid=12504,born_group=100,
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
{id=603041,born_pos=10302,wave=1},
{id=603041,born_pos=10304,wave=1},
{id=603044,born_pos=10603,wave=1},
{id=603042,born_pos=10501,wave=1},
{id=603042,born_pos=10505,wave=1}
},
props=
{
{born_pos=10503,wave=1,rate=100,nPropID=1,float_content="防御+20%",float_content_id=72050,use_sound="ui_buff_attack",name="防御补给",name_id=70050,icon="MapProps_005",desc="基地投送的作战补给，获得后队伍下一次战斗全体防御+20%。",desc_id=71050,res="GridProps/buff/Buff_Shield",get_eff="get_eff_blue",eBlockState=1,nStep=0,state=1,type=13,param={4104},round=1}
},
}
return this;