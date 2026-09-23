--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff03",time=4000,type=0,pos_ref={ref_type=5,offset_row=50,offset_col=-50},cue_sheet="cv/Frost.acb",cue_name="Frost_11",cue_feature=1},
{effect="cast2_eff01",time=2000,type=0,pos_ref={ref_type=6}},
{time=4200,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="Frost_attack_skill_02"},
{effect="cast2_eff02",time=4000,type=0,pos_ref={ref_type=1},cue_sheet="cv/Frost.acb",cue_name="Frost_11",cue_feature=1},
{delay=2750,time=5000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=400,range1=100,range2=500,hz=30,decay_value=0.3},hits={0}}
},
[-1368377223]={
effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-686817241]={
{effect="cast1_eff01",delay=100,time=2500,type=0,pos_ref={ref_type=6,offset_row=25}},
{effect="cast1_eff02",delay=350,time=3000,type=0,pos_ref={ref_type=6,offset_row=-200}},
{delay=350,time=2000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=200,range1=300,range2=25,hz=30,decay_value=0.3},hit_creates={-1368377223},hits={0}},
{delay=150,time=2000,type=0,cue_sheet="cv/Frost.acb",cue_name="Frost_06",cue_feature=1},
{time=2500,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="Frost_attack_skill_01"}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifth.acb",cue_name="Frost_attack_general"},
{delay=500,time=2000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=300,range2=25,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{time=2000,type=0,cue_sheet="cv/Frost.acb",cue_name="Frost_09",cue_feature=1}
},
[661633433]={
effect="qc_common_medium_hit",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=1}
}
};

return this;