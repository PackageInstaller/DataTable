--FireBall数据
local this = 
{
[958292235]={
{delay=1500,time=3000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=250,range1=100,range2=20,hz=50,decay_value=0.4},hits={0}},
{delay=750,time=2000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=400,range1=200,range2=50,hz=30,decay_value=0.25},hits={0}},
{effect="cast2_2_eff",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="image4_attack_skill_02"}
},
[1310282141]={
{effect="cast2_1_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="image4_attack_skill_02_ready"}
},
[806661594]={
effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-686817241]={
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="image4_attack_skill_01"},
{delay=1230,time=3000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={806661594},hits={0}}
},
[-1609092943]={
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="image4_attack_general",path_target={ref_type=1}},
{delay=900,time=2000,type=1,hit_type=0,camera_shake={time=250,shake_dir=1,range=300,range1=150,range2=50,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=1}
}
};

return this;