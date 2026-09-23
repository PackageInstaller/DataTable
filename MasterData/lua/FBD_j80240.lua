--FireBall数据
local this = 
{
[-686817241]={
{delay=1500,time=4000,type=1,hit_type=1,hits={600}},
{delay=1500,time=4000,type=1,hit_type=1,camera_shake={time=900,shake_dir=1,range=300,range2=300,hz=60,decay_value=0.6},hits={0}},
{delay=1500,time=4000,type=1,hit_type=1,hits={300}},
{effect="cast1_hit",delay=1500,time=2000,type=0,pos_ref={ref_type=2,offset_row=-100}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Schwarz_attack_skill_01"}
},
[1310282141]={
{time=15000,type=1,hit_type=1,hit_creates={2124325257},hits={2000,2600,4200,10000}},
{effect="cast2_eff",time=12268,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Schwarz_attack_skill_02"}
},
[2124325257]={
time=2000,type=0
},
[-1609092943]={
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Schwarz_attack_general"},
{time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range1=5,range2=300,hz=50,decay_value=0.5},hit_creates={-1190450118},hits={1100}},
{time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range2=300,hz=60,decay_value=0.5},hit_creates={1349028111},hits={460}}
},
[1349028111]={
effect="cast0_hit01",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1190450118]={
effect="cast0_hit02",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[2122942999]={
{effect="enter",time=10000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/Schwarz_enter.acb",cue_name="Schwarz_enter"}
}
};

return this;