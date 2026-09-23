local this=
{
mapid=1222,born_group=100,
groups=
{
[100]={10301,10202},
[101]={10403,10607,10705},
[104]={10803,10405},
[102]={10908},
[103]={10704},
[106]={10808},
[107]={11006,10801,10104,10308},
[108]={10803,10703,10603,10503},
[109]={10502,10503,10504,10505},
[112]={10306,10406,10506,10606},
[113]={10607,10606,10605,10604}
},
monsters=
{
{id=102224,born_group=102,wave=3},
{id=102221,born_pos=10403,wave=1},
{id=102222,born_pos=10607,wave=1},
{id=102222,born_pos=10705,wave=1},
{id=102221,born_pos=10407,wave=2},
{id=102222,born_pos=10405,wave=2},
{id=102225,born_pos=10802,nRelationID=1,wave=1},
{id=102225,born_pos=10204,nRelationID=2,wave=1},
{id=102225,born_pos=10906,nRelationID=3,wave=1},
{id=102225,born_pos=10307,nRelationID=4,wave=1}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=1,rate=100,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_group=106,wave=1,rate=100,nPropID=3,float_content="HP+30%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_pos=10802,wave=1,rate=100,nPropID=4,nRelationID=1,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={2}},
{born_pos=10204,wave=1,rate=100,nPropID=5,nRelationID=2,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={1}},
{born_pos=10906,wave=1,rate=100,nPropID=6,nRelationID=3,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={3}},
{born_pos=10307,wave=1,rate=100,nPropID=7,nRelationID=4,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={4}},
{born_group=107,wave=1,rate=100,nPropID=8,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=9,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=10,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=11,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_pos=10903,wave=1,rate=100,nPropID=12,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =108,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_pos=10501,wave=1,rate=100,nPropID=13,angle=270,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =109,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_pos=10206,wave=1,rate=100,nPropID=14,angle=180,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =112,start_round=2,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_pos=10608,wave=1,rate=100,nPropID=15,angle=90,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =113,start_round=2,interval_round  =3,damage=0.09999999,collide_damage=0.09999999}
},
}
return this;