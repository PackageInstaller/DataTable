--FireBall数据
local this = 
{
[1310282141]={
{time=6000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="centaur1_attack_skill_02"},
{effect="cast2_eff",time=6000,type=0,pos_ref={ref_type=6}},
{delay=1680,time=6000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=500,range1=100,range2=25,hz=30,decay_value=0.3},hit_creates={161059103},hits={0}}
},
[161059103]={
effect="cast2_hit",time=6000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-686817241]={
{delay=1250,time=3000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=300,range1=200,hz=200,decay_value=0.25},hit_creates={806661594},hits={0}},
{time=3000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="centaur1_attack_skill_01"},
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6}}
},
[806661594]={
effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{delay=570,time=3500,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=200,range1=100,range2=100,hz=40,decay_value=0.4},hit_creates={661633433},hits={0}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/monsters_cast.acb",cue_name="centaur1_attack_general"}
},
[661633433]={
effect="cast0_hit",time=3500,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;