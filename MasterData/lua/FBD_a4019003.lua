--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",effect_pack="a40190",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="cv/Aurora.acb",cue_name="Aurora_11",cue_feature=1},
{delay=2450,time=3000,type=1,hit_type=1,camera_shake={time=600,shake_dir=1,range=350,range1=100,range2=25,hz=30,decay_value=0.3},hit_creates={161059103},hits={0}},
{time=3500,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="Aurora_attack_skill_02"}
},
[161059103]={
effect="cast2_hit",effect_pack="a40190",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-686817241]={
{effect="cast1_eff",effect_pack="a40190",time=2500,type=0,pos_ref={ref_type=13,offset_row=300},cue_sheet="cv/Aurora.acb",cue_name="Aurora_10",cue_feature=1},
{effect="cast1_eff2",effect_pack="a40190",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifth.acb",cue_name="Aurora_attack_skill_01"},
{time=2000,type=3,hits={1500}}
},
[-1609092943]={
{time=2000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=500,range2=25,hz=30,decay_value=0.3},hit_creates={661633433},hits={950}},
{time=2000,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="Aurora_attack_general"},
{effect="cast0_eff",effect_pack="a40190",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Aurora.acb",cue_name="Aurora_08",cue_feature=1}
},
[661633433]={
effect="cast0_hit",effect_pack="a40190",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;