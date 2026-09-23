--FireBall数据
local this = 
{
[-601574123]={
{time=3000,type=0}
},
[-686817241]={
{delay=1133,time=4000,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=300,range2=300,hz=50,decay_value=0.6},hits={0}},
{effect="cast1_hit",delay=1133,time=5000,type=0,pos_ref={ref_type=3}},
{effect="cast1_eff",time=2200,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Phantom_Stinger_attack_skill_01"},
{delay=1133,time=4000,type=1,hit_type=1,hits={500}}
},
[1310282141]={
{time=10000,type=1,hit_type=1,hits={6800,7800,8300,8800,9400,10000}},
{effect="cast2_eff",time=11000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Phantom_Stinger_attack_skill_02"},
{effect="cast2_hit",time=11000,type=0,pos_ref={ref_type=3}}
},
[-1609092943]={
{delay=966,time=4000,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=150,range2=150,hz=45,decay_value=0.5},hits={0}},
{effect="cast0_hit",delay=966,time=2000,type=0,pos_ref={ref_type=1}},
{delay=966,time=4000,type=1,hit_type=1,hits={200,500}},
{effect="cast0_eff",time=2300,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Phantom_Stinger_attack_general"}
},
[-316323548]={
{time=6000,type=0,cue_sheet="fight/effect/nineth.acb",cue_name="Drasoul_Die"},
{effect="deadLarge_common_eff",effect_pack="common",delay=2416,time=6000,type=0,pos_ref={ref_type=6}}
}
};

return this;