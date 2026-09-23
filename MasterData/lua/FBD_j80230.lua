--FireBall数据
local this = 
{
[1310282141]={
{delay=7100,time=4000,type=1,hit_type=1,hits={0,200}},
{delay=3100,time=4000,type=1,hit_type=1,hit_creates={2124325257},hits={0}},
{effect="cast2_eff",time=8500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fourteen.acb",cue_name="Khepri_attack_skill_02"}
},
[2124325257]={
effect="cast2_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-686817241]={
{delay=1250,time=4000,type=3,hit_creates={1192467788},hits={0}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fourteen.acb",cue_name="Khepri_attack_skill_01"}
},
[1192467788]={
effect="cast1_buff",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{delay=800,time=4000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=220,range1=100,range2=100,hz=40,decay_value=0.35},hits={0,100}},
{time=2000,type=0},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fourteen.acb",cue_name="Khepri_attack_general"}
},
[958292235]={
{time=1000,type=0,cue_sheet="fight/effect/fourteen.acb",cue_name="Khepri_attack_skill_03"},
{delay=500,time=2000,type=3,hit_creates={518161756},hits={0}}
},
[518161756]={
effect="cast1_buff",time=1000,type=0,pos_ref={ref_type=4,part_index=1}
}
};

return this;