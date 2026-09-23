--FireBall数据
local this = 
{
[-686817241]={
{delay=100,time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="romaz2_attack_skill_01"},
{effect="cast1_eff",time=2000,type=0,pos_ref={ref_type=6}},
{delay=1000,time=2000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=150,range1=300,range2=25,hz=30,decay_value=0.3},hit_creates={1192467788},hits={0}}
},
[1192467788]={
effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{delay=660,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_02",hit_type=1,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6}}
},
[1349028111]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;