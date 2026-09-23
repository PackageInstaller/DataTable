--FireBall数据
local this = 
{
[806661594]={
effect="cast1_hit",time=1000,type=0,pos_ref={ref_type=4,part_index=2}
},
[-686817241]={
{delay=300,time=3000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="roma1_attack_skill_01"},
{delay=360,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={806661594},hits={0}},
{delay=360,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hits={0}},
{effect="cast1_eff",time=1000,type=0,pos_ref={ref_type=6,offset_row=100}}
},
[-1609092943]={
{delay=570,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,range1=200,range2=100,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}},
{effect="cast0_eff",time=1333,type=0,pos_ref={ref_type=6}},
{delay=200,time=3000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="roma1_attack_general"}
},
[661633433]={
effect="cast0_hit",time=1333,type=0,pos_ref={ref_type=4,part_index=2}
}
};

return this;