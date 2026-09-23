local this=
{
mapid=1206,born_group=100,
groups=
{
[100]={10104,10106},
[101]={10605,10304,10306},
[104]={10508,10502},
[102]={10805},
[103]={10706},
[107]={10704},
[109]={10703},
[110]={10707},
[111]={10603,10503,10403,10303},
[112]={10607,10507,10407,10307}
},
monsters=
{
{id=102061,born_pos=10304,wave=1},
{id=102062,born_pos=10605,wave=1},
{id=102062,born_pos=10306,wave=1},
{id=102063,born_pos=10602,nRelationID=1,wave=1},
{id=102063,born_pos=10608,nRelationID=2,wave=1},
{id=102064,born_group=102,wave=1}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=1,rate=100,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_group=107,wave=1,rate=100,nPropID=3,float_content="HP+50%",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+50%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.5}},
{born_pos=10602,wave=1,rate=100,nPropID=4,nRelationID=1,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=3,nChangeStep=0,dir={3}},
{born_pos=10608,wave=1,rate=100,nPropID=5,nRelationID=2,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=3,nChangeStep=0,dir={3}},
{born_group=109,wave=1,rate=100,nPropID=6,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =111,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_group=110,wave=1,rate=100,nPropID=7,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =112,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999}
},
}
return this;