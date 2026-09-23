--FireBall数据
local this = 
{
[-686817241]={
{delay=900,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_02",hit_type=0,camera_shake={time=200,shake_dir=1,range=100,range1=200,range2=100,hz=30,decay_value=0.25},hit_creates={806661594},hits={0}},
{delay=1450,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_01",hit_type=1,camera_shake={time=350,shake_dir=1,range=300,range1=400,range2=150,hz=30,decay_value=0.25},hit_creates={1192467788},hits={0}},
{delay=300,time=2500,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="romaz4_attack_skill_01"},
{effect="cast1_eff",time=2500,type=0,pos_ref={ref_type=6}}
},
[806661594]={
effect="cast1_hit_1",time=2500,type=0,pos_ref={ref_type=1}
},
[1192467788]={
effect="cast1_hit_2",delay=200,time=2500,type=0,pos_ref={ref_type=1}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6}},
{delay=980,time=2000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=200,range1=100,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}},
{delay=500,time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="romaz4_attack_general"}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;