--FireBall数据
local this = 
{
[1120628288]={
{time=3000,type=0,cue_sheet="cv/Lepus.acb",cue_name="Lepus_42",cue_feature=1}
},
[1310282141]={
{delay=3000,time=13830,type=0,cue_sheet="cv/Lepus.acb",cue_name="Lepus_51",cue_feature=1},
{delay=500,time=13830,type=0,cue_sheet="cv/Lepus.acb",cue_name="Lepus_50",cue_feature=1},
{delay=5500,time=4000,type=1,hit_type=1,hits={0,700,1006}},
{effect="cast2_hit",effect_pack="u30431",delay=5400,time=13830,type=0,pos_ref={ref_type=6,offset_row=-250}},
{delay=11760,time=4000,type=1,hit_type=1,hits={0}},
{effect="cast2_eff",effect_pack="u30431",time=13830,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fourteen.acb",cue_name="homology_Lepus_attack_skill_02"},
{delay=10080,time=4000,type=1,hit_type=1,hits={0}},
{delay=8166,time=13830,type=0,cue_sheet="cv/Lepus.acb",cue_name="Lepus_52",cue_feature=1}
},
[-686817241]={
{time=4000,type=0,cue_sheet="cv/Lepus.acb",cue_name="Lepus_48",cue_feature=1},
{delay=1500,time=4000,type=1,hit_type=1,camera_shake={time=1300,shake_dir=1,range=100,range1=100,range2=30,hz=60,decay_value=0.7},hits={0}},
{effect="cast1_eff",effect_pack="u30431",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fourteen.acb",cue_name="homology_Lepus_attack_skill_01"},
{delay=1200,time=4000,type=0,cue_sheet="cv/Lepus.acb",cue_name="Lepus_49",cue_feature=1}
},
[-1609092943]={
{delay=1300,time=3000,type=0,cue_sheet="cv/Lepus.acb",cue_name="Lepus_47",cue_feature=1},
{delay=930,time=4000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=300,range1=250,range2=100,hz=30,decay_value=0.3},hit_creates={1349028111},hits={0,400}},
{effect="cast0_eff",effect_pack="u30431",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fourteen.acb",cue_name="homology_Lepus_attack_general"},
{delay=800,time=3000,type=0,cue_sheet="cv/Lepus.acb",cue_name="Lepus_45",cue_feature=1}
},
[1349028111]={
effect="cast0_hit",effect_pack="u30431",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1328923786]={
{time=3000,type=0}
}
};

return this;