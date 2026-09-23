--FireBall数据
local this = 
{
[958292235]={
{effect="cast_buff",effect_pack="j80370",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Blade_Stream_attack_skill_03"},
{time=3500,type=3,hits={2000}}
},
[-686817241]={
{effect="cast1_hit",effect_pack="j80370",time=5000,type=0,pos_ref={ref_type=0,offset_row=-200}},
{delay=3000,time=5000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=400,range2=400,hz=10,decay_value=0.6},hits={0}},
{effect="cast1_eff",effect_pack="j80370",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Blade_Stream_attack_skill_01"},
{delay=2000,time=5000,type=1,hit_type=0,camera_shake={time=900,shake_dir=1,range=200,range2=200,hz=50,decay_value=0.6},hits={0}},
{delay=2500,time=5000,type=1,hit_type=0,camera_shake={time=200,range=200,hz=200,decay_value=0.25},hits={0,300}}
},
[1310282141]={
{delay=14500,time=4000,type=1,hit_type=1,hit_creates={2124325257},hits={0,300,600}},
{delay=3300,time=4000,type=1,hit_type=1,hits={0,700}},
{effect="cast2_eff",time=16500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Blade_Stream_attack_skill_02"},
{delay=1700,time=4000,type=1,hit_type=1,hits={0}}
},
[2124325257]={
time=2000,type=0
},
[-1609092943]={
{effect="cast0_hit",effect_pack="j80370",time=4000,type=0,pos_ref={ref_type=1,lock_col=1}},
{delay=2500,time=4000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=200,range2=200,hz=50,decay_value=0.6},hits={0}},
{delay=1000,time=4000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=200,range2=200,hz=10,decay_value=0.6},hits={0}},
{effect="cast0_eff",effect_pack="j80370",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Blade_Stream_attack_general"}
},
[-1328923786]={
{time=3500,type=0}
}
};

return this;