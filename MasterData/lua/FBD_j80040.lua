--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=9000,type=0,pos_ref={ref_type=10,offset_row=100},cue_sheet="fight/effect/sixth.acb",cue_name="Ripper_attack_skill_02"},
{effect="cast2_hit",time=10060,type=0,pos_ref={ref_type=3}},
{time=7000,type=1,hit_type=1,hits={6300,6800,7500}}
},
[-686817241]={
{effect="cast1_eff",time=2800,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{delay=1800,time=3000,type=1,hit_type=0,camera_shake={time=800,shake_dir=1,range=500,range1=300,range2=110,hz=15,decay_value=0.3},hit_creates={806661594},hits={0}},
{delay=1900,time=3000,type=1,hit_type=1,hits={0,100}},
{time=2800,type=0,cue_sheet="fight/effect/sixth.acb",cue_name="Ripper_attack_skill_01"}
},
[806661594]={
effect="cast1_hit",time=5000,type=0,pos_ref={ref_type=5,lock_col=1}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6}},
{delay=570,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04",hit_type=0,camera_shake={time=300,shake_dir=1,range=300,range1=100,range2=25,hz=30,decay_value=0.3},hit_creates={661633433},hits={0,400,1000}},
{time=2200,type=0,cue_sheet="fight/effect/sixth.acb",cue_name="Ripper_attack_general"},
{delay=570,time=2000,type=0,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04"},
{delay=970,time=2000,type=0,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04"},
{delay=1570,time=2000,type=0,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04"}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,offset_height=-50,part_index=0}
}
};

return this;