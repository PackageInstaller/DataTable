--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",time=2500,type=0,pos_ref={ref_type=6}},
{delay=780,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_02",hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={-646510353},hits={0}},
{delay=1400,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_01",hit_type=1,camera_shake={time=200,shake_dir=1,range=200,range1=100,hz=30,decay_value=0.25},hit_creates={930703811,-1368377223},hits={0}},
{delay=300,time=2500,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="romaz4_attack_skill_01"}
},
[-646510353]={
effect="common_hit1",effect_pack="common_hit",time=2500,type=0,pos_ref={ref_type=1}
},
[-1368377223]={
effect="cast1_hit",delay=200,time=2500,type=0,pos_ref={ref_type=1}
},
[930703811]={
effect="qc_common_medium_hit",effect_pack="common_hit",time=2500,type=0,pos_ref={ref_type=1}
},
[-1609092943]={
{effect="cast0_eff",delay=900,time=2000,type=0,pos_ref={ref_type=6}},
{delay=930,time=2000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=200,range1=100,hz=30,decay_value=0.25},hit_creates={1349028111},hits={0}},
{delay=500,time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="romaz4_attack_general"}
},
[1349028111]={
effect="qc_common_medium_hit",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;