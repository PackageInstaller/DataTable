local this=
{
mapid=1211,born_group=100,
groups=
{
[100]={10103,10105},
[101]={10304,10401,10905},
[104]={10405,10704},
[102]={10804},
[103]={10807},
[107]={10603},
[105]={10502,10402,10302},
[108]={10404},
[109]={10906,10806,10706},
[110]={10501}
},
monsters=
{
{id=102111,born_pos=10403,wave=1},
{id=102112,born_pos=10401,wave=1},
{id=102113,born_pos=10905,nRelationID=1,wave=1},
{id=102112,born_group=104,wave=2},
{id=102112,born_group=104,wave=2},
{id=102114,born_group=102,wave=3}
},
props=
{
{born_pos=10905,wave=1,rate=100,nPropID=1,nRelationID=1,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=3,nChangeStep=0,dir={3}},
{born_group=103,wave=1,rate=100,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=1,rate=100,nPropID=3,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_group=107,wave=1,rate=100,nPropID=4,float_content="HP+50%",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+50%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.5}},
{born_group=108,wave=1,rate=100,nPropID=5,icon="图标名称",desc="未设置",res="GridProps/section2/1",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={8,7,6}},
{born_group=105,wave=1,rate=100,nPropID=6,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=105,wave=1,rate=100,nPropID=7,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=105,wave=1,rate=100,nPropID=8,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=110,wave=1,rate=100,nPropID=9,icon="图标名称",desc="未设置",res="GridProps/section2/2",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={10,11,12}},
{born_group=109,wave=1,rate=100,nPropID=10,desc="未设置",res="GridProps/section2/4",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=109,wave=1,rate=100,nPropID=11,desc="未设置",res="GridProps/section2/4",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=109,wave=1,rate=100,nPropID=12,desc="未设置",res="GridProps/section2/4",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1}
},
}
return this;