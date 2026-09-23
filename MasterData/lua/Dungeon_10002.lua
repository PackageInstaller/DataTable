local this=
{
mapid=10002,born_group=101,
groups=
{
[101]={10104,10205},
[100]={10503,10301},
[102]={10501},
[103]={10303},
[104]={10103},
[105]={10204}
},
monsters=
{
{id=401021,born_group=100,wave=1},
{id=401022,born_group=100,wave=1},
{id=401023,born_group=104,wave=2},
{id=401024,born_group=102,wave=3}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",name_id=70010,icon="MapProps_001",desc="装着各种随机素材的箱子。",desc_id=71010,res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=105,wave=3,rate=100,nPropID=2,float_content="耐久+30%",float_content_id=72020,use_sound="ui_buff_attack",name="生命补给",name_id=70020,icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体耐久+30%。",desc_id=71020,res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}}
},
}
return this;