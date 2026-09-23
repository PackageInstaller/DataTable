--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=8500,type=0,pos_ref={ref_type=10,offset_row=-450},cue_sheet="fight/effect/eleventh.acb",cue_name="Cordillera_attack_skill_02"},
{delay=8500,time=3000,type=3,hits={0}},
{delay=6500,time=3000,type=1,hit_type=0,hits={0}},
{delay=7000,time=3000,type=1,hit_type=1,hits={0}}
},
[-686817241]={
{effect="cast1_eff",time=20000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/eleventh.acb",cue_name="Cordillera_attack_skill_01"},
{time=5000,type=3,is_fake=1,hit_creates={806661594},hits={0}},
{delay=2500,time=5000,type=3,hits={0}}
},
[806661594]={
effect="cast1_buff",time=3000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1609092943]={
{delay=733,time=2000,type=1,hit_type=0,camera_shake={time=250,shake_dir=1,range=100,range1=100,range2=25,hz=30,decay_value=0.5},hits={0}},
{effect="cast0_hit_2",delay=1233,time=2000,type=0,pos_ref={ref_type=5,lock_col=1}},
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/eleventh.acb",cue_name="Cordillera_attack_general"},
{effect="cast0_hit_1",delay=733,time=2000,type=0,pos_ref={ref_type=5,lock_col=1}},
{delay=1233,time=2000,type=3,hits={0}},
{delay=1233,time=2000,type=1,hit_type=0,camera_shake={time=250,shake_dir=1,range=100,range1=100,range2=25,hz=30,decay_value=0.5},hits={0}}
}
};

return this;