--FireBall数据
local this = 
{
[2124325257]={
effect="cast2_hit_2",time=6000,type=0,pos_ref={ref_type=4,part_index=1}
},
[1310282141]={
{delay=200,time=4000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=300,range1=150,range2=20,hz=30,decay_value=0.25},hit_creates={161059103},hits={0}},
{delay=960,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=500,range1=300,range2=50,hz=30,decay_value=0.25},hit_creates={2124325257},hits={0}},
{effect="cast2_eff",time=6000,type=0,pos_ref={ref_type=6,offset_row=50},cue_sheet="fight/effect/twelfth.acb",cue_name="image2_attack_skill_02"}
},
[161059103]={
effect="cast2_hit_1",time=6000,type=0,pos_ref={ref_type=4,part_index=1}
},
[806661594]={
effect="cast1_hit_1",time=4000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-686817241]={
{effect="cast1_eff",time=4000,type=0,pos_ref={ref_type=6,offset_row=-75},cue_sheet="fight/effect/twelfth.acb",cue_name="image2_attack_skill_01"},
{time=4000,type=1,hit_type=0,camera_shake={time=190,shake_dir=1,range=300,range1=150,range2=50,hz=30,decay_value=0.25},hit_creates={806661594},hits={170,370}},
{delay=870,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=450,range1=250,range2=50,hz=30,decay_value=0.25},hit_creates={1192467788},hits={0}},
{delay=400,time=4000,type=0}
},
[1192467788]={
effect="cast1_hit_2",time=4000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{delay=100,time=3000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=300,range1=100,range2=50,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}},
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="image2_attack_general"}
},
[661633433]={
effect="cast0_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;