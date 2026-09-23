--FireBall数据
local this = 
{
[-1609092943]={
{delay=1200,time=4000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.2},hits={0}},
{effect="cast0_eff",time=4000,type=0,pos_ref={ref_type=1}},
{time=4000,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="92380_cast_00"}
},
[-686817241]={
{delay=100,time=4000,type=1,hit_type=1,camera_shake={time=1100,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hits={0}},
{time=3500,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="92380_cast_01"},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=0,offset_row=-250,lock_row=1}}
},
[1310282141]={
{effect="cast2_eff",time=3500,type=0,pos_ref={ref_type=6}},
{time=3500,type=3,hits={0}},
{time=3500,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="92380_cast_02"}
},
[958292235]={
{time=20000,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="92380_cast_03"},
{delay=17000,time=4000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=500,range2=25,hz=30,decay_value=0.3},hits={500,800,1500}},
{effect="g92380_cast3",effect_pack="videos",time=17000,type=0,pos_ref={ref_type=3}},
{effect="cast3_eff",delay=17000,time=5000,type=0,pos_ref={ref_type=3}}
},
[-316323548]={
{time=6000,type=0,cue_sheet="fight/effect/nineth.acb",cue_name="Drasoul_Die"},
{effect="deadLarge_common_eff",effect_pack="common",delay=2800,time=6000,type=0,pos_ref={ref_type=6}}
}
};

return this;