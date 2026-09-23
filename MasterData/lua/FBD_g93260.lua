--FireBall数据
local this = 
{
[-686817241]={
{time=2000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hit_creates={806661594},hits={500,800,1100}},
{effect="cast1_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Betis' Visionary_attack_skill_01"}
},
[806661594]={
effect="cast1_hit",delay=200,time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[1310282141]={
{delay=3700,time=12000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hits={200,400,600,800,1000}},
{effect="cast2_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Betis' Visionary_attack_skill_02",path_target={ref_type=3}},
{effect="cast2_hit",delay=3700,time=12000,type=0,pos_ref={ref_type=3,offset_row=-507}},
{delay=3500,time=12000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hits={0}}
},
[-1609092943]={
{time=2000,type=0,cue_sheet="fight/effect/thirteen.acb",cue_name="Betis' Visionary_attack_general"},
{delay=930,time=2000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{effect="cast0_eff",delay=930,time=2000,type=0,pos_ref={ref_type=6}}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,offset_row=-150,part_index=0}
}
};

return this;