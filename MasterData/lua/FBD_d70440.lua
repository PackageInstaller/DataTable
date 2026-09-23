--FireBall数据
local this = 
{
[1310282141]={
{delay=8000,time=14500,type=0,cue_sheet="cv/Sunrise.acb",cue_name="Sunrise_12",cue_feature=1},
{time=4000,type=1,hit_type=1,hit_creates={-520473558,2124325257},hits={4200,4650,5100,6650,7300}},
{time=14500,type=0,cue_sheet="fight/effect/seventeen.acb",cue_name="Sunrise_attack_skill_02"},
{delay=1300,time=4000,type=1,hit_type=1,hits={11200,11500,11800,11800,11800,11800,11800}},
{delay=700,time=14500,type=0,cue_sheet="cv/Sunrise.acb",cue_name="Sunrise_11",cue_feature=1},
{effect="cast2_eff",time=14500,type=0,pos_ref={ref_type=6}}
},
[-520473558]={
time=2000,type=0
},
[2124325257]={
time=11000,type=0
},
[-686817241]={
{time=11000,type=0,cue_sheet="fight/effect/seventeen.acb",cue_name="Sunrise_attack_skill_01"},
{time=4000,type=1,hit_type=1,camera_shake={time=280,shake_dir=1,range=160,range2=60,hz=100,decay_value=0.3},hits={470,660,820}},
{effect="cast1_hit",delay=500,time=2000,type=0,pos_ref={ref_type=1}},
{effect="cast1_eff",time=11000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Sunrise.acb",cue_name="Sunrise_10",cue_feature=1}
},
[-1609092943]={
{delay=900,time=4000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=300,range2=100,hz=30,decay_value=0.3},hits={0,220}},
{effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=1}},
{time=11000,type=0,cue_sheet="fight/effect/seventeen.acb",cue_name="Sunrise_attack_general"},
{effect="cast0_eff",time=11000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Sunrise.acb",cue_name="Sunrise_09",cue_feature=1}
},
[-1183793042]={
{effect="enter",time=11000,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",time=11000,type=0,pos_ref={ref_type=6}}
}
};

return this;