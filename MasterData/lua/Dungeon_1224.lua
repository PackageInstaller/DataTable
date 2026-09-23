local this=
{
mapid=1224,born_group=101,
groups=
{
[101]={10206,10306},
[100]={10303,10602,10907},
[104]={10904,10602},
[102]={10608},
[103]={10808},
[105]={10802},
[108]={10708,10707,10706},
[109]={10605,10505},
[112]={10404},
[106]={10906,10806,10706,10606},
[110]={10402,10403,10404},
[111]={10203,10303,10403,10503},
[113]={10702,10703,10704}
},
monsters=
{
{id=102244,born_group=102,wave=3},
{id=102241,born_pos=10303,wave=1},
{id=102242,born_pos=10602,wave=1},
{id=102243,born_pos=10907,nRelationID=1,wave=1},
{id=102242,born_pos=10904,wave=2},
{id=102242,born_pos=10507,wave=2}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=1,rate=100,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10001}},
{born_group=105,wave=1,rate=100,nPropID=3,float_content="HP+30%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_pos=10907,wave=1,rate=100,nPropID=4,nRelationID=1,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=3,nChangeStep=0,dir={3}},
{born_group=112,wave=1,rate=100,nPropID=5,icon="图标名称",desc="未设置",res="GridProps/section2/1",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={6,7,8,9,10}},
{born_group=109,wave=1,rate=100,nPropID=6,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=109,wave=1,rate=100,nPropID=7,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=108,wave=1,rate=100,nPropID=8,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=4,type=16,TriggerType=2,damage=1},
{born_group=108,wave=1,rate=100,nPropID=9,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=4,type=16,TriggerType=2,damage=1},
{born_group=108,wave=1,rate=100,nPropID=10,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=4,type=16,TriggerType=2,damage=1},
{born_pos=11006,wave=1,rate=100,nPropID=11,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =106,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_pos=10401,wave=1,rate=100,nPropID=12,angle=270,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =110,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_pos=10103,wave=1,rate=100,nPropID=13,angle=180,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =111,start_round=2,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_pos=10701,wave=1,rate=100,nPropID=14,angle=270,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =113,start_round=2,interval_round  =3,damage=0.09999999,collide_damage=0.09999999}
},
}
return this;