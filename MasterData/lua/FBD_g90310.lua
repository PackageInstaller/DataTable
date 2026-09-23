--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",delay=880,time=2500,type=0,pos_ref={ref_type=6}},
{delay=580,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_01",hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hits={0}},
{effect="cast1_hit",delay=550,time=2500,type=0,pos_ref={ref_type=1}},
{delay=970,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_02",hit_type=1,camera_shake={time=200,shake_dir=1,range=200,range1=100,hz=30,decay_value=0.25},hit_creates={-1368377223},hits={0}},
{effect="qc_common_medium_hit",effect_pack="common_hit",delay=940,time=2500,type=0,pos_ref={ref_type=1}}
},
[-1368377223]={
effect="cast1_hit2",time=2500,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6}},
{delay=600,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_02",hit_type=0,camera_shake={time=200,shake_dir=1,range=200,range1=100,hz=30,decay_value=0.25},hits={0}},
{effect="cast0_hit",delay=580,time=2000,type=0,pos_ref={ref_type=1}}
}
};

return this;