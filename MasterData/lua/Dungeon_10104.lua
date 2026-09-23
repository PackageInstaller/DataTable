local this=
{
mapid=10104,born_group=100,
groups=
{
[100]={10104,10106},
[101]={10605,10304,10306},
[104]={10705},
[105]={10502},
[102]={10805},
[103]={10706},
[107]={10704},
[109]={10703},
[110]={10707},
[111]={10603,10503,10403,10303},
[112]={10607,10507,10407,10307},
[106]={10208,10202}
},
monsters=
{
{id=402041,born_pos=10205,wave=1},
{id=402042,born_pos=10607,wave=1},
{id=402041,born_pos=10705,wave=2},
{id=402043,born_pos=10601,wave=2},
{id=402044,born_group=102,wave=3},
{id=402045,born_pos=10302,nRelationID=1,wave=1},
{id=402045,born_pos=10308,nRelationID=2,wave=1}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",name_id=70010,icon="MapProps_001",desc="装着各种随机素材的箱子。",desc_id=71010,res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=107,wave=2,rate=100,nPropID=2,float_content="耐久+30%",float_content_id=72020,name="生命补给",name_id=70020,icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体耐久+30%。",desc_id=71020,res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.5}},
{born_pos=10302,wave=1,rate=100,nPropID=3,nRelationID=1,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={1}},
{born_pos=10308,wave=1,rate=100,nPropID=4,nRelationID=2,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={1}},
{born_group=109,wave=1,rate=100,nPropID=5,name="泄止阀",name_id=70160,icon="MapProps_016",desc="世界树的稳压器，会定期释放高压气体击退范围内的敌人并造成一定伤害。",desc_id=71160,res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =111,start_round=2,interval_round  =3,damage=0.05,collide_damage=0},
{born_group=110,wave=1,rate=100,nPropID=6,name="泄止阀",name_id=70160,icon="MapProps_016",desc="世界树的稳压器，会定期释放高压气体击退范围内的敌人并造成一定伤害。",desc_id=71160,res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =112,start_round=2,interval_round  =3,damage=0.05,collide_damage=0},
{born_group=106,wave=1,rate=100,nPropID=7,name="探视天眼",name_id=70150,icon="MapProps_015",desc="世界树自卫系统中的检测器，随机检测自身为中心3格十字范围内的敌方单位，若检测到敌方单位立即召唤妨害造物清理目标。",desc_id=71150,res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=106,wave=1,rate=100,nPropID=8,name="探视天眼",name_id=70150,icon="MapProps_015",desc="世界树自卫系统中的检测器，随机检测自身为中心3格十字范围内的敌方单位，若检测到敌方单位立即召唤妨害造物清理目标。",desc_id=71150,res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0}
},
}
return this;