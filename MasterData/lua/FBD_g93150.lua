--FireBall数据
local this = 
{
[-686817241]={
{delay=500,time=2000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hit_creates={806661594},hits={0}},
{effect="cast1_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Betis_attack_skill_01"}
},
[806661594]={
effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{delay=800,time=2000,type=3,hits={0}},
{delay=800,time=2000,type=2,hit_creates={661633433},hits={0}},
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Betis_attack_general"}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;