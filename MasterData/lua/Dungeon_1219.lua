local this=
{
mapid=1219,born_group=101,
groups=
{
[101]={10104,10105},
[100]={10305,10604,10707},
[104]={10407,10502},
[106]={10502},
[102]={10804},
[103]={10702},
[105]={10505},
[107]={10307,10306,10305,10304},
[108]={10602,10603,10604,10605},
[111]={10203,10303,10403,10503},
[112]={10706,10606,10506,10406}
},
monsters=
{
{id=102191,born_pos=10305,wave=1},
{id=102191,born_pos=10707,wave=1},
{id=102192,born_pos=10604,wave=1},
{id=102193,born_pos=10407,wave=2},
{id=102192,born_pos=10502,wave=2},
{id=102194,born_group=102,wave=3}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=1,rate=100,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_group=105,wave=1,rate=100,nPropID=3,float_content="HP+30%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_pos=10308,wave=1,rate=100,nPropID=4,angle=90,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =107,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_pos=10601,wave=1,rate=100,nPropID=5,angle=270,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =108,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_pos=10103,wave=1,rate=100,nPropID=6,angle=180,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =111,start_round=2,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_pos=10806,wave=1,rate=100,nPropID=7,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =112,start_round=2,interval_round  =3,damage=0.09999999,collide_damage=0.09999999}
},
}
return this;