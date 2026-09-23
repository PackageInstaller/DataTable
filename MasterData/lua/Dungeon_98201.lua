local this=
{
mapid=98201,born_group=100,
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
{id=602011,born_pos=10401,wave=1},
{id=602012,born_pos=10601,wave=1},
{id=602014,born_group=102,wave=1},
{id=602011,born_pos=10405,wave=1},
{id=602012,born_pos=10605,wave=1}
},
props=
{
{born_pos=10303,wave=2,rate=100,nPropID=1,float_content="耐久+30%",use_sound="ui_buff_attack",name="耐久补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体耐久+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_group=106,wave=3,rate=100,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10008}}
},
}
return this;