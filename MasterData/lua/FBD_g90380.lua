--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=3500,type=0,pos_ref={ref_type=6}},
{time=5000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=300,range1=100,hz=30,decay_value=0.25},hits={1730}},
{time=5000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="centaur2_attack_skill_02"}
},
[-686817241]={
{delay=1500,time=3000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=350,range1=100,range2=25,hz=30,decay_value=0.3},hit_creates={806661594},hits={0}},
{effect="cast1_eff",time=4000,type=0,pos_ref={ref_type=6}},
{time=4000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="centaur2_attack_skill_01"}
},
[806661594]={
effect="cast1_hit",time=4000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{delay=340,time=2000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hit_creates={661633433},hits={0}},
{time=3500,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="centaur2_attack_general",volume_coeff=29},
{effect="cast0_eff",time=5000,type=0,pos_ref={ref_type=6}}
},
[661633433]={
effect="cast0_hit",time=5000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;