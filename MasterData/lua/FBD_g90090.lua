--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_sleep",effect_pack="device",time=3000,type=0,pos_ref={ref_type=6}},
{delay=2200,time=4000,type=1,hit_type=0,camera_shake={time=600,shake_dir=1,range=600,range1=100,range2=100,hz=30,decay_value=0.3},hits={0}},
{effect="cast1_sleep2",effect_pack="device",delay=500,time=4000,type=0,pos_ref={ref_type=3}},
{time=4000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="device5_attack_skill_01"}
},
[-1609092943]={
{time=2000,type=3,hits={300,400,500}},
{delay=500,time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="device_buff"}
}
};

return this;