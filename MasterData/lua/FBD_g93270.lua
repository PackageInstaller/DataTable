--FireBall数据
local this = 
{
[-601574123]={
{time=2000,type=0}
},
[-686817241]={
{delay=2000,time=5000,type=1,hit_type=0,hits={0,200,300,400,500}},
{delay=1800,time=5000,type=1,hit_type=0,camera_shake={time=1000,shake_dir=1,range=300,range2=300,hz=100,decay_value=0.6},hits={0}},
{effect="cast1_hit",time=5000,type=0,pos_ref={ref_type=3}},
{time=4300,type=0,cue_sheet="fight/effect/thirteen.acb",cue_name="Betis' Oracle_attack_skill_01"},
{effect="cast1_eff",time=2300,type=0,pos_ref={ref_type=6}}
},
[1310282141]={
{effect="cast2_hit",time=8000,type=0,pos_ref={ref_type=3}},
{delay=1600,time=12000,type=1,hit_type=0,camera_shake={time=1200,shake_dir=1,range=80,range2=80,hz=100,decay_value=0.5},hits={0}},
{delay=3700,time=12000,type=1,hit_type=0,hits={0,100,100,100,100,100,100}},
{effect="cast2_eff",time=4000,type=0,pos_ref={ref_type=6}},
{delay=3600,time=12000,type=1,hit_type=0,camera_shake={time=600,shake_dir=1,range=300,range2=300,hz=200,decay_value=0.5},hits={0}},
{delay=1700,time=12000,type=1,hit_type=0,hits={0}},
{time=5000,type=0,cue_sheet="fight/effect/thirteen.acb",cue_name="Betis' Oracle_attack_skill_02"},
{delay=1900,time=12000,type=1,hit_type=0,hits={0}},
{delay=1800,time=12000,type=1,hit_type=0,hits={0}}
},
[-1609092943]={
{delay=600,time=3500,type=1,hit_type=0,camera_shake={time=1400,shake_dir=1,range=80,range2=80,hz=60,decay_value=0.6},hit_creates={661633433},hits={0}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=0,offset_row=-450,lock_col=1},cue_sheet="fight/effect/thirteen.acb",cue_name="Betis' Oracle_attack_general"},
{delay=900,time=3500,type=1,hit_type=0,hits={0}},
{delay=1200,time=3500,type=1,hit_type=0,hits={0}}
},
[661633433]={
time=2000,type=0
},
[-1183793042]={
{effect="enter",time=2000,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",time=2000,type=0,pos_ref={ref_type=6}}
},
[958292235]={
{delay=1200,time=5000,type=1,hit_type=0,hits={0}},
{effect="cast3_hit",time=5000,type=0,pos_ref={ref_type=1}},
{effect="cast3_eff",time=3500,type=0,pos_ref={ref_type=6},path_target={ref_type=1}}
},
[-1485114200]={
{time=3500,type=0}
}
};

return this;