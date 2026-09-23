--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",delay=600,time=4000,type=0,pos_ref={ref_type=6}},
{delay=650,time=4000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=200,range1=200,hz=30,decay_value=0.25},hit_creates={1192467788},hits={0}},
{delay=400,time=4000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="Shaping3_attack_skill_01"}
},
[1192467788]={
effect="qc_common_medium_hit",effect_pack="common_hit",time=4000,type=0,pos_ref={ref_type=4,part_index=0},cue_sheet="fight/effect/sword_hit.acb",cue_name="sword_hit_02"
},
[-1609092943]={
{effect="cast0_eff",delay=600,time=2000,type=0,pos_ref={ref_type=6}},
{delay=540,time=4000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{delay=100,time=2500,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="Shaping3_attack_general"}
},
[661633433]={
effect="common_hit1",effect_pack="common_hit",time=4000,type=0,pos_ref={ref_type=4,part_index=0},cue_sheet="fight/effect/sword_hit.acb",cue_name="sword_hit_01"
}
};

return this;