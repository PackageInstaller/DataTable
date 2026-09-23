--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",delay=450,time=3000,type=0,pos_ref={ref_type=6}},
{delay=430,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04",hit_type=1,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={1192467788},hits={0}},
{time=3000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="robot1_attack_skill_01"}
},
[1192467788]={
effect="common_hit1",effect_pack="common_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{effect="cast0_eff2",delay=360,time=2000,type=0,pos_ref={ref_type=6}},
{delay=300,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04",hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="robot1_attack_general"}
},
[661633433]={
effect="common_hit1",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;