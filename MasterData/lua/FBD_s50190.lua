--FireBall数据
local this = 
{
[1310282141]={
{delay=4800,time=2000,type=1,hit_type=0,hits={0,100,200,600,800,1000}},
{effect="Cast2_hit2",time=7000,type=0,pos_ref={ref_type=1,offset_row=-1100}},
{time=7000,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Psilica_skill_02"},
{effect="Cast2_eff",time=5200,type=0,pos_ref={ref_type=6},cue_sheet="cv/Psilica.acb",cue_name="Psilica_11",cue_feature=1}
},
[-686817241]={
{time=4000,type=1,hit_type=0,camera_shake={time=700,shake_dir=1,range=300,range1=100,range2=25,hz=30,decay_value=0.3},hits={2000}},
{time=4000,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Psilica_attack_skill_01"},
{effect="Cast1_hit",time=4000,type=0,pos_ref={ref_type=1,offset_row=100,lock_row=1}},
{effect="Cast1_eff",time=4000,type=0,pos_ref={ref_type=0,offset_row=-350,lock_row=1},cue_sheet="cv/Psilica.acb",cue_name="Psilica_10",cue_feature=1},
{effect="Cast1_eff2",time=4000,type=0,pos_ref={ref_type=6}}
},
[-1609092943]={
{effect="Cast0_hit",time=2000,type=0,pos_ref={ref_type=1}},
{time=2000,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Psilica_attack_general"},
{effect="Cast0_eff",time=2000,type=0,pos_ref={ref_type=0,offset_row=-200},cue_sheet="cv/Psilica.acb",cue_name="Psilica_09",cue_feature=1},
{delay=600,time=2000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=400,range2=25,hz=30,decay_value=0.3},hits={0}}
}
};

return this;