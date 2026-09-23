--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=3000,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{delay=1380,time=5000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=300,range1=100,hz=30,decay_value=0.25},hit_creates={161059103},hits={0}},
{time=4000,type=0,cue_sheet="fight/effect/twelfth.acb",cue_name="image5_attack_skill_02"}
},
[161059103]={
effect="cast2_hit",time=3000,type=0,pos_ref={ref_type=4,offset_height=140,part_index=0}
},
[-686817241]={
{effect="cast1_eff",time=4000,type=0,pos_ref={ref_type=6}},
{time=4000,type=0,cue_sheet="fight/effect/twelfth.acb",cue_name="image5_attack_skill_01"},
{delay=300,time=4000,type=4,hit_creates={806661594},hits={0}}
},
[806661594]={
effect="cast1_hit",time=4000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{delay=1000,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=250,range1=100,range2=20,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/twelfth.acb",cue_name="image5_attack_general"}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;