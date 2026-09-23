--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Morne.acb",cue_name="Morne_11",cue_feature=1},
{effect="cast2_eff1",time=5000,type=0,pos_ref={ref_type=6}},
{delay=4500,time=6000,type=3,work_delay=800,hits={0}},
{time=6000,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="LeMorne_attack_skill_02"}
},
[-686817241]={
{effect="cast1_eff1",delay=350,time=2500,type=0,pos_ref={ref_type=6},cue_sheet="cv/Morne.acb",cue_name="Morne_10",cue_feature=1},
{effect="cast1_eff2",delay=600,time=2500,type=0,pos_ref={ref_type=6,offset_row=-50}},
{delay=1400,time=2500,type=3,hits={0}},
{time=2500,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="LeMorne_attack_skill_01"}
},
[-1609092943]={
{effect="cast0_eff",delay=100,time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Morne.acb",cue_name="Morne_09",cue_feature=1},
{delay=150,time=2000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=150,range1=300,range2=25,hz=30,decay_value=0.3},hit_creates={1349028111},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="LeMorne_attack_general"}
},
[1349028111]={
effect="qc_common_medium_hit",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;