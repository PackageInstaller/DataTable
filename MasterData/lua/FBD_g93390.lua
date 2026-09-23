--FireBall数据
local this = 
{
[-686817241]={
{time=3000,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="93390_cast_01"},
{effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=10}},
{time=3000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hits={1400,1633,2066}},
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=3}}
},
[2124325257]={
time=3000,type=0
},
[1310282141]={
{delay=700,time=3000,type=3,hit_creates={2124325257},hits={0}},
{time=3000,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="93390_cast_02"}
},
[-1609092943]={
{time=1800,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="93390_cast_00"},
{delay=1000,time=1800,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",time=1800,type=0,pos_ref={ref_type=6},path_target={ref_type=1}}
},
[1349028111]={
effect="cast0_hit",time=1800,type=0,pos_ref={ref_type=0}
}
};

return this;