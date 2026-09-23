--FireBall数据
local this = 
{
[-1183793042]={
{effect="enter",effect_pack="d70310",time=2000,type=0,pos_ref={ref_type=6}}
},
[161059103]={
effect="cast2_hit",effect_pack="d70310",time=4000,type=0,pos_ref={ref_type=4,part_index=1}
},
[1310282141]={
{effect="cast2_eff",effect_pack="d70310",time=12500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Atum_attack_skill_02"},
{time=12000,type=1,hit_type=1,hit_creates={161059103},hits={6900,10400,10550,10700,10850,11000,11150}},
{time=12500,type=0,cue_sheet="cv/Atum.acb",cue_name="Atum_11",cue_feature=1},
{delay=4000,time=12500,type=0,cue_sheet="cv/Atum.acb",cue_name="Atum_12",cue_feature=1}
},
[-686817241]={
{time=5000,type=0,cue_sheet="cv/Atum.acb",cue_name="Atum_10",cue_feature=1},
{effect="cast1_eff ",time=5000,type=0,pos_ref={ref_type=0,offset_row=-225,lock_col=1}},
{delay=2900,time=3000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=500,range1=300,range2=50,hz=30,decay_value=0.5},hit_creates={1192467788},hits={0}},
{time=3000,type=1,hit_type=0,camera_shake={time=250,shake_dir=1,range=300,range1=150,range2=50,hz=30,decay_value=0.5},hit_creates={806661594},hits={547,900,1500}},
{delay=300,time=5000,type=0,cue_sheet="fight/effect/thirteen.acb",cue_name="Atum_attack_skill_01"}
},
[806661594]={
effect="cast1_hit1",effect_pack="d70310",time=3000,type=0,pos_ref={ref_type=4,part_index=1}
},
[1192467788]={
effect="cast1_hit2",effect_pack="d70310",time=3000,type=0,pos_ref={ref_type=4,part_index=1}
},
[1349028111]={
time=1200,type=0
},
[-1609092943]={
{delay=680,time=1200,type=1,hit_type=0,camera_shake={time=250,shake_dir=1,range=300,range1=100,range2=50,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}},
{delay=500,time=3000,type=0,cue_sheet="fight/effect/thirteen.acb",cue_name="Atum_attack_general"},
{time=3000,type=0,cue_sheet="cv/Atum.acb",cue_name="Atum_09",cue_feature=1},
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=0,offset_row=-25}},
{delay=1280,time=1200,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=400,range1=200,range2=50,hz=30,decay_value=0.25},hit_creates={1349028111},hits={0}}
},
[661633433]={
effect="cast0_hit",effect_pack="d70310",time=1200,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1328923786]={
{effect="win",effect_pack="d70310",time=2000,type=0,pos_ref={ref_type=6}}
}
};

return this;