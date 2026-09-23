local this=
{
mapid=1202,born_group=100,
groups=
{
[100]={10401,10301},
[101]={10403,10204,10507},
[102]={10306,10209},
[103]={10608},
[104]={10308},
[105]={10108},
[106]={10406,10407,10408},
[107]={10305}
},
monsters=
{
{id=102021,born_pos=10403,wave=1},
{id=102022,born_pos=10204,wave=1},
{id=102022,born_pos=10507,wave=1},
{id=102021,born_pos=10306,wave=2},
{id=102023,born_pos=10208,wave=2},
{id=102024,born_group=104,wave=3}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=1,rate=75,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_group=105,wave=1,rate=100,nPropID=3,float_content="HP+30%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_group=107,wave=1,rate=100,nPropID=4,icon="图标名称",desc="未设置",res="GridProps/section2/1",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={7,6,5}},
{born_group=106,wave=1,rate=100,nPropID=5,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=0.09999999},
{born_group=106,wave=1,rate=100,nPropID=6,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=0.09999999},
{born_group=106,wave=1,rate=100,nPropID=7,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=0.09999999}
},
}
return this;