--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",time=2000,type=0,pos_ref={ref_type=6}},
{effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=1}},
{delay=400,time=2000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={-1368377223},hits={0}},
{delay=300,time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="harpie2_attack_skill_01"}
},
[-1368377223]={
effect="qc_common_medium_hit",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6}},
{effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=1}},
{delay=500,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,range1=40,hz=30,decay_value=0.25},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="harpie2_attack_general"}
}
};

return this;