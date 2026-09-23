--FireBall数据
local this = 
{
[1310282141]={
{delay=1800,time=2000,type=1,hit_type=0,hits={0,1000,2500}},
{time=5200,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Leedsichthys_attack_skill_02"},
{effect="cast2_eff",time=4860,type=0,pos_ref={ref_type=6},cue_sheet="cv/Shastasaurus.acb",cue_name="Shastasaurus_11",cue_feature=1}
},
[-686817241]={
{time=4000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=150,range1=150,range2=25,hz=30,decay_value=0.3},hits={2000}},
{time=3000,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Leedsichthys_attack_skill_01"},
{effect="cast1_hit",time=4000,type=0,pos_ref={ref_type=1}},
{effect="cast1_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Shastasaurus.acb",cue_name="Shastasaurus_10",cue_feature=1}
},
[-1609092943]={
{delay=600,time=2000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=300,range1=50,range2=25,hz=30,decay_value=0.3},hits={0}},
{effect="cast0_eff",time=1900,type=0,pos_ref={ref_type=6,offset_row=-150},cue_sheet="cv/Shastasaurus.acb",cue_name="Shastasaurus_09",cue_feature=1},
{time=1200,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Leedsichthys_attack_general"},
{delay=400,time=2000,type=1,hit_type=0,is_fake=1,hit_creates={661633433},hits={0}}
},
[661633433]={
effect="cast0_hit",time=1900,type=0,pos_ref={ref_type=4,part_index=1}
},
[958292235]={
{time=4000,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Leedsichthys_attack_skill_01"},
{time=4000,type=1,hit_type=0,camera_shake={time=650,range=100,range1=200,range2=25,hz=26,decay_value=0.2},hit_creates={518161756},hits={2000}},
{effect="cast3_hit2",delay=1450,time=4000,type=0,pos_ref={ref_type=5,offset_row=50,offset_col=-50}},
{effect="cast3_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Shastasaurus.acb",cue_name="Shastasaurus_10",cue_feature=1}
},
[518161756]={
effect="cast3_hit",delay=1883,time=4000,type=0,pos_ref={ref_type=4,part_index=1}
}
};

return this;