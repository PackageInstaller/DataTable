--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff2",effect_pack="g90040",delay=300,time=2000,type=0,pos_ref={ref_type=6}},
{time=2000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={-1368377223},hits={1000}},
{time=2000,type=1,hit_type=0,camera_shake={time=30,shake_dir=1,range=200,hz=200,decay_value=0.25},hit_creates={930703811},hits={1250}},
{time=2000,type=1,hit_type=0,camera_shake={time=30,shake_dir=1,range=200,hz=200,decay_value=0.25},hit_creates={1082022229},hits={1500}},
{time=3000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="robot3_attack_skill_01"}
},
[-1368377223]={
effect="qc_shoot_hit1",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=4,offset_height=-50,part_index=0},cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04"
},
[930703811]={
effect="qc_shoot_hit1",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=4,offset_height=-50,part_index=0},cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04"
},
[1082022229]={
effect="qc_shoot_hit1",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=4,offset_height=-50,part_index=0},cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04"
},
[-1609092943]={
{effect="cast0_eff2",effect_pack="g90040",delay=850,time=2000,type=0,pos_ref={ref_type=6}},
{delay=900,time=3000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_03",hit_type=0,camera_shake={time=400,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}},
{delay=1100,time=3000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_03",hit_type=0,camera_shake={time=400,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={1349028111},hits={0}},
{time=4000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="robot3_attack_general"}
},
[661633433]={
effect="qc_shoot_hit1",effect_pack="common_hit",time=3000,type=0,pos_ref={ref_type=4,offset_height=-70,part_index=0}
},
[1349028111]={
effect="qc_shoot_hit1",effect_pack="common_hit",time=3000,type=0,pos_ref={ref_type=4,offset_height=-70,part_index=0}
}
};

return this;