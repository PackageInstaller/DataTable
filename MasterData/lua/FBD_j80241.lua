--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=13800,type=0,pos_ref={ref_type=6}},
{time=15000,type=1,hit_type=1,hits={6000,7000,8000,12000}},
{effect="cast2_hit",time=13800,type=0,pos_ref={ref_type=1,offset_row=-250}}
},
[-686817241]={
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6}},
{time=3500,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,range2=200,hz=60,decay_value=0.6},hit_creates={1192467788},hits={200,900}},
{effect="cast1_hit02",time=3500,type=0,pos_ref={ref_type=3,offset_row=-300}},
{time=3500,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=300,range2=300,hz=100,decay_value=0.6},hits={1800}}
},
[1192467788]={
effect="cast1_hit01",time=3500,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1609092943]={
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6}},
{time=3500,type=1,hit_type=0,camera_shake={time=150,shake_dir=1,range=150,range2=150,hz=50,decay_value=0.5},hit_creates={-838067028},hits={300}},
{time=3500,type=1,hit_type=0,camera_shake={time=150,shake_dir=1,range=150,range2=150,hz=50,decay_value=0.5},hit_creates={-1190450118},hits={600}}
},
[-1190450118]={
effect="cast0_hit02",time=3500,type=0,pos_ref={ref_type=1}
},
[-838067028]={
effect="cast0_hit01",time=3500,type=0,pos_ref={ref_type=1}
},
[2122942999]={
{time=3500,type=0}
},
[-1328923786]={
{time=3500,type=0}
}
};

return this;