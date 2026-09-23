--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="cv/CrimsonFog.acb",cue_name="CrimsonFog_11",cue_feature=1},
{time=5000,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="Crimson_Fog_attack_skill_02"},
{effect="cast2_hit",time=6000,type=0,pos_ref={ref_type=3}},
{delay=2300,time=5000,type=1,hit_type=1,camera_shake={time=1000,shake_dir=1,range=400,range1=300,range2=25,hz=30,decay_value=0.3},hits={0}}
},
[-686817241]={
{time=3000,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="Crimson_Fog_attack_skill_01"},
{delay=1100,time=3000,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=100,range1=50,range2=10,hz=30,decay_value=0.3},hit_creates={1192467788},hits={0}},
{effect="cast1_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="cv/CrimsonFog.acb",cue_name="CrimsonFog_10",cue_feature=1,path_target={ref_type=1}},
{delay=1200,time=2000,type=1,hit_type=0,hits={0}}
},
[1192467788]={
effect="cast1_hit",time=4000,type=0,pos_ref={ref_type=4,part_index=1}
},
[661633433]={
effect="qc_common_medium_hit",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{delay=700,time=2000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=500,range2=25,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/CrimsonFog.acb",cue_name="CrimsonFog_09",cue_feature=1},
{time=1500,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="Crimson_Fog_attack_general"}
},
[1475746508]={
delay=400,time=2000,type=1,hit_type=0,hits={0}
},
[958292235]={
{effect="cast3_hit",time=1500,type=0,pos_ref={ref_type=7,part_index=0}}
}
};

return this;