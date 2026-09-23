--FireBall数据
local this = 
{
[1310282141]={
{time=6000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="hades_sleep_attack_skill_01"},
{delay=4000,time=6000,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=400,range1=200,range2=4000,hz=30,decay_value=0.3},hits={0}},
{effect="cast2_eff",time=6000,type=0,pos_ref={ref_type=6}},
{effect="cast2_hit",time=6000,type=0,pos_ref={ref_type=10,offset_row=-150}}
},
[-737666618]={
{delay=1350,time=2300,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=400,range2=300,hz=30,decay_value=0.3},hits={0}},
{time=3500,type=0},
{delay=100,time=1400,type=0}
},
[-1609092943]={
{delay=1200,time=2300,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=200,range1=400,range2=100,hz=30,decay_value=0.3},hits={0}},
{delay=250,time=3000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="hades_sleep_attack_general_1"},
{effect="cast0_hit",delay=750,time=3500,type=0,pos_ref={ref_type=1}},
{effect="cast0_eff",delay=100,time=1400,path_index=0,type=0,pos_ref={ref_type=6},path_target={ref_type=1}}
},
[-316323548]={
{effect="qc_boom_4",effect_pack="common_hit",delay=300,time=1400,type=0,pos_ref={ref_type=6,offset_row=25}}
}
};

return this;