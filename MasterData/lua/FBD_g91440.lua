--FireBall数据
local this = 
{
[1192467788]={
time=5000,type=0
},
[-686817241]={
{effect="cast_hit",time=5000,type=0,pos_ref={ref_type=6}},
{delay=1000,time=5000,type=1,hit_type=0,hit_creates={1192467788},hits={0}}
},
[-1609092943]={
{time=5000,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="91440_cast_00"},
{effect="cast0_eff",time=5000,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{delay=900,time=5000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hit_creates={1349028111},hits={0,650}}
},
[1349028111]={
effect="cast0_hit",time=5000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-316323548]={
{effect="dead",time=3000,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",time=3000,type=0,pos_ref={ref_type=6}}
}
};

return this;