--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",time=1800,type=0,pos_ref={ref_type=6}},
{delay=580,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=200,range1=200,range2=100,hz=30,decay_value=0.25},hit_creates={806661594},hits={0}},
{delay=1140,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=200,range1=200,range2=100,hz=30,decay_value=0.25},hit_creates={1192467788},hits={0}},
{delay=200,time=8000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="roma_attack_skill_01"}
},
[806661594]={
effect="cast1_hit_1",delay=200,time=1220,type=0,pos_ref={ref_type=4,part_index=2}
},
[1192467788]={
effect="cast1_hit_2",delay=200,time=660,type=0,pos_ref={ref_type=4,part_index=2}
},
[-1609092943]={
{effect="cast0_eff",time=1500,type=0,pos_ref={ref_type=6}},
{delay=480,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_01",hit_type=0,camera_shake={time=200,shake_dir=1,range=200,range1=50,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="roma_attack_general"}
},
[661633433]={
effect="cast0_hit",time=1500,type=0,pos_ref={ref_type=4,part_index=2}
}
};

return this;