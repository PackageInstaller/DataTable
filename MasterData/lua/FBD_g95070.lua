--FireBall数据
local this = 
{
[1192467788]={
effect="cast1_hit02",time=2500,type=0,pos_ref={ref_type=4,part_index=0}
},
[-686817241]={
{effect="cast1_eff",time=2500,type=0,pos_ref={ref_type=6}},
{delay=580,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_01",hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.5},hit_creates={806661594},hits={0}},
{delay=970,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_02",hit_type=1,camera_shake={time=200,shake_dir=1,range=200,range1=100,hz=30,decay_value=0.5},hit_creates={1192467788},hits={0}}
},
[806661594]={
effect="cast1_hit01",time=2500,type=0,pos_ref={ref_type=1}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6}},
{delay=500,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_02",hit_type=0,camera_shake={time=200,shake_dir=1,range=200,range1=100,hz=30,decay_value=0.5},hits={0}},
{effect="cast0_hit",delay=500,time=2000,type=0,pos_ref={ref_type=1}}
}
};

return this;