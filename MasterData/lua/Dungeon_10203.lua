local this=
{
mapid=10203,born_group=100,
groups=
{
[100]={10101,10301},
[101]={10210},
[102]={10606},
[103]={10104,10108,10305,10408},
[104]={10408},
[105]={10303,10203,10103,10505,10506,10507,10309,10209,10109},
[106]={10304,10204,10104,10405,10406,10407,10308,10208,10108}
},
monsters=
{
{id=403031,born_pos=10206,wave=1},
{id=403032,born_pos=10204,wave=1},
{id=403032,born_pos=10305,wave=2},
{id=403033,born_pos=10309,wave=2},
{id=403034,born_group=102,wave=3}
},
props=
{
{born_pos=10210,wave=1,rate=100,nPropID=1,name="货箱",name_id=70010,icon="MapProps_001",desc="装着各种随机素材的箱子。",desc_id=71010,res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=104,wave=1,rate=100,nPropID=2,float_content="耐久+30% ",float_content_id=72020,name="生命补给",name_id=70020,icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",desc_id=71020,res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_pos=10401,wave=1,rate=100,nPropID=3,icon="图标名称",desc="第三章虚影落石",nStep=1,state=4,type=38,param={0.1},damage=0.2,ranges={105,106}}
},
}
return this;