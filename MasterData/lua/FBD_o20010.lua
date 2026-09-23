--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=4900,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="Conductor_attack_skill_02"},
{effect="cast2_hit",delay=4900,time=2000,type=0,pos_ref={ref_type=13,offset_row=50}},
{time=7000,type=3,hits={5100}},
{time=4800,type=0,cue_sheet="cv/Conductor.acb",cue_name="Conductor_11",cue_feature=1}
},
[-686817241]={
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="Conductor_attack_skill_01"},
{delay=2000,time=3000,type=3,hit_creates={806661594},hits={0}},
{time=3000,type=0,cue_sheet="cv/Conductor.acb",cue_name="Conductor_10",cue_feature=1}
},
[806661594]={
effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=15}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6}},
{effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=1}},
{delay=950,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=400,range2=400,hz=30,decay_value=0.3},hits={0}},
{time=2000,type=0,cue_sheet="cv/Conductor.acb",cue_name="Conductor_09",cue_feature=1},
{time=2000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="Conductor_attack_general"}
}
};

return this;