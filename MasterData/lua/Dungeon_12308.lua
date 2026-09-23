local this=
{
mapid=12308,born_group=100,
groups=
{
[100]={10102,10104},
[101]={10302},
[102]={10603},
[103]={10304},
[104]={10402},
[105]={10404},
[106]={10403}
},
monsters=
{
{id=602082,born_pos=10405,wave=1},
{id=602083,born_pos=10502,wave=1},
{id=602084,born_group=102,wave=1},
{id=602081,born_pos=10401,wave=1},
{id=602085,born_pos=10504,wave=1}
},
props=
{
{born_pos=10302,wave=1,rate=100,nPropID=1,float_content="HP+100%",float_content_id=72023,use_sound="ui_buff_attack",name="耐久补给",name_id=70020,icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体耐久+100%。",desc_id=71023,res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={1}},
{born_pos=10304,wave=1,rate=100,nPropID=2,float_content="NP+50",float_content_id=72030,use_sound="ui_buff_attack",name="NP补给",name_id=70030,icon="MapProps_003",desc="基地投送的作战补给，获得后队伍NP+50。",desc_id=71030,res="GridProps/buff/Buff_NP",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=34,param={0.1},nNp=50}
},
}
return this;