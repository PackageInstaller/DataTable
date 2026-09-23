local this=
{
mapid=10105,born_group=101,
groups=
{
[101]={10206,10306},
[100]={10303,10602,10907},
[104]={10602},
[107]={10904},
[102]={10608},
[103]={10808},
[105]={10802},
[108]={10708,10707,10706},
[109]={10605,10505},
[112]={10404},
[106]={10906,10806,10706,10606},
[110]={10402,10403,10404,10405},
[111]={10203,10303,10403,10503},
[113]={10702,10703,10704,10705},
[114]={10508,10903}
},
monsters=
{
{id=402051,born_pos=10203,wave=1},
{id=402053,born_pos=10907,wave=1},
{id=402051,born_pos=10606,wave=2},
{id=402052,born_pos=10602,wave=2},
{id=402054,born_group=102,wave=3},
{id=402055,born_pos=10507,nRelationID=1,wave=1}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",name_id=70010,icon="MapProps_001",desc="装着各种随机素材的箱子。",desc_id=71010,res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=105,wave=2,rate=100,nPropID=2,float_content="耐久+30%",float_content_id=72020,use_sound="ui_buff_attack",name="生命补给",name_id=70020,icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体耐久+30%。",desc_id=71020,res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_pos=10507,wave=1,rate=100,nPropID=3,nRelationID=1,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={4}},
{born_pos=10404,wave=1,rate=100,nPropID=4,name="线程闸",name_id=70110,icon="MapProps_011",desc="世界树的特殊物理后门，曾用作特殊情况下的造物回收。",desc_id=71110,res="GridProps/section2/1",get_eff="get_eff_blue",eBlockState=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={6,5,8,9,7}},
{born_group=109,wave=1,rate=100,nPropID=5,name="屏蔽力场",name_id=70120,icon="MapProps_012",desc="世界树表面的特殊防护装置，激活状态下无法直接通过。",desc_id=71120,res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=0.09999999},
{born_group=109,wave=1,rate=100,nPropID=6,name="屏蔽力场",name_id=70120,icon="MapProps_012",desc="世界树表面的特殊防护装置，激活状态下无法直接通过。",desc_id=71120,res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=0.09999999},
{born_group=108,wave=1,rate=100,nPropID=7,name="屏蔽力场",name_id=70120,icon="MapProps_012",desc="世界树表面的特殊防护装置，激活状态下无法直接通过。",desc_id=71120,res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=4,type=16,TriggerType=2,damage=0.09999999},
{born_group=108,wave=1,rate=100,nPropID=8,name="屏蔽力场",name_id=70120,icon="MapProps_012",desc="世界树表面的特殊防护装置，激活状态下无法直接通过。",desc_id=71120,res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=4,type=16,TriggerType=2,damage=0.09999999},
{born_group=108,wave=1,rate=100,nPropID=9,name="屏蔽力场",name_id=70120,icon="MapProps_012",desc="世界树表面的特殊防护装置，激活状态下无法直接通过。",desc_id=71120,res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=4,type=16,TriggerType=2,damage=0.09999999},
{born_group=114,wave=1,rate=100,nPropID=10,name="探视天眼",name_id=70150,icon="MapProps_015",desc="世界树自卫系统中的检测器，随机检测自身为中心3格十字范围内的敌方单位，若检测到敌方单位立即召唤妨害造物清理目标。",desc_id=71150,res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=114,wave=1,rate=100,nPropID=11,name="探视天眼",name_id=70150,icon="MapProps_015",desc="世界树自卫系统中的检测器，随机检测自身为中心3格十字范围内的敌方单位，若检测到敌方单位立即召唤妨害造物清理目标。",desc_id=71150,res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_pos=10705,wave=1,rate=100,nPropID=12,name="岩石障碍",icon="MapProps_008",desc="碎星建筑残骸，队伍无法移动到上面。",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=1,damage=0},
{born_pos=10405,wave=1,rate=100,nPropID=13,name="岩石障碍",icon="MapProps_008",desc="碎星建筑残骸，队伍无法移动到上面。",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=1,damage=0},
{born_pos=11006,wave=1,rate=100,nPropID=14,name="泄止阀",name_id=70160,icon="MapProps_016",desc="世界树的稳压器，会定期释放高压气体击退范围内的敌人并造成一定伤害。",desc_id=71160,res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =106,start_round=1,interval_round  =3,damage=0.05,collide_damage=0},
{born_pos=10401,wave=1,rate=100,nPropID=15,angle=270,name="泄止阀",name_id=70160,icon="MapProps_016",desc="世界树的稳压器，会定期释放高压气体击退范围内的敌人并造成一定伤害。",desc_id=71160,res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =110,start_round=1,interval_round  =3,damage=0.05,collide_damage=0},
{born_pos=10103,wave=1,rate=100,nPropID=16,angle=180,name="泄止阀",name_id=70160,icon="MapProps_016",desc="世界树的稳压器，会定期释放高压气体击退范围内的敌人并造成一定伤害。",desc_id=71160,res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =111,start_round=2,interval_round  =3,damage=0.05,collide_damage=0},
{born_pos=10701,wave=1,rate=100,nPropID=17,angle=270,name="泄止阀",name_id=70160,icon="MapProps_016",desc="世界树的稳压器，会定期释放高压气体击退范围内的敌人并造成一定伤害。",desc_id=71160,res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =113,start_round=2,interval_round  =3,damage=0.05,collide_damage=0}
},
}
return this;