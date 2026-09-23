--FireBall数据
local this = 
{
[1310282141]={
{effect="cast1_buff1",effect_pack="d70400",time=9000,type=2,pos_ref={ref_type=13},hits={0}},
{time=11000,type=0},
{delay=10000,time=11000,type=3,hits={0}},
{effect="cast2_eff1",effect_pack="d70400",delay=7800,time=9000,type=0,pos_ref={ref_type=13}},
{delay=10000,time=11000,type=2,hits={0}}
},
[-686817241]={
{time=9000,type=3,hit_creates={-1457652640},hits={0}},
{delay=1500,time=9000,type=3,hit_creates={1192467788},hits={0}}
},
[-1457652640]={
effect="cast1_buff",effect_pack="d70400",time=9000,type=0,pos_ref={ref_type=4,part_index=1}
},
[1192467788]={
effect="cast1_buff1",effect_pack="d70400",time=9000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1609092943]={
{delay=1200,time=9000,type=1,hit_type=0,camera_shake={time=160,shake_dir=1,range=200,hz=350,decay_value=0.25},hits={0,200}},
{effect="cast0_hit",effect_pack="d70400",delay=1250,time=9000,type=0,pos_ref={ref_type=1}},
{effect="cast0_eff",effect_pack="d70400",time=9000,type=0,pos_ref={ref_type=6}}
}
};

return this;