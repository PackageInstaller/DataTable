--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6,offset_row=100}},
{delay=300,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hits={0}},
{delay=300,time=3000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="roma1_attack_skill_01"}
},
[-1609092943]={
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=6}},
{delay=530,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hits={0}},
{delay=200,time=3000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="roma1_attack_general"}
}
};

return this;