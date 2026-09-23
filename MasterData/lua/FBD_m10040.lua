--FireBall数据
local this = 
{
[-865403415]={
{effect="cast_call",time=8000,type=0,pos_ref={ref_type=6},cue_sheet="cv/andes.acb",cue_name="andes_40",cue_feature=1},
{delay=500,time=8000,type=0,cue_sheet="fight/effect/eleventh.acb",cue_name="Cordillera_summon"}
},
[1310282141]={
{effect="cast2_eff",time=6000,type=0,pos_ref={ref_type=6}},
{time=4000,type=0},
{time=3800,type=3,work_delay=200,hits={3800}},
{time=6000,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="Andes_attack_skill_02"},
{time=6000,type=0,cue_sheet="cv/andes.acb",cue_name="andes_11",cue_feature=1}
},
[-686817241]={
{effect="cast1_eff",time=2000,type=0,pos_ref={ref_type=6}},
{time=2000,type=0,cue_sheet="cv/andes.acb",cue_name="andes_10",cue_feature=1},
{time=2000,type=3,hits={1000}},
{time=2500,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="Andes_attack_skill_01"}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{delay=1000,time=2000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=200,range1=100,range2=25,hz=30,decay_value=0.3},hits={0}},
{effect="cast0_hit",delay=1080,time=2000,type=0,pos_ref={ref_type=1}},
{effect="qc_shoot_hit1",effect_pack="common_hit",delay=960,time=2000,type=0,pos_ref={ref_type=1}},
{effect="qc_shoot_hit1",effect_pack="common_hit",delay=1000,time=2000,type=0,pos_ref={ref_type=1}},
{time=2000,type=0,cue_sheet="cv/andes.acb",cue_name="andes_09",cue_feature=1},
{delay=200,time=2000,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="Andes_attack_general"}
}
};

return this;