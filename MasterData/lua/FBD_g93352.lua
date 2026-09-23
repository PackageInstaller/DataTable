--FireBall数据
local this = 
{
[-686817241]={
{time=10000,type=1,hit_type=1,hits={5000,6000}},
{effect="cast1_hit",time=8500,type=0,pos_ref={ref_type=2}},
{effect="cast1_eff",time=8500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Razor_Stinger_attack_skill_01"}
},
[-1609092943]={
{time=4000,type=1,hit_type=1,camera_shake={time=1200,shake_dir=1,range=250,range2=250,hz=35,decay_value=0.5},hits={1000}},
{effect="cast0_hit",time=5000,type=0,pos_ref={ref_type=3}},
{effect="cast0_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Razor_Stinger_attack_general"},
{time=4000,type=1,hit_type=1,hits={1300,1600}}
},
[-316323548]={
{effect="dead1",effect_pack="common",time=3000,type=0,pos_ref={ref_type=6,offset_row=-75,offset_height=230},cue_sheet="fight/effect/explosion_.acb",cue_name="grenade_exploImpac_1"}
}
};

return this;