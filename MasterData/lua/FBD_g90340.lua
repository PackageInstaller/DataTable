--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6}},
{time=3500,type=4,hit_creates={1192467788},hits={1500}},
{time=3500,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="romaz4_attack_skill_01"}
},
[1192467788]={
effect="cast1_hit",time=3500,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6}},
{delay=600,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={1349028111},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="romaz4_attack_general"}
},
[1349028111]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=1}
}
};

return this;