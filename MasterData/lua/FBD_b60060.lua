--FireBall数据
local this = 
{
[1310282141]={
{time=5000,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=400,range1=200,range2=400,hz=30,decay_value=0.3},hits={4000}},
{effect="cast2_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Kusanagi.acb",cue_name="Kusanagi_11",cue_feature=1},
{time=5000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="kusanagi_attack_skill_02"}
},
[-686817241]={
{delay=1600,time=2600,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=1,camera_shake={time=500,shake_dir=1,range=500,range1=100,range2=25,hz=30,decay_value=0.3},hits={0}},
{effect="cast1_eff",time=2500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="kusanagi_attack_skill_01"},
{effect="cast1_hit",time=2500,type=0,pos_ref={ref_type=7,part_index=0,lock_row=1}},
{time=2500,type=0,cue_sheet="cv/Kusanagi.acb",cue_name="Kusanagi_10",cue_feature=1}
},
[-1609092943]={
{time=2000,type=0,cue_sheet="cv/Kusanagi.acb",cue_name="Kusanagi_09",cue_feature=1},
{delay=850,time=2000,type=0,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03"},
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="kusanagi_attack_general"},
{delay=900,time=2000,type=0,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03"},
{time=2000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=200,range1=300,range2=100,hz=30,decay_value=0.3},hit_creates={661633433},hits={800}},
{delay=800,time=2000,type=0,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03"}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;