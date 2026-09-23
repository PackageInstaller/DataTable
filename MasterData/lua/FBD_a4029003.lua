--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",effect_pack="a40290",time=2800,type=0,pos_ref={ref_type=6},cue_sheet="cv/Rain.acb",cue_name="Rain_11",cue_feature=1},
{time=6000,type=3,work_delay=300,hit_creates={2124325257,-1745025860},hits={3300}},
{time=6000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="rain_attack_skill_02"}
},
[2124325257]={
effect="cast2_hit",effect_pack="a40290",time=3700,type=0,pos_ref={ref_type=4,part_index=0},dont_remove_when_skip=1
},
[-1745025860]={
effect="qc_buff_hit",effect_pack="common_hit",time=3700,type=0,pos_ref={ref_type=4,part_index=0},dont_remove_when_skip=1
},
[-686817241]={
{effect="cast1_eff",effect_pack="a40290",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Rain.acb",cue_name="Rain_10",cue_feature=1},
{time=2000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="rain_attack_skill_01"}
},
[-1190450118]={
effect="qc_shoot_hit1",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=1}
},
[661633433]={
effect="cast0_hit",effect_pack="a40290",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{delay=760,time=2000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="water_hit_02",hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hit_creates={-1190450118,661633433},hits={0}},
{effect="cast0_eff",effect_pack="a40290",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Rain.acb",cue_name="Rain_09",cue_feature=1,path_target={ref_type=1}},
{time=2000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="rain_attack_general"}
}
};

return this;