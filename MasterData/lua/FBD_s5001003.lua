--FireBall数据
local this = 
{
[1310282141]={
{delay=4000,time=6000,type=0,cue_sheet="cv/Queen_Bee.acb",cue_name="Queen_Bee_12",cue_feature=1},
{delay=3000,time=6000,type=0,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03",volume_coeff=43},
{delay=2400,time=6000,type=0,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03",volume_coeff=43},
{delay=500,time=6000,type=0,cue_sheet="cv/Queen_Bee.acb",cue_name="Queen_Bee_11",cue_feature=1},
{delay=4500,time=6000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=1,camera_shake={time=1000,shake_dir=1,range=200,range1=200,range2=200,hz=30,decay_value=0.3},hits={0}},
{effect="cast2_eff",effect_pack="s50010",time=6000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="queenbee_attack_skill_02"},
{effect="cast2_hit",effect_pack="s50010",time=6000,type=0,pos_ref={ref_type=1}},
{delay=2600,time=6000,type=0,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03",volume_coeff=43},
{time=6000,type=1,hit_type=1,camera_shake={time=190,shake_dir=1,range=300,range1=300,range2=300,hz=30,decay_value=0.3},hits={2400,2600,3000}}
},
[-686817241]={
{delay=1350,time=2000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03",hit_type=0,camera_shake={time=99,shake_dir=1,range=200,hz=30,decay_value=0.3},hit_creates={806661594},hits={0}},
{effect="cast1_eff",effect_pack="s50010",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="queenbee_attack_skill_01"},
{time=3000,type=0,cue_sheet="cv/Queen_Bee.acb",cue_name="Queen_Bee_10",cue_feature=1},
{delay=1447,time=2000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03",hit_type=1,camera_shake={time=400,shake_dir=1,range=300,range1=200,range2=300,hz=30,decay_value=0.3},hits={0}}
},
[806661594]={
effect="cast1_hit",effect_pack="s50010",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{effect="cast0_eff",effect_pack="s50010",time=1800,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="queenbee_attack_general"},
{delay=600,time=2000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03",hit_type=0,camera_shake={time=300,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hit_creates={1349028111},hits={0}},
{time=1800,type=0,cue_sheet="cv/Queen_Bee.acb",cue_name="Queen_Bee_09",cue_feature=1}
},
[1349028111]={
effect="cast0_hit",effect_pack="s50010",time=1800,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;