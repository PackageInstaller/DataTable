--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=20000,type=0,pos_ref={ref_type=10},cue_sheet="fight/effect/eleventh.acb",cue_name="Nebula_attack_skill_02"},
{effect="cast2_hit",delay=3900,time=20000,type=0,pos_ref={ref_type=3}},
{delay=4000,time=6000,type=1,hit_type=0,hits={0}},
{delay=4100,time=6000,type=1,hit_type=0,hits={0}},
{delay=4550,time=6000,type=1,hit_type=0,hits={0}},
{delay=4650,time=6000,type=1,hit_type=0,hits={0}},
{delay=4750,time=6000,type=1,hit_type=0,hits={0}},
{delay=4850,time=6000,type=1,hit_type=0,hits={0}},
{delay=18000,time=6000,type=1,hit_type=1,hits={0}}
},
[-686817241]={
{effect="cast1_eff",time=2800,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/eleventh.acb",cue_name="Nebula_attack_skill_01"},
{delay=1500,time=3000,type=1,hit_type=0,camera_shake={time=800,shake_dir=1,range=300,range1=144,range2=30,hz=15,decay_value=0.3},hit_creates={806661594},hits={0}}
},
[806661594]={
effect="cast1_hit",time=2800,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/eleventh.acb",cue_name="Nebula_attack_general"},
{delay=800,time=2000,type=1,hit_type=0,camera_shake={time=330,shake_dir=1,range=300,range2=25,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{delay=1550,time=2000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=350,range1=150,range2=25,hz=30,decay_value=0.3},hits={0}}
},
[661633433]={
effect="cast0_hit",delay=700,time=2000,type=0,pos_ref={ref_type=1}
},
[-1328923786]={
{effect="win_eff",time=4000,type=0,pos_ref={ref_type=6}}
}
};

return this;