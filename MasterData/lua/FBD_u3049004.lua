--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",effect_pack="u30490",time=15500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="30490_cast_02"},
{delay=7400,time=8000,type=1,hit_type=1,hit_creates={2124325257},hits={0,300,533,800,1250,2250,6400,6700}},
{delay=100,time=15500,type=0,cue_sheet="cv/MareeRouge.acb",cue_name="MareeRouge_11",cue_feature=1},
{delay=2200,time=15500,type=0,cue_sheet="cv/MareeRouge.acb",cue_name="MareeRouge_12",cue_feature=1}
},
[2124325257]={
effect="cast2_hit",effect_pack="u30490",time=15000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-686817241]={
{delay=1400,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=330,range1=100,range2=200,hz=40,decay_value=0.5},hit_creates={1192467788},hits={0}},
{effect="cast1_eff",effect_pack="u30490",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="30490_cast_01"},
{time=3500,type=0,cue_sheet="cv/MareeRouge.acb",cue_name="MareeRouge_10",cue_feature=1}
},
[1192467788]={
effect="cast1_hit",effect_pack="u30490",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{delay=1300,time=4000,type=1,hit_type=1,camera_shake={time=220,shake_dir=1,range=200,range2=100,hz=30,decay_value=0.3},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",effect_pack="u30490",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="30490_cast_00",path_target={ref_type=1}},
{time=3500,type=0,cue_sheet="cv/MareeRouge.acb",cue_name="MareeRouge_09",cue_feature=1}
},
[1349028111]={
effect="cast0_hit",effect_pack="u30490",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1183793042]={
{effect="enter",effect_pack="u30490",time=2500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",effect_pack="u30490",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;