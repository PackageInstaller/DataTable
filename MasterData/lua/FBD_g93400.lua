--FireBall数据
local this = 
{
[-686817241]={
{time=3000,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="93400_cast_01"},
{time=3000,type=1,hit_type=0,is_fake=1,hit_creates={-1457652640},hits={0}},
{time=3000,type=1,hit_type=0,hit_creates={1192467788},hits={1300,1500,1700}}
},
[-1457652640]={
effect="cast1_eff",effect_no_flip=1,time=3000,path_index=100,type=0,pos_ref={ref_type=6}
},
[1192467788]={
effect="cast1_hit",time=800,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1609092943]={
{time=1800,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="93400_cast_00"},
{delay=850,time=1800,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=100,range2=100,hz=200,decay_value=0.6},hits={0}},
{effect="cast0_hit",effect_no_flip=1,time=1800,type=0,pos_ref={ref_type=1}}
}
};

return this;