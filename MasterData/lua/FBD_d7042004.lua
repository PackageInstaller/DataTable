--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",effect_pack="d70420",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Smelt_attack_skill_01"},
{time=3500,type=0,cue_sheet="cv/Smelt.acb",cue_name="Smelt_10",cue_feature=1},
{delay=1800,time=3500,type=3,hits={0}}
},
[1310282141]={
{delay=2000,time=12000,type=0,cue_sheet="cv/Smelt.acb",cue_name="Smelt_12",cue_feature=1},
{delay=9300,time=4000,type=1,hit_type=1,hit_creates={2124325257},hits={0,100,200,300}},
{time=12000,type=0,cue_sheet="cv/Smelt.acb",cue_name="Smelt_11",cue_feature=1},
{effect="cast2_eff",effect_pack="d70420",time=12000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Smelt_attack_skill_02"}
},
[2124325257]={
time=2000,type=0
},
[-1609092943]={
{time=4000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hits={500,1500}},
{effect="cast0_hit",effect_pack="d70420",time=2000,type=0,pos_ref={ref_type=0,offset_row=-200,offset_height=-80}},
{time=3500,type=0,cue_sheet="cv/Smelt.acb",cue_name="Smelt_09",cue_feature=1},
{effect="cast0_eff",effect_pack="d70420",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Smelt_attack_general"}
},
[-1183793042]={
{effect="enter",effect_pack="d70420",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",effect_pack="d70420",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;