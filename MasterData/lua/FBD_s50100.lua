--FireBall数据
local this = 
{
[1310282141]={
{effect="Cast2_eff",time=6100,type=0,pos_ref={ref_type=6},cue_sheet="cv/Heliconius.acb",cue_name="Heliconius_11",cue_feature=1},
{effect="Cast2_hit",delay=3750,time=6000,type=0,pos_ref={ref_type=3}},
{delay=4000,time=5000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=400,range1=200,range2=25,hz=30,decay_value=0.3},hits={0,800}},
{time=6100,type=0,cue_sheet="fight/effect/sixth.acb",cue_name="Heliconius_attack_skill_02"}
},
[-686817241]={
{effect="Cast1_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Heliconius.acb",cue_name="Heliconius_10",cue_feature=1},
{effect="Cast1_hit",delay=1500,time=4000,type=0,pos_ref={ref_type=1}},
{delay=1500,time=4000,type=1,hit_type=0,camera_shake={time=650,range=100,range1=200,range2=25,hz=26,decay_value=0.2},hits={200}},
{time=4000,type=0,cue_sheet="fight/effect/sixth.acb",cue_name="Heliconius_attack_skill_01"}
},
[-1609092943]={
{effect="Cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Heliconius.acb",cue_name="Heliconius_09",cue_feature=1,path_target={ref_type=1}},
{delay=820,time=2000,type=1,hit_type=0,camera_shake={time=250,shake_dir=1,range=200,range1=50,range2=200,hz=20,decay_value=0.3},hit_creates={661633433},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/sixth.acb",cue_name="Heliconius_attack_general"}
},
[661633433]={
effect="Cast0_hit",time=2000,type=0,pos_ref={ref_type=1}
}
};

return this;