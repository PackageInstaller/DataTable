--FireBall数据
local this = 
{
[1310282141]={
{delay=6500,time=2000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=500,range1=100,range2=100,hz=30,decay_value=0.3},hits={0}},
{effect="cast2_eff2",time=7300,type=0,pos_ref={ref_type=10}},
{delay=5700,time=2000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=500,range1=100,range2=100,hz=30,decay_value=0.3},hits={0}},
{delay=5900,time=2000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=500,range1=100,range2=100,hz=30,decay_value=0.3},hits={0}},
{delay=5500,time=2000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=500,range1=100,range2=100,hz=30,decay_value=0.3},hits={0}},
{effect="cast2_eff",time=7300,type=0,pos_ref={ref_type=3,offset_row=-850,lock_col=1},cue_sheet="fight/effect/nineth.acb",cue_name="warlock_attack_skill_02"}
},
[-686817241]={
{effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=7,offset_height=-10,part_index=1}},
{effect="cast1_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/nineth.acb",cue_name="warlock_attack_skill_01"},
{delay=1300,time=2000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=500,range2=25,hz=30,decay_value=0.3},hits={0}}
},
[-1609092943]={
{effect="cast0_eff",time=1700,type=0,pos_ref={ref_type=6,offset_row=-75,offset_height=200},cue_sheet="fight/effect/nineth.acb",cue_name="warlock_attack_general"},
{delay=750,time=5000,type=1,hit_type=0,camera_shake={time=250,shake_dir=1,range=600,range1=30,range2=600,hz=200,decay_value=0.6},hits={0}},
{effect="cast0_hit",delay=750,time=1700,type=0,pos_ref={ref_type=1}}
},
[958292235]={
{effect="cast3_hit",delay=650,time=2000,type=0,pos_ref={ref_type=7,offset_height=120,part_index=1}},
{time=5000,type=0,cue_sheet="fight/effect/nineth.acb",cue_name="warlock_passive"},
{effect="cast3_eff",delay=560,time=5000,type=0,pos_ref={ref_type=6,offset_row=-75,offset_height=200}},
{delay=800,time=2000,type=1,hit_type=1,camera_shake={time=250,shake_dir=1,range=500,range2=25,hz=30,decay_value=0.3},hits={0}}
}
};

return this;