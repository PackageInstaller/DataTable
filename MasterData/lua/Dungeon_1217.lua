local this=
{
mapid=1217,born_group=101,
groups=
{
[101]={10101,10401},
[100]={10302,10109,10405,10207},
[104]={10103,10109},
[102]={10210},
[103]={10508},
[105]={10208},
[108]={10504,10404},
[111]={10303},
[113]={10503,10403,10303,10203},
[114]={10309,10308,10307,10306},
[115]={10109,10108,10107,10106},
[106]={10407,10408},
[107]={10506}
},
monsters=
{
{id=102171,born_pos=10302,wave=1},
{id=102173,born_pos=10207,nRelationID=1,wave=1},
{id=102172,born_pos=10405,wave=1},
{id=102172,born_group=104,wave=2},
{id=102172,born_group=104,wave=2},
{id=102174,born_group=102,wave=3}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=1,rate=100,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10001}},
{born_group=105,wave=1,rate=100,nPropID=3,float_content="HP+30%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_pos=10207,wave=1,rate=100,nPropID=4,nRelationID=1,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=3,nChangeStep=0,dir={4}},
{born_group=111,wave=1,rate=100,nPropID=5,icon="图标名称",desc="未设置",res="GridProps/section2/1",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={6,7}},
{born_group=108,wave=1,rate=100,nPropID=6,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=108,wave=1,rate=100,nPropID=7,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=107,wave=1,rate=100,nPropID=8,icon="图标名称",desc="未设置",res="GridProps/section2/2",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={9,10}},
{born_group=106,wave=1,rate=100,nPropID=9,desc="未设置",res="GridProps/section2/4",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=106,wave=1,rate=100,nPropID=10,desc="未设置",res="GridProps/section2/4",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_pos=10603,wave=1,rate=100,nPropID=11,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =113,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_pos=10310,wave=1,rate=100,nPropID=12,angle=90,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =114,start_round=2,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_pos=10110,wave=1,rate=100,nPropID=13,angle=90,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =115,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999}
},
}
return this;