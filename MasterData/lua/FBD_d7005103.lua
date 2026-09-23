--FireBall数据
local this = 
{
[2008187309]={
{time=2000,type=0}
},
[1079508512]={
{effect="change_eff",effect_pack="d70050",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Hades.acb",cue_name="Hades_12",cue_feature=1}
},
[1310282141]={
{delay=5500,time=6500,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=0,camera_shake={time=800,shake_dir=1,range=300,range1=300,range2=500,hz=200,decay_value=0.25},hits={0}},
{effect="cast2_eff1",time=6500,type=0,pos_ref={ref_type=6},cue_sheet="cv/Hades.acb",cue_name="Hades_11",cue_feature=1},
{effect="cast2_hit1",effect_pack="d70051",delay=1000,time=6500,type=0,pos_ref={ref_type=10}},
{time=6500,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="hades_dead_attack_skill_01"}
},
[-686817241]={
{time=2000,type=0,cue_sheet="cv/Hades.acb",cue_name="Hades_10",cue_feature=1},
{time=2000,type=0}
},
[-1609092943]={
{delay=1949,time=3000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=1,camera_shake={time=350,shake_dir=1,range=300,range2=400,hz=30,decay_value=0.3},hits={0}},
{effect="cast0_hit1",delay=1000,time=3500,type=0,pos_ref={ref_type=0,offset_row=-150,lock_col=1}},
{delay=1549,time=3000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=1,camera_shake={time=350,shake_dir=1,range=300,range2=400,hz=30,decay_value=0.3},hits={0}},
{effect="cast0_eff1",effect_pack="d70051",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="cv/Hades.acb",cue_name="Hades_09",cue_feature=1},
{time=3500,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="hades_dead_attack_general"}
}
};

return this;