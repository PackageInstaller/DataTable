--FireBall数据
local this = 
{
[1192467788]={
effect="cast1_hit",time=1800,type=0,pos_ref={ref_type=4,part_index=1}
},
[-686817241]={
{time=1800,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=100,hz=200,decay_value=0.5},hit_creates={1192467788},hits={666,866}},
{effect="cast1_eff",time=1800,type=0,pos_ref={ref_type=6}},
{time=2100,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="95050_cast_01"}
},
[661633433]={
effect="cast0_hit",time=1500,type=0,pos_ref={ref_type=4,part_index=2}
},
[-1609092943]={
{delay=400,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,range1=50,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}},
{effect="cast0_eff",time=1500,type=0,pos_ref={ref_type=6}},
{delay=200,time=3000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="roma1_attack_general"}
}
};

return this;