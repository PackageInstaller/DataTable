local this=
{
mapid=10102,born_group=100,
groups=
{
[100]={10401,10402},
[101]={10702,10606,10306},
[104]={10803,10705},
[102]={10806},
[103]={10105},
[106]={10404},
[110]={10305},
[112]={10704}
},
monsters=
{
{id=402021,born_pos=10702,wave=1},
{id=402023,born_pos=10505,wave=1},
{id=402022,born_pos=10804,wave=2},
{id=402021,born_pos=10705,wave=2},
{id=402024,born_pos=10806,wave=3}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",name_id=70010,icon="MapProps_001",desc="装着各种随机素材的箱子。",desc_id=71010,res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_pos=10306,wave=2,rate=100,nPropID=2,float_content="耐久+30%",float_content_id=72020,use_sound="ui_buff_attack",name="生命补给",name_id=70020,icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体耐久+50%。",desc_id=72020,res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_pos=10404,wave=1,rate=100,nPropID=3,name="线程闸",name_id=70110,icon="MapProps_011",desc="世界树的特殊物理后门，曾用作特殊情况下的造物回收。",res="GridProps/section2/1",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={4}},
{born_group=110,wave=1,rate=100,nPropID=4,name="屏蔽力场",name_id=70120,icon="MapProps_012",desc="世界树表面的特殊防护装置，激活状态下无法直接通过。",desc_id=71120,res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1}
},
}
return this;