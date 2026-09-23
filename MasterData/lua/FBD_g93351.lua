--FireBall数据
local this = 
{
[-686817241]={
{time=100000,type=1,hit_type=1,hits={6000,11200,12450}},
{effect="cast1_hit",time=14500,type=0,pos_ref={ref_type=1}},
{effect="cast1_eff",time=10000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Titan_Claw_attack_skill_01"}
},
[-1609092943]={
{delay=1433,time=4000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=450,range2=450,hz=30,decay_value=0.5},hits={0}},
{effect="cast0_hit",delay=1433,time=5000,type=0,pos_ref={ref_type=3}},
{effect="cast0_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Titan_Claw_attack_skill_02"}
},
[-316323548]={
{effect="dead1",effect_pack="common",time=3000,type=0,pos_ref={ref_type=6,offset_row=-75,offset_col=-200,offset_height=230},cue_sheet="fight/effect/explosion_.acb",cue_name="grenade_exploImpac_1"}
}
};

return this;