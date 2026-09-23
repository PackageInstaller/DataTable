--FireBall数据
local this = 
{
[-686817241]={
{time=4000,type=1,hit_type=1,hits={933,1766}},
{delay=1866,time=2000,type=0},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Blaze_Lohengrin_attack_skill_01"}
},
[1310282141]={
{delay=1200,time=10000,type=3,hits={0}},
{effect="cast2_eff",time=10000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Blaze_Lohengrin_attack_skill_02"}
},
[958292235]={
{effect="cast3_eff",time=11100,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Blaze_Lohengrin_attack_skill_03"},
{time=12000,type=1,hit_type=1,hit_creates={1776661962},hits={4500,4800,5100,9200,1000,10200}}
},
[1776661962]={
time=10000,type=0
},
[-1485114200]={
{effect="cast4_eff",time=16100,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Blaze_Lohengrin_attack_skill_04"},
{time=17000,type=1,hit_type=1,hits={4550,4900,5650,6200,6800,7300,13950,14550}}
},
[-1609092943]={
{effect="cast0_hit",time=10000,type=0,pos_ref={ref_type=1}},
{time=10000,type=1,hit_type=1,camera_shake={time=170,shake_dir=1,range=300,hz=200,decay_value=0.25},hits={1800,2000}},
{effect="cast0_eff",time=10000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Blaze_Lohengrin_attack_general"}
},
[-316323548]={
{effect="deadLarge_common_eff",effect_pack="common",delay=1700,time=6000,type=0,pos_ref={ref_type=6}},
{time=6000,type=0,cue_sheet="fight/effect/nineth.acb",cue_name="Censor_Die"}
}
};

return this;