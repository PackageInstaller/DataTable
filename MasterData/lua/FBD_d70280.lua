--FireBall数据
local this = 
{
[1310282141]={
{delay=4500,time=9000,type=0,cue_sheet="cv/Gondul.acb",cue_name="Gondul_12",cue_feature=1},
{delay=1000,time=9000,type=0,cue_sheet="cv/Gondul.acb",cue_name="Gondul_11",cue_feature=1},
{delay=1680,time=5000,type=1,hit_type=1,hit_creates={2124325257},hits={0,4050}},
{effect="cast2_eff",time=9000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/eleventh.acb",cue_name="Gondul_attack_skill_02"}
},
[2124325257]={
effect="cast2_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-686817241]={
{delay=2800,time=1000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=200,hz=150,decay_value=0.4},hits={0}},
{effect="cast1_hit",time=6000,type=0,pos_ref={ref_type=5,offset_row=50,offset_col=-50}},
{time=3000,type=0,cue_sheet="fight/effect/eleventh.acb",cue_name="Gondul_attack_skill_01"},
{effect="cast1_eff",time=1500,type=0,pos_ref={ref_type=6}},
{time=3000,type=0,cue_sheet="cv/Gondul.acb",cue_name="Gondul_10",cue_feature=1}
},
[661633433]={
effect="common_hit1",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=1}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/eleventh.acb",cue_name="Gondul_attack_general"},
{time=2000,type=0,cue_sheet="cv/Gondul.acb",cue_name="Gondul_09",cue_feature=1},
{delay=300,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=300,range1=100,range2=25,hz=30,decay_value=0.6},hit_creates={661633433,-838067028},hits={0}}
},
[-838067028]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=1}
},
[-1183793042]={
{effect="enter",time=3000,type=0,pos_ref={ref_type=6}}
}
};

return this;