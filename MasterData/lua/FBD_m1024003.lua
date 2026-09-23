--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",effect_pack="m10240",time=4210,type=0,pos_ref={ref_type=6}},
{time=6200,type=3,hits={4200}},
{delay=2800,time=4210,type=0,cue_sheet="cv/pyroxene.acb",cue_name="pyroxene_06",cue_feature=1},
{delay=233,time=4210,type=0,cue_sheet="cv/pyroxene.acb",cue_name="pyroxene_11",cue_feature=1},
{time=6200,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="Pyroxene_attack_skill_02"}
},
[-686817241]={
{time=3500,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="Pyroxene_attack_skill_01"},
{delay=1000,time=3100,type=3,hit_creates={-646510353},hits={0}},
{delay=1000,time=3100,type=3,hits={0}},
{effect="cast1_eff",effect_pack="m10240",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="cv/pyroxene.acb",cue_name="pyroxene_10",cue_feature=1}
},
[-646510353]={
effect="cast1_hit",effect_pack="m10240",time=3500,type=0,pos_ref={ref_type=4,part_index=0}
},
[661633433]={
effect="cast0_hit",effect_pack="m10240",time=2000,type=0,pos_ref={ref_type=4,offset_row=25,offset_height=-50,part_index=0}
},
[-1609092943]={
{time=2400,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="Pyroxene_attack_general"},
{delay=1600,time=2000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=400,range2=400,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{effect="cast0_eff",effect_pack="m10240",time=2400,type=0,pos_ref={ref_type=0,offset_row=90},cue_sheet="cv/pyroxene.acb",cue_name="pyroxene_09",cue_feature=1}
}
};

return this;