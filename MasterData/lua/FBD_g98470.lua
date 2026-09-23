--FireBall数据
local this = 
{
[-686817241]={
{time=4000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=300,range2=300,hz=10,decay_value=0.6},hits={2500}},
{effect="cast1_hit",time=5000,type=0,pos_ref={ref_type=1,lock_col=1}},
{time=4000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hits={1500}},
{time=3500,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="98470_cast_01"},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6}}
},
[1310282141]={
{time=3500,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="98470_cast_03"},
{time=3500,type=3,hits={1000}},
{effect="cast2_eff",time=3500,type=0,pos_ref={ref_type=6}}
},
[958292235]={
{delay=2000,time=3500,type=4,hits={0}},
{effect="cast3_eff",time=3500,type=0,pos_ref={ref_type=3}},
{time=3500,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="98470_cast_04"}
},
[-1485114200]={
{effect="cast4_eff",time=15000,type=0,pos_ref={ref_type=6}},
{time=15000,type=1,hit_type=1,hits={6800,7600,8200,12500}},
{time=15000,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="98470_cast_02"}
},
[-1609092943]={
{delay=1950,time=4000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=150,range2=150,hz=50,decay_value=0.6},hits={0}},
{effect="cast0_hit",time=3500,type=0,pos_ref={ref_type=1,offset_row=-150}},
{time=3500,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="98470_cast_00"},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6}}
},
[-316323548]={
{effect="deadLarge_common_eff",effect_pack="common",delay=2723,time=6000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/nineth.acb",cue_name="Drasoul_Die"}
}
};

return this;