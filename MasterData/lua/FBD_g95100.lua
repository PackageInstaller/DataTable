--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6}},
{time=3500,type=0},
{time=3500,type=4,hit_creates={806661594},hits={1500}},
{time=2000,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="95100_cast_01"}
},
[806661594]={
time=3500,type=0
},
[1310282141]={
{delay=610,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={2124325257},hits={0}},
{effect="cast2_eff",time=2000,type=0,pos_ref={ref_type=6}},
{time=2000,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="95100_cast_02"}
},
[2124325257]={
effect="cast2_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1609092943]={
{delay=700,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={-1100552157},hits={0}},
{effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/monsters_cast.acb",cue_name="romaz4_attack_general"}
},
[-1100552157]={
effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=1}
}
};

return this;