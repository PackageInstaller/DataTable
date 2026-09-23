--FireBall数据
local this = 
{
[-865403415]={
{effect="summon_eff",time=7000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/Aymur_summon.acb",cue_name="Aymur_summon"},
{time=7000,type=0,cue_sheet="cv/Aymur.acb",cue_name="Aymur_46",cue_feature=1}
},
[1310282141]={
{time=4000,type=1,hit_type=1,hit_creates={2124325257},hits={3650,7200,8000,8800,9100}},
{delay=5000,time=10000,type=0,cue_sheet="cv/Aymur.acb",cue_name="Aymur_12",cue_feature=1},
{effect="cast2_eff",time=10000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Aymur_attack_skill_02"},
{time=10000,type=0,cue_sheet="cv/Aymur.acb",cue_name="Aymur_11",cue_feature=1}
},
[2124325257]={
time=2000,type=0
},
[-686817241]={
{time=4000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=220,range2=100,hz=55,decay_value=0.3},hit_creates={1192467788},hits={1100,1550,1750}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Aymur_attack_skill_01"},
{time=3500,type=0,cue_sheet="cv/Aymur.acb",cue_name="Aymur_10",cue_feature=1}
},
[1192467788]={
effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{time=3500,type=0,cue_sheet="cv/Aymur.acb",cue_name="Aymur_09",cue_feature=1},
{delay=1130,time=4000,type=1,hit_type=1,camera_shake={time=330,shake_dir=1,range=300,range2=300,hz=65,decay_value=0.3},hit_creates={1349028111},hits={0,200}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Aymur_attack_general"}
},
[1349028111]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;