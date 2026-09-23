local this=
{
mapid=1225,born_group=101,
groups=
{
[101]={10205,10203},
[100]={10501,10507,10404},
[104]={10702,10706},
[102]={10904},
[103]={10802},
[105]={10806},
[112]={10202,10302,10402,10502},
[113]={10206,10306,10406,10506},
[114]={10903,10803,10703,10603},
[115]={10905,10805,10705,10605}
},
monsters=
{
{id=102254,born_group=102,wave=3},
{id=102251,born_pos=10404,wave=1},
{id=102252,born_pos=10501,wave=1},
{id=102252,born_pos=10507,wave=1},
{id=102251,born_group=104,wave=1},
{id=102251,born_group=104,wave=1}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=1,rate=100,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_group=105,wave=1,rate=100,nPropID=3,float_content="HP+30%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_pos=10102,wave=1,rate=100,nPropID=4,angle=180,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =112,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_pos=10106,wave=1,rate=100,nPropID=5,angle=180,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =113,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_pos=11003,wave=1,rate=100,nPropID=6,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =114,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_pos=11005,wave=1,rate=100,nPropID=7,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =115,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999}
},
}
return this;