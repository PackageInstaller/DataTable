--FireBall数据
local this = 
{
[1310282141]={
{time=5000,type=0,cue_sheet="fight/effect/twelfth.acb",cue_name="image6_attack_skill_02"},
{delay=1600,time=5000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=350,range1=200,range2=50,hz=30,decay_value=0.35},hit_creates={161059103},hits={0}},
{effect="cast2_eff",time=6000,type=0,pos_ref={ref_type=6}}
},
[161059103]={
effect="cast2_hit",time=5000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-686817241]={
{time=4000,type=1,hit_type=0,camera_shake={time=1000,shake_dir=1,range=150,range1=100,range2=30,hz=40,decay_value=0.45},hit_creates={1192467788},hits={900,1200,1500}},
{effect="cast1_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="image6_attack_skill_01"}
},
[1192467788]={
time=4000,type=0
},
[1349028111]={
effect="cast0_hit_2",time=2500,type=0,pos_ref={ref_type=4,part_index=1}
},
[661633433]={
effect="cast0_hit_1",time=4000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="image6_attack_general",path_target={ref_type=1}},
{delay=810,time=4000,type=1,hit_type=0,camera_shake={time=100,shake_dir=1,range=300,range1=100,range2=50,hz=30,decay_value=0.5},hit_creates={661633433},hits={0}},
{delay=900,time=4000,type=1,hit_type=0,camera_shake={time=100,shake_dir=1,range=300,range1=100,range2=50,hz=30,decay_value=0.5},hit_creates={1349028111},hits={0}}
}
};

return this;