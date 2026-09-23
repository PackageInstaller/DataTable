--FireBall数据
local this = 
{
[1310282141]={
{delay=2500,time=4000,type=3,hits={0}},
{effect="cast2_eff",time=4000,type=0,pos_ref={ref_type=13},cue_sheet="cv/Granite.acb",cue_name="Granite_11",cue_feature=1},
{time=5000,type=0,cue_sheet="fight/effect/granite_cast.acb",cue_name="granite_attack_skill_02"}
},
[-686817241]={
{time=2000,type=0,cue_sheet="fight/effect/granite_cast.acb",cue_name="granite_attack_skill_01"},
{effect="cast1_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Granite.acb",cue_name="Granite_10",cue_feature=1},
{delay=1000,time=2000,type=3,hit_creates={806661594},hits={0}}
},
[806661594]={
effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{delay=600,time=2000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=200,range1=50,range2=300,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{delay=600,time=2000,type=0,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_02"},
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Granite.acb",cue_name="Granite_09",cue_feature=1},
{time=2000,type=0,cue_sheet="fight/effect/granite_cast.acb",cue_name="granite_attack_general"}
},
[661633433]={
effect="qc_blunt_hit2",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=1}
}
};

return this;