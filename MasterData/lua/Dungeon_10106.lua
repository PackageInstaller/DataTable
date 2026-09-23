local this=
{
mapid=10106,born_group=101,
groups=
{
[101]={10205,10203},
[100]={10404,10606,10602},
[104]={10702,10706},
[102]={10904},
[103]={10802},
[105]={10806},
[112]={10202,10302,10402,10502},
[113]={10206,10306,10406,10506},
[114]={10903,10803,10703,10603},
[115]={10905,10805,10705,10605},
[107]={10401,10407,10601,10607,10806,10802}
},
monsters=
{
{id=402061,born_pos=10404,wave=1},
{id=402061,born_pos=10704,wave=1},
{id=402062,born_pos=10905,wave=2},
{id=402063,born_pos=10701,wave=2},
{id=402064,born_group=102,wave=3},
{id=402065,born_pos=10602,nRelationID=1,wave=1},
{id=402065,born_pos=10706,nRelationID=2,wave=1}
},
props=
{
{born_pos=10707,wave=2,rate=100,nPropID=1,name="货箱",name_id=70010,icon="MapProps_001",desc="装着各种随机素材的箱子。",desc_id=71010,res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_pos=10801,wave=3,rate=100,nPropID=2,float_content="耐久+30%",float_content_id=72020,use_sound="ui_buff_attack",name="生命补给",name_id=70020,icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体耐久+30%。",desc_id=71020,res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_pos=10602,wave=1,rate=100,nPropID=3,nRelationID=1,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={2}},
{born_pos=10706,wave=1,rate=100,nPropID=4,nRelationID=2,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={3}},
{born_pos=11003,wave=1,rate=100,nPropID=5,name="泄止阀",name_id=70160,icon="MapProps_016",desc="世界树的稳压器，会定期释放高压气体击退范围内的敌人并造成一定伤害。",desc_id=71160,res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =114,start_round=1,interval_round  =3,damage=0.05,collide_damage=0},
{born_pos=11005,wave=1,rate=100,nPropID=6,name="泄止阀",name_id=70160,icon="MapProps_016",desc="世界树的稳压器，会定期释放高压气体击退范围内的敌人并造成一定伤害。",desc_id=71160,res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =115,start_round=1,interval_round  =3,damage=0.05,collide_damage=0},
{born_pos=10102,wave=1,rate=100,nPropID=7,angle=180,name="泄止阀",name_id=70160,icon="MapProps_016",desc="世界树的稳压器，会定期释放高压气体击退范围内的敌人并造成一定伤害。",desc_id=71160,res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =112,start_round=2,interval_round  =3,damage=0.05,collide_damage=0},
{born_pos=10106,wave=1,rate=100,nPropID=8,angle=180,name="泄止阀",name_id=70160,icon="MapProps_016",desc="世界树的稳压器，会定期释放高压气体击退范围内的敌人并造成一定伤害。",desc_id=71160,res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =113,start_round=2,interval_round  =3,damage=0.05,collide_damage=0},
{born_group=107,wave=1,rate=100,nPropID=9,name="探视天眼",name_id=70150,icon="MapProps_015",desc="世界树自卫系统中的检测器，随机检测自身为中心3格十字范围内的敌方单位，若检测到敌方单位立即召唤妨害造物清理目标。",desc_id=71150,res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=10,name="探视天眼",name_id=70150,icon="MapProps_015",desc="世界树自卫系统中的检测器，随机检测自身为中心3格十字范围内的敌方单位，若检测到敌方单位立即召唤妨害造物清理目标。",desc_id=71150,res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=11,name="探视天眼",name_id=70150,icon="MapProps_015",desc="世界树自卫系统中的检测器，随机检测自身为中心3格十字范围内的敌方单位，若检测到敌方单位立即召唤妨害造物清理目标。",desc_id=71150,res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=12,name="探视天眼",name_id=70150,icon="MapProps_015",desc="世界树自卫系统中的检测器，随机检测自身为中心3格十字范围内的敌方单位，若检测到敌方单位立即召唤妨害造物清理目标。",desc_id=71150,res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=13,name="探视天眼",name_id=70150,icon="MapProps_015",desc="世界树自卫系统中的检测器，随机检测自身为中心3格十字范围内的敌方单位，若检测到敌方单位立即召唤妨害造物清理目标。",desc_id=71150,res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=14,name="探视天眼",name_id=70150,icon="MapProps_015",desc="世界树自卫系统中的检测器，随机检测自身为中心3格十字范围内的敌方单位，若检测到敌方单位立即召唤妨害造物清理目标。",desc_id=71150,res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0}
},
}
return this;