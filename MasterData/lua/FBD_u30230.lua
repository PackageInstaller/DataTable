--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Sturnus.acb",cue_name="Sturnus_11",cue_feature=1},
{delay=5100,time=2100,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=500,range2=25,hz=30,decay_value=0.3},hits={0}},
{effect="cast2_hit",time=7000,type=0,pos_ref={ref_type=1}},
{time=6800,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="Sturnus_attack_skill_02"},
{delay=5500,time=1900,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=500,range2=25,hz=30,decay_value=0.3},hits={0}}
},
[-686817241]={
{time=3000,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="Sturnus_attack_skill_01"},
{delay=1150,time=2000,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=300,range1=100,range2=25,hz=30,decay_value=0.3},hit_creates={-646510353},hits={0}},
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Sturnus.acb",cue_name="Sturnus_10",cue_feature=1},
{delay=800,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=500,range1=100,hz=200,decay_value=0.25},hit_creates={806661594},hits={0}}
},
[806661594]={
effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=1}
},
[-646510353]={
effect="qc_boom_4",effect_pack="common_hit",delay=1000,time=2000,type=0,pos_ref={ref_type=1}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Sturnus.acb",cue_name="Sturnus_09",cue_feature=1},
{time=2000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=500,range2=25,hz=30,decay_value=0.3},hit_creates={661633433},hits={500}},
{time=2000,type=0,cue_sheet="fight/effect/fifth.acb",cue_name="Sturnus_attack_general"}
},
[661633433]={
effect="qc_shoot_hit2",effect_pack="common_hit",time=1300,type=0,pos_ref={ref_type=1,offset_height=-50}
}
};

return this;