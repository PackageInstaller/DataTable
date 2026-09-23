local this=
{
mapid=1124,born_group=100,
groups=
{
[100]={10102,10105},
[101]={10304,10303},
[104]={10502,10505},
[102]={10603},
[103]={10605},
[105]={10203,10204,10405,10503}
},
monsters=
{
{id=101241,born_group=101,wave=1},
{id=101242,born_group=101,wave=1},
{id=101242,born_group=104,wave=2},
{id=101243,born_group=104,wave=2},
{id=101244,born_group=102,wave=3}
},
props=
{
{born_group=103,wave=3,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=3,rate=75,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_pos=10604,wave=2,rate=100,nPropID=3,float_content="HP+30%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}}
},
}
return this;