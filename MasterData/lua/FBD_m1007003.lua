--FireBall数据
local this = 
{
[-686817241]={
{time=2500,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="10070_cast_01"},
{delay=1200,time=4000,type=4,hits={0}},
{effect="cast1_debuff",effect_pack="m10070",delay=650,time=2000,type=0,pos_ref={ref_type=16}},
{effect="cast1_eff",effect_pack="m10070",time=3500,type=0,pos_ref={ref_type=6}},
{time=2500,type=0,cue_sheet="cv/Cinnabar.acb",cue_name="Cinnabar_10",cue_feature=1}
},
[1310282141]={
{time=12300,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="10070_cast_02"},
{delay=7300,time=12300,type=0,cue_sheet="cv/Cinnabar.acb",cue_name="Cinnabar_12",cue_feature=1},
{time=12000,type=1,hit_type=1,hit_creates={2124325257},hits={3600,4200,5300,10500,10800,11300}},
{effect="cast2_eff",effect_pack="m10070",time=13000,type=0,pos_ref={ref_type=6}},
{delay=500,time=12300,type=0,cue_sheet="cv/Cinnabar.acb",cue_name="Cinnabar_11",cue_feature=1}
},
[2124325257]={
time=2000,type=0
},
[-1609092943]={
{time=2500,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="10070_cast_00"},
{delay=1450,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=260,range2=100,hz=30,decay_value=0.3},hits={0}},
{effect="cast0_hit",effect_pack="m10070",time=2500,type=0,pos_ref={ref_type=1}},
{effect="cast0_eff",effect_pack="m10070",time=3500,type=0,pos_ref={ref_type=6}},
{time=2500,type=0,cue_sheet="cv/Cinnabar.acb",cue_name="Cinnabar_09",cue_feature=1}
},
[-1183793042]={
{effect="enter",effect_pack="m10070",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",effect_pack="m10070",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;