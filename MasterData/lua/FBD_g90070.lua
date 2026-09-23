--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_paralytic",effect_pack="device",time=4000,type=0,pos_ref={ref_type=6}},
{delay=1800,time=3000,type=1,hit_type=0,camera_shake={time=600,shake_dir=1,range=600,range1=100,range2=100,hz=30,decay_value=0.3},hits={0}},
{effect="cast1_paralytic2",effect_pack="device",time=4000,type=0,pos_ref={ref_type=3,offset_row=-400}},
{delay=100,time=4000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="device3_attack_skill_01"}
},
[-1609092943]={
{time=2000,type=3,hits={300,400,500}},
{delay=500,time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="device_buff"}
}
};

return this;