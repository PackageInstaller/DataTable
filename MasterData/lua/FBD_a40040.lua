--FireBall数据
local this = 
{
[1310282141]={
{effect="Cast2_hit2",delay=3833,time=500,type=0,pos_ref={ref_type=10}},
{effect="Cast2_hit3",delay=3933,time=500,type=0,pos_ref={ref_type=10}},
{time=6000,type=1,hit_type=1,camera_shake={time=150,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={4000,4300,5200,5500}},
{effect="Cast2_eff",time=6000,type=0,pos_ref={ref_type=6}},
{time=6000,type=0,cue_sheet="fight/effect/sixth.acb",cue_name="Prominence_attack_skill_02"},
{effect="Cast2_hit1",delay=3800,time=500,type=0,pos_ref={ref_type=10}},
{delay=733,time=6000,type=0,cue_sheet="cv/prominence.acb",cue_name="prominence_11",cue_feature=1},
{effect="Cast2_hit5",delay=4400,time=1000,type=0,pos_ref={ref_type=10}},
{effect="Cast2_hit4",delay=4000,time=500,type=0,pos_ref={ref_type=10}}
},
[-686817241]={
{effect="Cast1_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/prominence.acb",cue_name="prominence_10",cue_feature=1},
{delay=1200,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=500,range1=200,range2=25,hz=30,decay_value=0.3},hits={0}},
{delay=1900,time=2000,type=1,hit_type=1,hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/sixth.acb",cue_name="Prominence_attack_skill_01"},
{effect="Cast1_hit",time=4000,type=0,pos_ref={ref_type=1,lock_col=1}},
{delay=1600,time=2000,type=1,hit_type=0,camera_shake={time=800,shake_dir=1,range=300,range1=100,range2=10,hz=30,decay_value=0.3},hits={0}}
},
[-1609092943]={
{time=2000,type=0,cue_sheet="fight/effect/sixth.acb",cue_name="Prominence_attack_general"},
{effect="Cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/prominence.acb",cue_name="prominence_09",cue_feature=1,path_target={ref_type=1}},
{delay=630,time=2000,type=1,hit_type=0,hit_delay_coeff_dis=40,hit_dis_offset=-100,camera_shake={time=149,shake_dir=1,range=300,range2=100,hz=30,decay_value=0.3},hit_creates={661633433},hits={0,170}},
{delay=1000,time=2000,type=1,hit_type=0,hit_delay_coeff_dis=40,hit_dis_offset=-100,camera_shake={time=400,shake_dir=1,range=250,range2=25,hz=30,decay_value=0.3},hit_creates={-838067028},hits={0}}
},
[-838067028]={
effect="Cast0_hit2",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[661633433]={
effect="Cast0_hit1",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;