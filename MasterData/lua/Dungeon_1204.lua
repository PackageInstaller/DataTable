local this=
{
mapid=1204,born_group=109,
groups=
{
[101]={10503,10607,10308},
[103]={10407,10505},
[102]={10608},
[105]={10705},
[106]={10106},
[100]={10305,10306,10307},
[108]={10404},
[109]={10301,10501}
},
monsters=
{
{id=102042,born_pos=10504,wave=1},
{id=102043,born_pos=10606,nRelationID=1,wave=1},
{id=102043,born_pos=10308,nRelationID=2,wave=1},
{id=102042,born_pos=10206,wave=2},
{id=102041,born_pos=10407,wave=2},
{id=102044,born_group=102,wave=3}
},
props=
{
{born_group=106,wave=1,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=106,wave=1,rate=100,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_group=105,wave=1,rate=100,nPropID=3,float_content="HP+50%",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+50%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.5}},
{born_pos=10606,wave=1,rate=100,nPropID=4,nRelationID=1,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=3,nChangeStep=0,dir={4}},
{born_pos=10308,wave=1,rate=100,nPropID=5,nRelationID=2,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=3,nChangeStep=0,dir={4}},
{born_group=108,wave=1,rate=100,nPropID=6,icon="图标名称",desc="未设置",res="GridProps/section2/1",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={7,8,9}},
{born_group=100,wave=1,rate=100,nPropID=7,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=100,wave=1,rate=100,nPropID=8,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=100,wave=1,rate=100,nPropID=9,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1}
},
}
return this;