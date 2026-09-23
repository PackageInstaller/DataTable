--FireBall数据
local this = 
{
[-686817241]={
{delay=700,time=3500,type=1,hit_type=1,camera_shake={time=450,shake_dir=1,range=350,range2=350,hz=50,decay_value=0.6},hit_creates={1192467788},hits={0}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Oman_attack_skill_01"}
},
[1192467788]={
effect="cast2_hit",time=3500,type=0,pos_ref={ref_type=4,part_index=1}
},
[1310282141]={
{delay=1100,time=3500,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hit_creates={2124325257},hits={0}},
{effect="cast2_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Oman_attack_skill_02"}
},
[2124325257]={
effect="cast2_hit",time=3500,type=0,pos_ref={ref_type=4,part_index=1}
},
[958292235]={
{delay=6700,time=3500,type=1,hit_type=0,hits={0,100,200,300,400,500}},
{effect="cast3_eff",time=8000,type=0,pos_ref={ref_type=6}},
{delay=330,time=8000,type=0,cue_sheet="fight/effect/thirteen.acb",cue_name="Oman_attack_skill_03"}
},
[-1485114200]={
{time=10000,type=1,hit_type=1,hits={3300,4400,8500,8100,8800}},
{effect="cast4_eff",time=10800,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Oman_attack_skill_04"}
},
[-1609092943]={
{delay=850,time=3500,type=1,hit_type=1,camera_shake={time=250,shake_dir=1,range=400,range2=400,hz=50,decay_value=0.4},hits={0}},
{effect="cast0_hit",delay=850,time=2000,type=0,pos_ref={ref_type=0,offset_row=25,lock_col=1}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Oman_attack_general"}
},
[-316323548]={
{effect="deadLarge_common_eff",effect_pack="common",delay=2500,time=6000,type=0,pos_ref={ref_type=6}},
{time=6000,type=0,cue_sheet="fight/effect/nineth.acb",cue_name="Censor_Die"}
}
};

return this;