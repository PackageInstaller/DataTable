--FireBall数据
local this = 
{
[-686817241]={
{delay=560,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={806661594},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="roma3_attack_skill_01"},
{effect="cast1_eff",time=2000,type=0,pos_ref={ref_type=6}}
},
[806661594]={
effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=2}
},
[-1609092943]={
{delay=300,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}},
{delay=100,time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="roma3_attack_general"},
{effect="cast0_eff",time=1000,type=0,pos_ref={ref_type=6}}
},
[661633433]={
effect="cast0_hit",time=1000,type=0,pos_ref={ref_type=4,part_index=2}
}
};

return this;