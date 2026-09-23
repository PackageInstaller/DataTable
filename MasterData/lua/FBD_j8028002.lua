--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=17000,type=0,pos_ref={ref_type=6}},
{delay=12807,time=4000,type=1,hit_type=1,hits={0}},
{delay=400,time=17000,type=0,cue_sheet="fight/effect/twelfth.acb",cue_name="DarkMatter_attack_skill_02"},
{delay=14415,time=4000,type=1,hit_type=1,hits={0}},
{delay=6300,time=17000,type=0,cue_sheet="cv/Collapsar.acb",cue_name="Collapsar_40",cue_feature=1}
},
[-686817241]={
{effect="cast1_eff",effect_pack="j80280",time=6000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="DarkMatter_attack_skill_01"},
{effect="cast1_eff2",effect_pack="j80280",delay=2200,time=6000,type=0,pos_ref={ref_type=6}},
{delay=2300,time=2500,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=400,range1=100,range2=1000,hz=30,decay_value=0.3},hits={0}}
},
[-1609092943]={
{delay=900,time=3000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}},
{effect="cast0_eff",effect_pack="j80280",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="DarkMatter_attack_general"},
{effect="cast0_hit",effect_pack="j80280",delay=1000,time=3000,type=0,pos_ref={ref_type=1,lock_col=1}},
{delay=800,time=3000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}}
}
};

return this;