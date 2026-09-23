--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",delay=150,time=2000,type=0,pos_ref={ref_type=6}},
{effect="common_hit1",effect_pack="common_hit",delay=450,time=2000,type=1,pos_ref={ref_type=1},hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="roma3_attack_skill_01"}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6}},
{delay=300,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={1349028111},hits={0}},
{delay=100,time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="roma3_attack_general"}
},
[1349028111]={
effect="common_hit1",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=4,offset_height=17,part_index=0}
}
};

return this;