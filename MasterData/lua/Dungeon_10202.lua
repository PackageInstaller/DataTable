local this=
{
mapid=10202,born_group=101,
groups=
{
[101]={10201,10102},
[100]={10402,10406},
[102]={10707},
[103]={10207},
[104]={10404,10605},
[105]={10606},
[106]={10604,10404,10406},
[107]={10602,10202,10206,10606}
},
monsters=
{
{id=403021,born_pos=10402,wave=1},
{id=403022,born_pos=10406,wave=1},
{id=403021,born_pos=10204,wave=1},
{id=403023,born_pos=10505,wave=2},
{id=403024,born_group=102,wave=2}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",name_id=70010,icon="MapProps_001",desc="装着各种随机素材的箱子。",desc_id=71010,res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_pos=10606,wave=1,rate=100,nPropID=2,float_content="HP+30%",float_content_id=72020,use_sound="ui_buff_attack",name="生命补给",name_id=70020,icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体耐久+30%。 ",desc_id=71020,res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_pos=10501,wave=1,rate=100,nPropID=3,float_content="HP-20%",shake_delay=0,shake_time=300,shake_range=100,icon="图标名称",desc="第三章虚影落石",bIsCanPass=1,perpetual=1,nStep=1,state=4,type=38,param={0.1},damage=0.2,ranges={106,107}}
},
}
return this;