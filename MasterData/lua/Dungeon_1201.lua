local this=
{
mapid=1201,born_group=100,
groups=
{
[100]={10106,10104},
[101]={10404,10208},
[102]={10204,10507},
[103]={10108},
[104]={10609},
[105]={10506},
[106]={10504,10404,10304,10204},
[107]={10506,10406,10306,10206}
},
monsters=
{
{id=102012,born_pos=10502,wave=1},
{id=102013,born_pos=10508,nRelationID=1,wave=1},
{id=102014,born_group=104,wave=1},
{id=102011,born_pos=10204,wave=1}
},
props=
{
{born_pos=10109,wave=1,rate=100,nPropID=1,float_content="HP+30%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_pos=10508,wave=1,rate=100,nPropID=2,nRelationID=1,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=3,nChangeStep=0,dir={4}},
{born_pos=10604,wave=1,rate=100,nPropID=3,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =106,start_round=1,interval_round  =2,damage=0.05,collide_damage=0.05},
{born_pos=10606,wave=1,rate=100,nPropID=4,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =107,start_round=1,interval_round  =2,damage=0.05,collide_damage=0.05}
},
}
return this;