local this=
{
mapid=10101,born_group=100,
groups=
{
[100]={10401,10301},
[101]={10403,10204,10507},
[102]={10306,10209},
[103]={10608},
[104]={10309},
[105]={10108},
[106]={10406,10407,10408},
[107]={10305}
},
monsters=
{
{id=402011,born_pos=10404,wave=1},
{id=402012,born_pos=10308,wave=1},
{id=402013,born_pos=10203,wave=2},
{id=402011,born_pos=10507,wave=2},
{id=402014,born_pos=10608,wave=3}
},
props=
{
{born_pos=10509,wave=1,rate=100,nPropID=1,name="货箱",name_id=70010,icon="MapProps_001",desc="装着各种随机素材的箱子。",desc_id=71010,res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=105,wave=2,rate=100,nPropID=2,float_content="耐久+30%",float_content_id=72020,use_sound="ui_buff_attack",name="生命补给",name_id=70020,icon="图标名称",desc="基地投送的作战补给，获得后队伍全体耐久+30%。",desc_id=71020,res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_group=107,wave=1,rate=100,nPropID=3,name="线程闸",name_id=70110,icon="MapProps_011",desc="世界树的特殊物理后门，曾用作特殊情况下的造物回收。",desc_id=71110,res="GridProps/section2/1",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={4,5,6}},
{born_group=106,wave=1,rate=100,nPropID=4,name="屏蔽力场",name_id=70120,icon="MapProps_012",desc="世界树表面的特殊防护装置，激活状态下无法直接通过。",desc_id=71120,res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=106,wave=1,rate=100,nPropID=5,name="屏蔽力场",name_id=70120,icon="MapProps_012",desc="世界树表面的特殊防护装置，激活状态下无法直接通过。",desc_id=71120,res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=106,wave=1,rate=100,nPropID=6,name="屏蔽力场",name_id=70120,icon="MapProps_012",desc="世界树表面的特殊防护装置，激活状态下无法直接通过。",desc_id=71120,res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1}
},
}
return this;