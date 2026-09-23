--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=10600,type=0,pos_ref={ref_type=6}},
{effect="cast2_hit",delay=9000,time=2000,type=0,pos_ref={ref_type=3}},
{delay=3200,time=6000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=500,range1=300,range2=500,hz=30,decay_value=0.3},hits={0,500}},
{delay=9000,time=6000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04",hit_type=1,camera_shake={time=800,shake_dir=1,range=500,range1=300,range2=500,hz=30,decay_value=0.3},hits={0}},
{time=10600,type=0,cue_sheet="fight/effect/fourth.acb",cue_name="Legions_attack_skill_02"},
{delay=3200,time=6000,type=0,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04"},
{delay=3700,time=6000,type=0,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04"}
},
[-686817241]={
{effect="cast1_eff",time=2800,type=0,pos_ref={ref_type=6}},
{delay=1750,time=3000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04",hit_type=1,camera_shake={time=800,shake_dir=1,range=300,range1=144,range2=300,hz=15,decay_value=0.3},hit_creates={806661594},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/fourth.acb",cue_name="Legions_attack_skill_01"}
},
[806661594]={
effect="cast1_hit",time=2500,type=0,pos_ref={ref_type=6,offset_row=-400}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6}},
{delay=900,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04",hit_type=1,camera_shake={time=400,shake_dir=1,range=400,range1=333,range2=400,hz=20,decay_value=0.3},hit_creates={661633433},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/fourth.acb",cue_name="Legions_attack_general"}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=1,offset_height=-50}
},
[958292235]={
{delay=500,time=2000,type=3,hit_creates={518161756},hits={0}}
},
[518161756]={
effect="qc_buff_red_hit",effect_pack="common_hit",time=1000,type=0,pos_ref={ref_type=4,part_index=1}
}
};

return this;