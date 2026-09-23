local this=
{
mapid=1216,born_group=100,
groups=
{
[100]={10104,10106},
[101]={10305,10503,10408},
[104]={10807,10804},
[102]={10905},
[103]={10907},
[106]={10705},
[107]={10601,10501,10401},
[108]={10408,10407,10406,10405},
[109]={10608,10607,10606,10605},
[110]={10508,10507,10506,10505}
},
monsters=
{
{id=102161,born_pos=10305,wave=1},
{id=102162,born_pos=10408,wave=1},
{id=102162,born_pos=10503,wave=1},
{id=102163,born_pos=10604,wave=2},
{id=102162,born_pos=10807,wave=2},
{id=102164,born_group=102,wave=1},
{id=102165,born_pos=10402,nRelationID=1,wave=1},
{id=102165,born_pos=10602,nRelationID=2,wave=1}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=1,rate=100,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10001}},
{born_group=106,wave=1,rate=100,nPropID=3,float_content="HP+30%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_pos=10405,wave=1,rate=100,nPropID=4,name="岩石障碍",icon="MapProps_008",desc="碎星建筑残骸，队伍无法移动到上面。",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=1,damage=0},
{born_pos=10505,wave=1,rate=100,nPropID=5,name="岩石障碍",icon="MapProps_008",desc="碎星建筑残骸，队伍无法移动到上面。",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=1,damage=0},
{born_pos=10605,wave=1,rate=100,nPropID=6,name="岩石障碍",icon="MapProps_008",desc="碎星建筑残骸，队伍无法移动到上面。",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=1,damage=0},
{born_pos=10402,wave=1,rate=100,nPropID=7,nRelationID=1,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={2}},
{born_pos=10602,wave=1,rate=100,nPropID=8,nRelationID=2,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={2}},
{born_pos=10409,wave=1,rate=100,nPropID=9,angle=90,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =108,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_pos=10609,wave=1,rate=100,nPropID=10,angle=90,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =109,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_pos=10509,wave=1,rate=100,nPropID=11,angle=90,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =110,start_round=2,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_group=107,wave=1,rate=100,nPropID=12,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=13,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=14,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0}
},
}
return this;