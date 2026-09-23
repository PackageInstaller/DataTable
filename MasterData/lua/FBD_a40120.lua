--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=4900,type=0,pos_ref={ref_type=6},cue_sheet="cv/Hail.acb",cue_name="Hail_11",cue_feature=1},
{delay=2530,time=9000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=500,range2=25,hz=30,decay_value=0.3},hits={0}},
{time=9000,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=500,range2=25,hz=30,decay_value=0.3},hits={3200,3450}},
{time=8000,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Hail_attack_skill_02"}
},
[-686817241]={
{effect="cast1_eff",time=5000,type=0,pos_ref={ref_type=0,lock_row=1}},
{effect="cast1_hit",delay=800,time=5000,type=0,pos_ref={ref_type=0,offset_row=-25,lock_row=1}},
{delay=1100,time=4000,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=300,range1=150,range2=25,hz=30,decay_value=0.3},hits={0}},
{time=5000,type=0,cue_sheet="cv/Hail.acb",cue_name="Hail_10",cue_feature=1},
{delay=250,time=5000,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Hail_attack_skill_01"}
},
[-1609092943]={
{effect="cast0_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Hail.acb",cue_name="Hail_09",cue_feature=1},
{delay=800,time=3000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=300,range1=100,range2=10,hz=30,decay_value=0.3},hit_creates={-838067028,661633433},hits={0}},
{delay=300,time=5000,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Hail_attack_general"}
},
[661633433]={
effect="cast0_hit",time=5000,type=0,pos_ref={ref_type=1}
},
[-838067028]={
time=5000,type=0
}
};

return this;