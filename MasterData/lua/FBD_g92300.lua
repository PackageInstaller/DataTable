--FireBall数据
local this = 
{
[1310282141]={
{delay=2836,time=2000,type=1,hit_type=1,camera_shake={time=350,shake_dir=1,range=350,range1=200,range2=150,hz=30,decay_value=0.3},hits={0}},
{delay=2716,time=2000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=150,range1=200,range2=150,hz=50,decay_value=0.6},hits={0}},
{effect="cast2_eff",time=5400,type=0,pos_ref={ref_type=6}},
{time=5400,type=0,cue_sheet="fight/effect/twelfth.acb",cue_name="Mf_strength_attack_skill_02"},
{effect="cast2_hit",time=5000,type=0,pos_ref={ref_type=3}}
},
[-686817241]={
{effect="cast1_hit",time=5000,type=0,pos_ref={ref_type=0,offset_row=25,lock_col=1}},
{delay=1982,time=2500,type=1,hit_type=1,camera_shake={time=550,shake_dir=1,range=150,range1=250,range2=50,hz=200,decay_value=0.6},hits={0}},
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="Mf_strength_attack_skill_01"},
{delay=1400,time=2500,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=150,range1=250,range2=50,hz=200,decay_value=0.6},hits={0}}
},
[-1609092943]={
{effect="cast0_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="Mf_strength_attack_general"},
{delay=740,time=2000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=280,range1=100,range2=25,hz=30,decay_value=0.3},hits={0}}
},
[-1328923786]={
{effect="win",time=5000,type=0,pos_ref={ref_type=6}}
}
};

return this;