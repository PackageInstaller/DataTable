--FireBall数据
local this = 
{
[1192467788]={
effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-686817241]={
{delay=965,time=3000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=400,range1=300,range2=100,hz=30,decay_value=0.25},hit_creates={806661594},hits={0}},
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6}},
{delay=400,time=3000,type=0},
{delay=1145,time=3000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=400,range1=300,range2=100,hz=30,decay_value=0.25},hit_creates={1192467788},hits={0}},
{delay=1370,time=3000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=600,range1=600,range2=600,hz=30,decay_value=0.25},hit_creates={-646510353},hits={0}},
{time=3000,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="95080_cast_01"}
},
[806661594]={
effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-646510353]={
effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{delay=1095,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=200,range1=50,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}},
{effect="cast0_eff",delay=350,time=1800,type=0,pos_ref={ref_type=6}},
{delay=350,time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="romaz3_attack_general"}
},
[661633433]={
effect="cast0_hit",time=1800,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;