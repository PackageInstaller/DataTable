--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",time=2000,type=0,pos_ref={ref_type=6}},
{delay=500,time=2000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={806661594},hits={0}},
{delay=500,time=2000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=200,hz=30,decay_value=0.25},hits={0}},
{delay=300,time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="harpie2_attack_skill_01"}
},
[806661594]={
effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=1}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6}},
{effect="cast0_hit",delay=600,time=2000,type=0,pos_ref={ref_type=1}},
{delay=560,time=2000,type=1,hit_type=0,camera_shake={time=350,shake_dir=1,range=300,range1=100,range2=100,hz=30,decay_value=0.25},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="harpie2_attack_general"}
}
};

return this;