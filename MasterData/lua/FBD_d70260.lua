--FireBall数据
local this = 
{
[1310282141]={
{delay=8700,time=4000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}},
{time=10700,type=0,cue_sheet="fight/effect/twelfth.acb",cue_name="Thor_attack_skill_02"},
{delay=9300,time=4000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}},
{effect="cast2_eff",time=10700,type=0,pos_ref={ref_type=10}},
{delay=4662,time=10700,type=0,cue_sheet="cv/Thor.acb",cue_name="Thor_12",cue_feature=1},
{delay=333,time=10700,type=0,cue_sheet="cv/Thor.acb",cue_name="Thor_11",cue_feature=1},
{delay=9000,time=4000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}}
},
[-686817241]={
{delay=1300,time=2060,type=3,hits={0}},
{effect="cast1_eff",time=2060,type=0,pos_ref={ref_type=6},cue_sheet="cv/Thor.acb",cue_name="Thor_10",cue_feature=1},
{time=2060,type=0,cue_sheet="fight/effect/twelfth.acb",cue_name="Thor_attack_skill_01"}
},
[-1609092943]={
{delay=1620,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,range2=200,hz=100,decay_value=0.5},hits={0}},
{effect="cast0_hit",time=3820,type=0,pos_ref={ref_type=1}},
{time=3500,type=0,cue_sheet="fight/effect/twelfth.acb",cue_name="Thor_attack_general"},
{effect="cast0_eff",time=2700,path_index=0,type=0,pos_ref={ref_type=6},cue_sheet="cv/Thor.acb",cue_name="Thor_09",cue_feature=1,path_target={ref_type=1}},
{delay=2340,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,range2=200,hz=100,decay_value=0.5},hits={0}}
},
[-1328923786]={
{effect="win_eff",time=2200,type=0,pos_ref={ref_type=6}}
},
[-1183793042]={
{effect="enter_eff",time=2740,type=0,pos_ref={ref_type=6}}
}
};

return this;