--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff3",time=2000,type=0,pos_ref={ref_type=6}},
{delay=1300,time=2300,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_02",hit_type=1,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={806661594},hits={0}},
{delay=300,time=3000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="robot4_attack_skill_01"}
},
[806661594]={
effect="qc_shoot_hit1",effect_pack="common_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{effect="cast0_eff3",time=2000,type=0,pos_ref={ref_type=6}},
{delay=650,time=4000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_01",hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}},
{delay=800,time=4000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_01",hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={1349028111},hits={0}},
{delay=1350,time=4000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_01",hit_type=0,camera_shake={time=300,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={-838067028},hits={0}},
{time=4000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="robot4_attack_general"}
},
[661633433]={
effect="qc_shoot_hit1",effect_pack="common_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[1349028111]={
effect="qc_shoot_hit1",effect_pack="common_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-838067028]={
effect="qc_shoot_hit1",effect_pack="common_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;