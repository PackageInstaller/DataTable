--FireBall数据
local this = 
{
[1079508512]={
{effect="change_eff",effect_pack="d70051",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Hades.acb",cue_name="Hades_13",cue_feature=1}
},
[1310282141]={
{time=6000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="hades_sleep_attack_skill_01"},
{delay=5000,time=6000,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=400,range1=200,range2=4000,hz=30,decay_value=0.3},hits={0}},
{effect="cast2_eff",time=6000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Hades.acb",cue_name="Hades_10",cue_feature=1},
{effect="cast2_hit",effect_pack="d70050",time=6000,type=0,pos_ref={ref_type=10,offset_row=-150}}
},
[-686817241]={
{time=2000,type=0,cue_sheet="cv/Hades.acb",cue_name="Hades_10",cue_feature=1},
{time=2000,type=0}
},
[-1609092943]={
{effect="cast0_eff1",delay=1000,time=1500,path_index=0,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{delay=2000,time=4000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=1,camera_shake={time=500,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hits={0}},
{effect="cast0_hit",effect_pack="d70050",delay=1600,time=5000,type=0,pos_ref={ref_type=1}},
{effect="cast0_eff",effect_pack="d70050",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Hades.acb",cue_name="Hades_09",cue_feature=1},
{time=4000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="hades_sleep_attack_general"}
}
};

return this;