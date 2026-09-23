--FireBall数据
local this = 
{
[1310282141]={
{time=4000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="elegy_attact_skill_02"},
{effect="cast2_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Elegy.acb",cue_name="Elegy_11",cue_feature=1},
{effect="cast2_hit",delay=2900,time=4000,type=0,pos_ref={ref_type=3}},
{delay=2900,time=5000,type=1,hit_type=1,camera_shake={time=600,shake_dir=1,range=350,range1=200,range2=25,hz=30,decay_value=0.3},hits={0}}
},
[-686817241]={
{effect="cast1_eff2",delay=1800,time=3000,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{time=2000,type=0,cue_sheet="cv/Elegy.acb",cue_name="Elegy_10",cue_feature=1},
{delay=300,time=2000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="elegy_attact_skill_01"},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6}},
{time=3000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=400,range1=100,range2=25,hz=30,decay_value=0.3},hit_creates={1192467788},hits={2100}}
},
[1192467788]={
effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-838067028]={
effect="qc_music_hit1",effect_pack="common_hit",time=1000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Elegy.acb",cue_name="Elegy_09",cue_feature=1},
{time=2000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="elegy_attact_general"},
{time=2000,type=1,hit_type=0,camera_shake={time=190,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hit_creates={-838067028},hits={550,750}}
}
};

return this;