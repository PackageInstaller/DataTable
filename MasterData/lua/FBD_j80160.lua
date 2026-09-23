--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=11930,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{delay=5333,time=3430,type=0},
{delay=3800,time=8200,type=1,hit_type=1,hits={0,900,4900,5600,7400}},
{time=11920,type=0,cue_sheet="fight/effect/sixth.acb",cue_name="Streptopelia_attack_skill_02"}
},
[-686817241]={
{effect="cast1_eff",time=2166,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixth.acb",cue_name="Streptopelia_attack_skill_01"},
{effect="cast1_hit",time=2166,type=0,pos_ref={ref_type=1}},
{delay=1200,time=2166,type=1,hit_type=0,camera_shake={time=400,range=200,range1=100,range2=200,hz=60,decay_value=0.3},hits={0}},
{delay=1300,time=2166,type=1,hit_type=0,hits={0,100}}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixth.acb",cue_name="Streptopelia_attack_general"},
{effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=1}},
{delay=1070,time=2000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=150,range1=50,range2=150,hz=30,decay_value=0.6},hits={0,240}}
}
};

return this;