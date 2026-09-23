--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",effect_pack="J80140",time=8100,type=0,pos_ref={ref_type=6}},
{delay=5333,time=3430,type=0},
{delay=5333,time=8200,type=1,hit_type=1,hits={0,2017}},
{time=8700,type=0,cue_sheet="fight/effect/fourth.acb",cue_name="LordThunder_attack_skill_02"},
{delay=6500,time=8000,type=0,cue_sheet="fight/effect/common_explode.acb",cue_name="common_explode_03"}
},
[-686817241]={
{effect="cast1_eff",effect_pack="J80140",time=4500,type=0,pos_ref={ref_type=13}},
{delay=2550,time=4500,type=3,hit_creates={806661594},hits={0}},
{time=4500,type=0,cue_sheet="fight/effect/fourth.acb",cue_name="LordThunder_attack_skill_01"}
},
[806661594]={
effect="qc_buff_hit",effect_pack="common_hit",time=4000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1609092943]={
{effect="cast0_eff",effect_pack="J80140",delay=700,time=2000,type=0,pos_ref={ref_type=6}},
{delay=733,time=2000,type=1,cue_sheet="fight/effect/zeus_cast.acb",cue_name="zeus_attack_passive",hit_type=0,camera_shake={time=300,shake_dir=1,range=200,range2=25,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{time=2000,type=4,hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/fourth.acb",cue_name="LordThunder_attack_general"}
},
[661633433]={
effect="cast0_hit",effect_pack="J80140",time=2000,type=0,pos_ref={ref_type=7,part_index=0}
}
};

return this;