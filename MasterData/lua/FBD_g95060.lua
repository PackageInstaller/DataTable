--FireBall数据
local this = 
{
[1192467788]={
effect="cast1_hit",time=1800,type=0,pos_ref={ref_type=4,part_index=1}
},
[-686817241]={
{time=1800,type=1,hit_type=0,camera_shake={time=100,shake_dir=1,range=200,hz=10,decay_value=0.6},hit_creates={1192467788},hits={1229,1409}},
{effect="cast1_eff",time=1800,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{time=2300,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="95060_cast_01"}
},
[661633433]={
effect="cast0_hit",time=1500,type=0,pos_ref={ref_type=4,part_index=2}
},
[-1609092943]={
{delay=751,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,range1=50,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}},
{effect="cast0_eff",time=1500,path_index=0,type=0,pos_ref={ref_type=6},path_target={ref_type=1,offset_row=100}},
{time=1500,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="95060_cast_00"}
}
};

return this;