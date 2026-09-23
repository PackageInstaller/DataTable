--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=7000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="schwaritter_attack_skill_02"},
{delay=5000,time=7000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="Explode_Texture_03",hit_type=1,camera_shake={time=800,shake_dir=1,range=500,range1=300,range2=500,hz=30,decay_value=0.3},hits={0}},
{effect="cast2_hit",time=7000,type=0,pos_ref={ref_type=3,offset_row=100}}
},
[-686817241]={
{effect="cast1_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="schwaritter_attack_skill_01"},
{delay=1400,time=2500,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=400,range1=100,range2=4000,hz=30,decay_value=0.3},hit_creates={806661594},hits={0}}
},
[806661594]={
effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=1},cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03"
},
[-1609092943]={
{delay=1000,time=2000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="schwaritter_attack_general"}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;