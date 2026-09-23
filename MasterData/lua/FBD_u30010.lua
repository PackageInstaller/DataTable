--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=12000,type=0,pos_ref={ref_type=6,offset_row=-350},cue_sheet="fight/effect/thrid.acb",cue_name="dinocrocuta_shoot_attack_skill_02"},
{effect="cast2_hit",time=12000,type=0,pos_ref={ref_type=3}},
{time=12000,type=1,hit_type=1,camera_shake={time=350,shake_dir=1,range=400,range2=25,hz=30,decay_value=0.3},hits={7300,7900}},
{time=12000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=500,range2=25,hz=30,decay_value=0.3},hits={8300}},
{time=12000,type=1,hit_type=1,camera_shake={time=1500,shake_dir=1,range=500,range1=100,range2=100,hz=30,decay_value=0.3},hits={9000,9300,9600}}
},
[-686817241]={
{effect="cast1_eff",time=4000,path_index=0,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="dinocrocuta_shoot_attack_skill_01",path_target={ref_type=1}},
{effect="cast1_hit",delay=2000,time=5000,type=0,pos_ref={ref_type=1}},
{delay=2200,time=4000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="rock_exploImpac_1",hit_type=0,camera_shake={time=800,shake_dir=1,range=400,range1=100,range2=100,hz=30,decay_value=0.6},hits={0}},
{delay=2300,time=4000,type=1,hit_type=0,hits={0}},
{delay=2400,time=4000,type=1,hit_type=0,hits={0}},
{delay=2500,time=4000,type=1,hit_type=1,hits={0}}
},
[-1609092943]={
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="dinocrocuta_shoot_attack_general"},
{delay=900,time=3000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=1,camera_shake={time=500,shake_dir=1,range=500,range2=100,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}}
},
[661633433]={
effect="cast0_hit",time=3000,type=0,pos_ref={ref_type=0,offset_row=50}
},
[-1183793042]={
{time=3000,type=0}
},
[-1328923786]={
{time=3000,type=0}
}
};

return this;