--FireBall数据
local this = 
{
[-686817241]={
{delay=430,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04",hit_type=1,camera_shake={time=300,shake_dir=1,range=400,range1=100,hz=30,decay_value=0.45},hit_creates={1192467788},hits={0}},
{effect="cast1_eff",delay=450,time=3000,type=0,pos_ref={ref_type=0,offset_row=34,lock_col=1}},
{time=3000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="robot1_attack_skill_01"}
},
[1192467788]={
effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="robot1_attack_general"},
{effect="cast0_eff",delay=360,time=2000,type=0,pos_ref={ref_type=6}},
{delay=300,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04",hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;