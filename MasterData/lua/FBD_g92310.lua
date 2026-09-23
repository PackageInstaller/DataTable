--FireBall数据
local this = 
{
[1310282141]={
{delay=2500,time=2000,type=1,hit_type=1,camera_shake={time=350,shake_dir=1,range=350,range1=200,range2=150,hz=30,decay_value=0.3},hits={0}},
{effect="cast2_hit",time=7000,type=0,pos_ref={ref_type=6}},
{effect="cast2_eff",time=7000,type=0,pos_ref={ref_type=3,offset_row=100},cue_sheet="fight/effect/twelfth.acb",cue_name="Ice_strength_attack_skill_02",path_target={ref_type=3,offset_row=-100}},
{delay=3500,time=2000,type=1,hit_type=1,camera_shake={time=350,shake_dir=1,range=350,range1=200,range2=150,hz=30,decay_value=0.3},hits={0}}
},
[-686817241]={
{delay=1300,time=2500,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={200}},
{effect="cast1_hit",delay=200,time=5000,type=0,pos_ref={ref_type=1,offset_col=-100,lock_col=1}},
{delay=1600,time=2500,type=1,hit_type=0,hits={200}},
{effect="cast1_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="Ice_strength_attack_skill_01"}
},
[-1609092943]={
{effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=1}},
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="Ice_strength_attack_general"},
{delay=740,time=2000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=280,range1=100,range2=25,hz=30,decay_value=0.3},hits={0}}
},
[-1328923786]={
{time=2000,type=0}
}
};

return this;