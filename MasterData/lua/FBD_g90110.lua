--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_ice",effect_pack="device",time=4000,type=0,pos_ref={ref_type=6}},
{effect="cast1_ice2",effect_pack="device",delay=200,time=4000,type=0,pos_ref={ref_type=3,offset_row=-400}},
{delay=2000,time=2100,type=1,hit_type=0,camera_shake={time=600,shake_dir=1,range=500,range1=100,range2=100,hz=30,decay_value=0.3},hits={0}},
{time=4000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="device1_attack_skill_01"}
},
[-1609092943]={
{time=2000,type=3,hits={300,400,500}},
{delay=500,time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="device_buff"}
}
};

return this;