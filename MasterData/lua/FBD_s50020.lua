--FireBall数据
local this = 
{
[1310282141]={
{time=5000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="beethorn_attack_skill_02"},
{delay=2500,time=5000,type=1,hit_type=0,hits={0}},
{delay=2700,time=5000,type=1,hit_type=1,hits={0}},
{effect="cast2_eff",time=4400,type=0,pos_ref={ref_type=6},cue_sheet="cv/Beethorn.acb",cue_name="Beethorn_11",cue_feature=1},
{delay=4000,time=5000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="Explode_Texture_01",hit_type=1,hits={0}},
{delay=1800,time=5000,type=1,hit_type=0,hits={0,200}}
},
[161059103]={
effect="common_hit1",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-686817241]={
{delay=1180,time=3000,type=0,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03"},
{time=2000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hits={1400}},
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Beethorn.acb",cue_name="Beethorn_10",cue_feature=1},
{effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=1}},
{delay=1400,time=3000,type=0,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03"},
{time=2000,type=1,hit_type=0,camera_shake={time=90,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hits={1080,1180}},
{delay=1080,time=3000,type=0,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03"},
{time=3000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="beethorn_attack_skill_01"}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Beethorn.acb",cue_name="Beethorn_09",cue_feature=1},
{delay=1000,time=2000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=0,camera_shake={time=400,shake_dir=1,range=400,range2=400,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="beethorn_attack_general"}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;