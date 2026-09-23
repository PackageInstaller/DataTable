--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",effect_pack="j80340",time=15500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Arbiter_attack_skill_02"},
{time=15000,type=1,hit_type=1,hit_creates={2124325257},hits={5000,12400,12600,12900}}
},
[2124325257]={
time=2000,type=0
},
[-686817241]={
{delay=750,time=4000,type=3,hit_creates={1192467788},hits={0}},
{effect="cast1_eff",effect_pack="j80340",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Arbiter_attack_skill_01"}
},
[1192467788]={
effect="cast1_buff",effect_pack="j80340",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{delay=250,time=4000,type=1,hit_type=1,camera_shake={time=350,shake_dir=1,range=220,range2=100,hz=45,decay_value=0.3},hit_creates={1349028111},hits={0,1000}},
{effect="cast0_eff",effect_pack="j80340",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Arbiter_attack_general"}
},
[1349028111]={
effect="cast0_hit",effect_pack="j80340",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-316323548]={
{effect="deadLarge_common_eff",effect_pack="common",delay=2416,time=6000,type=0,pos_ref={ref_type=6}},
{time=6000,type=0,cue_sheet="fight/effect/nineth.acb",cue_name="Censor_Die"}
}
};

return this;