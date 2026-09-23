--FireBall数据
local this = 
{
[-686817241]={
{time=6000,type=0,cue_sheet="fight/effect/twelfth.acb",cue_name="chimera_attack_skill_01"},
{effect="cast1_eff",effect_no_flip=1,time=5000,type=0,pos_ref={ref_type=6}},
{time=7000,type=1,hit_type=1,is_fake=1,fake_damage=1,camera_shake={time=480,shake_dir=1,range=160,range2=60,hz=50,decay_value=0.35},hits={1650,1900,2150,2400}},
{time=7000,type=1,hit_type=1,hits={1650,1900,2150,2400}}
},
[1310282141]={
{delay=8560,time=12000,type=1,hit_type=1,hits={0}},
{delay=7900,time=12000,type=1,hit_type=1,hits={0}},
{delay=8120,time=12000,type=1,hit_type=1,hits={0}},
{delay=8340,time=12000,type=1,hit_type=1,hits={0}},
{effect="cast2_eff",time=11000,type=0,pos_ref={ref_type=6}},
{time=11000,type=0,cue_sheet="fight/effect/twelfth.acb",cue_name="chimera_attack_skill_02"},
{delay=8780,time=12000,type=1,hit_type=1,hits={0}},
{delay=8840,time=12000,type=1,hit_type=1,hits={0}}
},
[958292235]={
{delay=1250,time=4000,type=1,hit_type=1,camera_shake={time=600,shake_dir=1,range=550,range1=200,range2=200,hz=30,decay_value=0.3},hits={0}},
{time=4000,type=0,cue_sheet="fight/effect/twelfth.acb",cue_name="chimera_attack_skill_04"},
{effect="cast3_hit",effect_no_flip=1,delay=1250,time=4000,type=0,pos_ref={ref_type=3}},
{effect="cast3_eff",time=4000,type=0,pos_ref={ref_type=6}}
},
[-1485114200]={
{time=11000,type=1,hit_type=0,hits={4850}},
{time=11000,type=0},
{effect="cast4_eff",effect_no_flip=1,time=7300,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/Nineteen.acb",cue_name="91400_cast_04"}
},
[-1609092943]={
{effect="cast0_eff",time=4000,type=0,pos_ref={ref_type=6}},
{time=3900,type=0,cue_sheet="fight/effect/twelfth.acb",cue_name="chimera_attack_general"},
{delay=1250,time=2000,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=220,range1=100,hz=30,decay_value=0.35},hits={0}}
}
};

return this;