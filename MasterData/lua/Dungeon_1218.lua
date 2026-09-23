local this=
{
mapid=1218,born_group=101,
groups=
{
[101]={10105,10107},
[100]={10305,10704,10506},
[104]={10607,10503},
[102]={10601},
[103]={10203},
[105]={10401},
[107]={10104,10204},
[109]={10302,10303},
[111]={10405},
[112]={10102},
[113]={10206,10306,10406,10506},
[114]={10602,10502,10402,10302}
},
monsters=
{
{id=102182,born_pos=10506,wave=1},
{id=102181,born_pos=10305,wave=1},
{id=102183,born_pos=10704,nRelationID=1,wave=1},
{id=102181,born_group=104,wave=2},
{id=102182,born_group=104,wave=2},
{id=102184,born_group=102,wave=3}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=1,rate=100,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10001}},
{born_group=105,wave=1,rate=100,nPropID=3,float_content="HP+50%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+50%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.5}},
{born_pos=10704,wave=1,rate=100,nPropID=4,nRelationID=1,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={3}},
{born_group=111,wave=1,rate=100,nPropID=5,icon="图标名称",desc="未设置",res="GridProps/section2/1",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={6,7}},
{born_group=107,wave=1,rate=100,nPropID=6,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=107,wave=1,rate=100,nPropID=7,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=112,wave=1,rate=100,nPropID=8,icon="图标名称",desc="未设置",res="GridProps/section2/2",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={9,10}},
{born_group=109,wave=1,rate=100,nPropID=9,desc="未设置",res="GridProps/section2/4",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=109,wave=1,rate=100,nPropID=10,desc="未设置",res="GridProps/section2/4",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_pos=10106,wave=1,rate=100,nPropID=11,angle=180,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =113,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_pos=10702,wave=1,rate=100,nPropID=12,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =114,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999}
},
}
return this;