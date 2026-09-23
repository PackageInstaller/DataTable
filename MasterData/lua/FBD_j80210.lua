--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=10600,type=0,pos_ref={ref_type=10},cue_sheet="fight/effect/eighth.acb",cue_name="Nidhogg_attack_skill_02"},
{delay=6364,time=6000,type=1,hit_type=1,hits={0}},
{delay=8876,time=6000,type=1,hit_type=1,hits={0}},
{delay=9600,time=6000,type=1,hit_type=1,hits={0}}
},
[-686817241]={
{effect="cast1_eff",time=2800,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{effect="cast1_hit1",delay=880,time=2500,type=0,pos_ref={ref_type=5,lock_col=1}},
{delay=880,time=3000,type=1,hit_type=0,camera_shake={time=800,shake_dir=1,range=300,range1=144,range2=30,hz=15,decay_value=0.3},hit_creates={1192467788},hits={0,500}},
{time=2800,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Nidhogg_attack_skill_01"}
},
[1192467788]={
effect="cast1_hit2",time=2500,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{effect="cast0_eff1",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/eighth.acb",cue_name="Nidhogg_attack_general"},
{effect="cast0_hit",delay=700,time=2000,type=0,pos_ref={ref_type=1,offset_height=-50}},
{delay=750,time=2000,type=1,hit_type=0,camera_shake={time=330,shake_dir=1,range=300,range1=200,range2=25,hz=30,decay_value=0.3},hits={0,400}}
}
};

return this;