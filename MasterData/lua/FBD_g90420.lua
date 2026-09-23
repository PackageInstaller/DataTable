--FireBall数据
local this = 
{
[1310282141]={
{time=2000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=100,range1=50,hz=30,decay_value=0.25},hit_creates={161059103},hits={1100,1400,1600,1800}},
{effect="cast2_eff",time=2300,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="image1_attack_skill_02"}
},
[161059103]={
effect="cast2_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-686817241]={
{effect="cast1_eff",time=2000,type=0,pos_ref={ref_type=6,offset_row=-50},cue_sheet="fight/effect/twelfth.acb",cue_name="image1_attack_skill_01"},
{time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=350,range1=150,range2=50,hz=30,decay_value=0.3},hit_creates={806661594},hits={120,400}}
},
[806661594]={
effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{delay=60,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,range1=100,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="image1_attack_general"},
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6}}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=1}
}
};

return this;