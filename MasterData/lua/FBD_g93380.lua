--FireBall数据
local this = 
{
[-686817241]={
{delay=1000,time=3000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hit_creates={1192467788},hits={0,500,1000}},
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6}},
{time=3000,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="93380_cast_01"}
},
[1192467788]={
time=1800,type=0
},
[-1609092943]={
{time=1500,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="93380_cast_00"},
{effect="cast0_eff",time=1500,type=0,pos_ref={ref_type=6}},
{delay=700,time=1800,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hit_creates={1349028111},hits={0}}
},
[1349028111]={
effect="cast0_hit",time=1500,type=0,pos_ref={ref_type=4,part_index=1}
}
};

return this;