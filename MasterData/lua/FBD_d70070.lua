--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",delay=233,time=7000,type=0,pos_ref={ref_type=6}},
{delay=3233,time=7000,type=0,cue_sheet="cv/Athena.acb",cue_name="Athena_08",cue_feature=1},
{delay=233,time=7000,type=0,cue_sheet="fight/effect/athena_cast.acb",cue_name="athena_attack_skill_02"},
{delay=4233,time=7000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="Explode_Texture_02",hit_type=1,camera_shake={time=800,shake_dir=1,range=300,range1=300,range2=300,hz=30,decay_value=0.3},hits={0}},
{time=7000,type=0,cue_sheet="cv/Athena.acb",cue_name="Athena_11",cue_feature=1},
{delay=5233,time=7000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="Explode_Texture_01",hit_type=1,camera_shake={time=1000,shake_dir=1,range=500,range1=500,range2=500,hz=30,decay_value=0.3},hits={0}}
},
[-686817241]={
{time=2000,type=0,cue_sheet="fight/effect/athena_cast.acb",cue_name="athena_attack_skill_01"},
{delay=1000,time=2000,type=0,cue_sheet="fight/effect/sword_hit.acb",cue_name="sword_hit_03"},
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6}},
{delay=1200,time=2000,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=500,range1=100,range2=25,hz=30,decay_value=0.3},hit_creates={930703811},hits={0}},
{time=2000,type=0,cue_sheet="cv/Athena.acb",cue_name="Athena_10",cue_feature=1}
},
[930703811]={
effect="common_hit2",effect_pack="common_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{time=2000,type=0,cue_sheet="cv/Athena.acb",cue_name="Athena_09",cue_feature=1},
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6}},
{time=2000,type=0,cue_sheet="fight/effect/athena_cast.acb",cue_name="athena_attack_genreal"},
{delay=800,time=2000,type=1,cue_sheet="fight/effect/element_hit.acb",cue_name="bullet_hit_01",hit_type=0,camera_shake={time=500,shake_dir=1,range=800,range1=200,range2=100,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=1}
},
[-1183793042]={
{time=2000,type=0}
}
};

return this;