--FireBall数据
local this = 
{
[-686817241]={
{time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=20,decay_value=0.6},hits={1800}},
{effect="cast1_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Pollux_attack_skill_01"},
{effect="cast1_hit",delay=1800,time=4000,type=0,pos_ref={ref_type=1,offset_row=50,lock_col=1}}
},
[1310282141]={
{delay=1000,time=4000,type=1,hit_type=1,camera_shake={time=100,shake_dir=1,range=150,range2=150,hz=100,decay_value=0.5},hit_creates={-520473558},hits={0}},
{effect="cast2_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Pollux_attack_skill_02"},
{delay=1100,time=4000,type=1,hit_type=1,camera_shake={time=600,shake_dir=1,range=800,range2=800,hz=50,decay_value=0.5},hits={100}}
},
[-520473558]={
effect="common_hit1",effect_pack="common_hit",time=4000,type=0,pos_ref={ref_type=4,part_index=1}
},
[958292235]={
{delay=6800,time=4000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}},
{delay=7000,time=4000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}},
{effect="cast3_eff",time=8500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Pollux_attack_skill_03"},
{delay=7000,time=4000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}},
{delay=6900,time=4000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}}
},
[-1609092943]={
{time=4000,type=1,work_delay=500,hit_type=1,camera_shake={time=500,shake_dir=1,range=100,range2=100,hz=15,decay_value=0.6},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Pollux_attack_general"}
},
[1349028111]={
effect="cast0_hit",time=4000,type=0,pos_ref={ref_type=4,part_index=1}
}
};

return this;