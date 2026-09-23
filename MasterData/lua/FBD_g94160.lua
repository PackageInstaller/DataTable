--FireBall数据
local this = 
{
[-1183793042]={
{effect="enter_eff",delay=500,time=2000,type=0,pos_ref={ref_type=6}}
},
[1310282141]={
{time=4000,type=0,cue_sheet="fight/effect/seventeen.acb",cue_name="AbyssAxe_attack_skill_02"},
{effect="cast2_eff",time=3800,type=0,pos_ref={ref_type=3,offset_row=-214}},
{delay=1800,time=5000,type=1,hit_type=1,hits={0,863}}
},
[-686817241]={
{delay=2500,time=2000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=500,range1=300,range2=25,hz=30,decay_value=0.3},hits={0}},
{time=4000,type=0},
{delay=1450,time=2000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=500,range1=300,range2=25,hz=30,decay_value=0.6},hits={0}},
{time=4000,type=0,cue_sheet="fight/effect/seventeen.acb",cue_name="AbyssAxe_attack_skill_01"},
{effect="cast1_hit",time=6000,type=0,pos_ref={ref_type=3,offset_row=165,lock_col=1}}
},
[-1609092943]={
{time=3000,type=0,cue_sheet="fight/effect/seventeen.acb",cue_name="AbyssAxe_attack_general"},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6}},
{delay=800,time=2000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=120,range1=300,range2=25,hz=30,decay_value=0.3},hit_creates={1349028111},hits={0}}
},
[1349028111]={
effect="cast0_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-316323548]={
{effect="dead_eff",effect_pack="g90610",time=6000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/nineth.acb",cue_name="Frost_guard_Die"}
}
};

return this;