--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="image3_attack_skill_02"},
{delay=1370,time=5000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=200,range1=100,hz=30,decay_value=0.25},hit_creates={161059103},hits={0}}
},
[161059103]={
effect="cast2_hit",time=5000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-686817241]={
{effect="cast1_eff",time=2300,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="image3_attack_skill_01"},
{delay=1325,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=250,range1=100,range2=50,hz=30,decay_value=0.25},hit_creates={806661594},hits={0}}
},
[806661594]={
effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="image3_attack_general"},
{delay=1220,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=1}
}
};

return this;