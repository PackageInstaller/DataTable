--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",time=8000,type=0,pos_ref={ref_type=6}},
{delay=500,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hits={0}},
{delay=1150,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hits={0}},
{delay=200,time=8000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="roma_attack_skill_01"}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/monsters_cast.acb",cue_name="roma_attack_general"},
{delay=500,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_01",hit_type=0,camera_shake={time=200,shake_dir=1,range=200,range1=50,hz=30,decay_value=0.25},hits={0}}
}
};

return this;