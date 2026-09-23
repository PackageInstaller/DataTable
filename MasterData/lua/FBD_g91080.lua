--FireBall数据
local this = 
{
[-1183793042]={
{effect="enter",delay=400,time=2000,type=0,pos_ref={ref_type=6}}
},
[1310282141]={
{time=4000,type=0,cue_sheet="fight/effect/seventh.acb",cue_name="Frost_guard_attack_skill_02"},
{effect="cast2_eff",time=3500,type=0,pos_ref={ref_type=6,offset_row=-339,lock_col=1}},
{delay=1800,time=5000,type=1,hit_type=1,hits={100,400}}
},
[-686817241]={
{effect="cast1_eff",time=4000,type=0,pos_ref={ref_type=6,lock_col=1},path_target={ref_type=1,offset_row=100,offset_col=100,lock_col=1}},
{delay=1400,time=2000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=500,range1=300,range2=25,hz=30,decay_value=0.3},hits={0}},
{time=4000,type=0,cue_sheet="fight/effect/seventh.acb",cue_name="Frost_guard_attack_skill_01"},
{effect="cast1_hit",time=4000,type=0,pos_ref={ref_type=1,offset_row=100,lock_col=1}}
},
[-1609092943]={
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{delay=650,time=2000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=200,range1=400,range2=25,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{time=3000,type=0,cue_sheet="fight/effect/seventh.acb",cue_name="Frost_guard_attack_general"}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-316323548]={
{effect="dead_eff",effect_pack="g90610",time=6000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/nineth.acb",cue_name="Frost_guard_Die"}
}
};

return this;