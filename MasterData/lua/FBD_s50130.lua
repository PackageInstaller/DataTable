--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff2",delay=2850,time=2850,type=0,pos_ref={ref_type=3}},
{effect="cast2_eff",time=4000,type=0,pos_ref={ref_type=2,offset_row=-750},cue_sheet="cv/Morphidae.acb",cue_name="Morphidae_11",cue_feature=1},
{delay=4100,time=5000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=1,camera_shake={time=500,shake_dir=1,range=400,range1=100,range2=100,hz=22,decay_value=0.4},hit_creates={161059103},hits={0}},
{time=4000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="morphidae_attack_skill_02"}
},
[161059103]={
effect="cast2_hit",time=1600,type=0,pos_ref={ref_type=4,part_index=3}
},
[-686817241]={
{delay=1270,time=3000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=0,camera_shake={time=120,shake_dir=1,range=300,range1=100,range2=100,hz=15,decay_value=0.22},hits={0}},
{delay=1660,time=3000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=1,camera_shake={time=400,shake_dir=1,range=300,range1=100,range2=50,hz=30,decay_value=0.35},hits={0}},
{effect="cast1_eff",time=2000,path_index=0,type=0,pos_ref={ref_type=6},cue_sheet="cv/Atrophaneura.acb",cue_name="Atrophaneura_09",cue_feature=1,path_target={ref_type=1}},
{delay=500,time=2000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="morphidae_attack_skill_01"},
{effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=1}},
{delay=1430,time=3000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=0,camera_shake={time=120,shake_dir=1,range=300,range1=100,range2=100,hz=15,decay_value=0.22},hits={0}},
{effect="cast1_hit2",time=3000,type=0,pos_ref={ref_type=7,part_index=3}},
{delay=1130,time=3000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=0,camera_shake={time=120,shake_dir=1,range=300,range1=100,range2=100,hz=15,decay_value=0.22},hits={0}}
},
[-1609092943]={
{delay=550,time=2000,type=1,cue_sheet="fight/effect/sword_hit.acb",cue_name="sword_hit_02",hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{delay=1050,time=2000,type=1,cue_sheet="fight/effect/sword_hit.acb",cue_name="sword_hit_03",hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range1=300,range2=50,hz=30,decay_value=0.3},hit_creates={537034112},hits={0}},
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Morphidae.acb",cue_name="Morphidae_09",cue_feature=1},
{delay=200,time=2000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="morphidae_attack_general"}
},
[661633433]={
effect="qc_common_medium_hit",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[537034112]={
effect="qc_common_medium_hit",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;