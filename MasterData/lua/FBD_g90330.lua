--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6}},
{time=3000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={806661594},hits={760,1240}},
{delay=1600,time=3000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={-1368377223},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="romaz3_attack_skill_01"}
},
[806661594]={
effect="cast0_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1368377223]={
effect="cast0_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{effect="cast0_eff",delay=350,time=2000,type=0,pos_ref={ref_type=6}},
{time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="romaz3_attack_general"},
{delay=1000,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=200,range1=50,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;