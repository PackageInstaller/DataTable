local this=
{
mapid=1207,born_group=100,
groups=
{
[100]={10301,10201},
[101]={10304,10804,10308},
[104]={10603},
[111]={10608},
[102]={10808},
[103]={10107},
[106]={10406},
[107]={10407},
[108]={10507},
[110]={10307},
[112]={10807}
},
monsters=
{
{id=102071,born_pos=10304,wave=1},
{id=102073,born_pos=10804,nRelationID=1,wave=1},
{id=102073,born_pos=10308,nRelationID=2,wave=1},
{id=102072,born_group=104,nRelationID=2,wave=2},
{id=102072,born_group=111,wave=3},
{id=102074,born_group=102,wave=4}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=1,rate=100,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_group=106,wave=1,rate=100,nPropID=3,float_content="HP+30%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_pos=10804,wave=1,rate=100,nPropID=4,nRelationID=1,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=3,nChangeStep=0,dir={3}},
{born_pos=10308,wave=1,rate=100,nPropID=5,nRelationID=2,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=3,nChangeStep=0,dir={4}},
{born_group=107,wave=1,rate=100,nPropID=6,icon="图标名称",desc="未设置",res="GridProps/section2/1",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={7}},
{born_group=108,wave=1,rate=100,nPropID=7,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=4,type=16,TriggerType=2,damage=1},
{born_group=112,wave=1,rate=100,nPropID=8,icon="图标名称",desc="未设置",res="GridProps/section2/2",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={9}},
{born_group=110,wave=1,rate=100,nPropID=9,desc="未设置",res="GridProps/section2/4",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1}
},
}
return this;