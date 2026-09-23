--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Uillean_attack_skill_02"},
{time=5000,type=3,hits={9000}},
{time=5000,type=2,hits={9000}},
{time=5000,type=3,hits={9000}},
{time=5000,type=0,cue_sheet="cv/Uillean.acb",cue_name="Uillean_11",cue_feature=1},
{time=5000,type=3,hits={9000}},
{effect="cast2_eff2",delay=9000,time=5000,type=0,pos_ref={ref_type=15},dont_remove_when_skip=1}
},
[-686817241]={
{time=3000,type=0,cue_sheet="cv/Uillean.acb",cue_name="Uillean_10",cue_feature=1},
{effect="cast1_eff",effect_pack="o20240",time=3000,type=0,pos_ref={ref_type=6}},
{time=3000,type=3,hit_creates={806661594},hits={2800}},
{time=3000,type=0,cue_sheet="fight/effect/thirteen.acb",cue_name="Uillean_attack_skill_01"}
},
[806661594]={
effect="cast1_hit",effect_pack="o20240",time=3500,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{delay=1485,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=150,range1=150,range2=150,hz=200,decay_value=0.6},hits={0}},
{effect="cast0_eff",effect_pack="o20240",time=5000,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{time=5000,type=0,cue_sheet="cv/Uillean.acb",cue_name="Uillean_09",cue_feature=1},
{delay=1565,time=2000,type=1,hit_type=0,hits={0}},
{effect="cast0_hit",effect_pack="o20240",time=5000,type=0,pos_ref={ref_type=1}},
{delay=2800,time=2000,type=3,hits={0}},
{delay=1925,time=2000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=400,range1=400,range2=400,hz=200,decay_value=0.6},hits={0}},
{time=5000,type=0,cue_sheet="fight/effect/thirteen.acb",cue_name="Uillean_attack_general"}
}
};

return this;