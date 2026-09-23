--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=6500,type=0,pos_ref={ref_type=6}},
{effect="cast2_hit1",effect_pack="d70051",time=6500,type=0,pos_ref={ref_type=10}},
{delay=5000,time=6500,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=0,camera_shake={time=800,shake_dir=1,range=300,range1=300,range2=500,hz=200,decay_value=0.25},hits={0}},
{time=6500,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="hades_dead_attack_skill_01"}
},
[-1609092943]={
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6,lock_col=1},cue_sheet="fight/effect/thrid.acb",cue_name="hades_dead_attack_general"},
{effect="cast0_hit1",effect_pack="d70051",delay=600,time=3500,type=0,pos_ref={ref_type=7,offset_row=-200,part_index=1,lock_col=1}},
{delay=1000,time=3000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=1,camera_shake={time=350,shake_dir=1,range=300,range2=400,hz=30,decay_value=0.3},hits={0}},
{delay=1500,time=3000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=1,camera_shake={time=350,shake_dir=1,range=300,range2=400,hz=30,decay_value=0.3},hits={0}}
},
[-316323548]={
{effect="qc_boom_12",effect_pack="common_hit",delay=1200,time=1500,type=0,pos_ref={ref_type=6,lock_col=1}}
}
};

return this;