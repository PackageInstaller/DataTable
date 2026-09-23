--FireBall数据
local this = 
{
[-686817241]={
{time=4000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="device8_attack_skill_01"},
{effect="cast1_eff",time=5000,type=0,pos_ref={ref_type=6}},
{delay=1400,time=5000,type=1,hit_type=1,camera_shake={time=700,shake_dir=1,range=400,range2=100,hz=20,decay_value=0.33},hits={0}},
{effect="cast1_hit",delay=900,time=5000,type=0,pos_ref={ref_type=3}}
},
[-1609092943]={
{time=2000,type=3,hits={300,400,500}},
{delay=500,time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="device_buff"}
}
};

return this;