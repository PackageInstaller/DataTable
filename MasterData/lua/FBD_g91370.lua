--FireBall数据
local this = 
{
[1310282141]={
{delay=14100,time=4000,type=1,hit_type=1,hits={0}},
{delay=10235,time=4000,type=1,hit_type=1,hits={0}},
{delay=14200,time=4000,type=1,hit_type=1,hits={0}},
{delay=10035,time=4000,type=1,hit_type=1,hits={0}},
{effect="cast2_eff",effect_pack="j80350",time=15500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Exile_attack_skill_02"},
{delay=10135,time=4000,type=1,hit_type=1,hits={0}},
{delay=14000,time=4000,type=1,hit_type=1,hits={0}}
},
[2124325257]={
time=2000,type=0
},
[-686817241]={
{time=3500,type=3,hit_creates={806661594},hits={1000}},
{effect="cast1_eff",effect_pack="j80350",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Exile_attack_skill_01"}
},
[806661594]={
effect="cast1_buff",effect_pack="j80350",time=3500,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1609092943]={
{delay=1160,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range2=300,hz=50,decay_value=0.5},hits={0}},
{delay=1600,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.6},hits={0}},
{effect="cast0_hit",effect_pack="j80350",time=5000,type=0,pos_ref={ref_type=3,offset_row=-250}},
{effect="cast0_eff",effect_pack="j80350",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Exile_attack_general"}
},
[-316323548]={
{time=6000,type=0,cue_sheet="fight/effect/nineth.acb",cue_name="Drasoul_Die"},
{effect="deadLarge_common_eff",effect_pack="common",delay=2616,time=6000,type=0,pos_ref={ref_type=6}}
}
};

return this;