local this=
{
mapid=121306,born_group=100,
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
{id=606061,born_pos=10302,wave=1},
{id=606061,born_pos=10304,wave=1},
{id=606063,born_pos=10603,wave=1},
{id=606062,born_pos=10505,wave=1},
{id=606062,born_pos=10501,wave=1}
},
props=
{
{born_pos=10401,wave=1,rate=100,nPropID=1,float_content="攻击+20%",float_content_id=72061,use_sound="ui_buff_attack",name="攻击补给",name_id=70060,icon="MapProps_006",desc="基地投送的作战补给，获得后队伍下一次战斗攻击力+20%。",desc_id=71061,res="GridProps/buff/Buff_Attack",get_eff="get_eff_blue",eBlockState=1,nStep=0,state=1,type=13,param={4004},round=1},
{born_pos=10405,wave=1,rate=100,nPropID=2,float_content="HP+50%",use_sound="ui_buff_attack",name="耐久补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体耐久+50%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.5}}
},
}
return this;