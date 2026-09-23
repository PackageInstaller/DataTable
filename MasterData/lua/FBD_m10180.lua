--FireBall数据
local this = 
{
[1310282141]={
{time=5000,type=0,cue_sheet="fight/effect/kailas_cast.acb",cue_name="kailas_attack_skill_02"},
{effect="cast2_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Kailas.acb",cue_name="Kailas_11",cue_feature=1},
{effect="cast2_hit",delay=2000,time=5000,type=0,pos_ref={ref_type=1,offset_row=463}},
{delay=2100,time=5000,type=1,hit_type=1,camera_shake={time=600,shake_dir=1,range=400,range1=100,range2=300,hz=30,decay_value=0.3},hit_creates={-1745025860},hits={0}}
},
[-1745025860]={
effect="qc_shoot_hit2",effect_pack="common_hit",delay=2000,time=5000,type=0,pos_ref={ref_type=1},cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04"
},
[-686817241]={
{delay=1800,time=2000,type=4,hits={0}},
{time=3000,type=0,cue_sheet="fight/effect/kailas_cast.acb",cue_name="kailas_attack_skill_01"},
{effect="cast1_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Kailas.acb",cue_name="Kailas_10",cue_feature=1},
{effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=16}}
},
[-1609092943]={
{time=2000,type=0,cue_sheet="fight/effect/kailas_cast.acb",cue_name="kailas_attack_general"},
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Kailas.acb",cue_name="Kailas_09",cue_feature=1,path_target={ref_type=1}},
{delay=700,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=200,range2=200,hz=30,decay_value=0.3},hit_creates={-1190450118,661633433},hits={0}}
},
[-1190450118]={
effect="qc_shoot_hit1",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0},cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04"
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;