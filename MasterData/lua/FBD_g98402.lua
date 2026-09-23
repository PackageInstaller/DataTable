--FireBall数据
local this = 
{
[-686817241]={
{time=4000,type=1,hit_type=1,camera_shake={time=600,shake_dir=1,range=220,range2=100,hz=400,decay_value=0.45},hit_creates={1192467788},hits={1900}},
{effect="cast1_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Castor_attack_skill_01"},
{effect="cast1_hit",time=4000,type=0,pos_ref={ref_type=0,offset_row=150,lock_row=1}}
},
[1192467788]={
time=4000,type=0
},
[1310282141]={
{delay=3100,time=4000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hit_creates={-520473558},hits={0,220}},
{effect="cast2_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Castor_attack_skill_02"},
{effect="cast2_hit",delay=3150,time=4000,type=0,pos_ref={ref_type=3}}
},
[-520473558]={
effect="cast2_hit1",time=4000,type=0,pos_ref={ref_type=4,part_index=1}
},
[958292235]={
{effect="cast3_eff",time=10000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Castor_attack_skill_03"},
{delay=8000,time=4000,type=1,hit_type=0,hit_creates={1776661962},hits={0,200,400,1000}}
},
[1776661962]={
time=9000,type=0
},
[-1609092943]={
{time=4000,type=1,hit_type=1,camera_shake={time=260,shake_dir=1,range=330,range1=100,hz=200,decay_value=0.25},hit_creates={1349028111},hits={800}},
{effect="cast0_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Castor_attack_general"}
},
[1349028111]={
time=4000,type=0
}
};

return this;