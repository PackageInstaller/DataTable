--FireBall数据
local this = 
{
[1192467788]={
effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-686817241]={
{time=3000,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="93370_cast_01"},
{delay=1000,time=3000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hit_creates={1192467788},hits={0,500,1000}},
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6}}
},
[-1609092943]={
{effect="cast0_eff",delay=200,time=5000,type=0,pos_ref={ref_type=6},path_target={ref_type=0}},
{effect="cast0_hit",delay=130,time=1800,type=0,pos_ref={ref_type=1,offset_height=-50}},
{time=1800,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=50,range2=50,hz=10,decay_value=0.6},hits={500}},
{time=5000,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="93370_cast_00"}
}
};

return this;