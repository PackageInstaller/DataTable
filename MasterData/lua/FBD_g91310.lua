--FireBall数据
local this = 
{
[2008187309]={
{delay=10,time=15000,type=0,cue_sheet="fight/effect/Blaze_Lohengrin_enter.acb",cue_name="Blaze_Lohengrin_enter"},
{effect="boss_enter_91311",time=15000,type=0,pos_ref={ref_type=10}}
},
[-686817241]={
{delay=1900,time=4000,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=120,range2=120,hz=60,decay_value=0.5},hits={0}},
{effect="cast1_hit",delay=1866,time=2000,type=0,pos_ref={ref_type=1}},
{delay=1900,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range2=300,hz=60,decay_value=0.5},hits={400}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Tenacious_Lohengrin_attack_skill_01",path_target={ref_type=1,lock_col=1}}
},
[1310282141]={
{effect="cast2_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Tenacious_Lohengrin_attack_skill_02"},
{delay=1400,time=3500,type=3,hits={0}}
},
[1776661962]={
time=3500,type=0
},
[958292235]={
{effect="cast3_eff",time=11100,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Tenacious_Lohengrin_attack_skill_03"},
{delay=4800,time=7000,type=1,hit_type=0,hit_creates={1776661962},hits={0,250,500,750,4050,4400,5150,5500}}
},
[-1609092943]={
{delay=900,time=4000,type=1,hit_type=0,camera_shake={time=350,shake_dir=1,range=170,range2=100,hz=55,decay_value=0.4},hits={0}},
{effect="cast0_hit",delay=900,time=2000,type=0,pos_ref={ref_type=1}},
{delay=1120,time=4000,type=1,hit_type=0,camera_shake={time=350,shake_dir=1,range=170,range2=100,hz=55,decay_value=0.4},hits={0}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Tenacious_Lohengrin_attack_general"}
},
[-316323548]={
{effect="deadLarge_common_eff",effect_pack="common",time=6000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/nineth.acb",cue_name="Censor_Die"}
}
};

return this;