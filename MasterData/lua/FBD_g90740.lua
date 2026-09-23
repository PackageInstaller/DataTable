--FireBall数据
local this = 
{
[-686817241]={
{delay=300,time=4000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="Shaping3_attack_skill_01"},
{delay=1000,time=4000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={1192467788},hits={46,100,200,400}}
},
[1192467788]={
effect="qc_blunt_hit1",effect_pack="common_hit",time=4000,type=0,pos_ref={ref_type=4,part_index=0},cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03"
},
[-1609092943]={
{effect="cast0_eff",time=4000,path_index=0,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="Shaping3_attack_general",path_target={ref_type=1}},
{delay=945,time=4000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_01",hit_type=0,camera_shake={time=500,shake_dir=1,range=50,range1=10,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{delay=1145,time=4000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_01",hit_type=0,camera_shake={time=500,shake_dir=1,range=50,range1=10,hz=30,decay_value=0.3},hits={0}}
},
[661633433]={
effect="qc_shoot_hit1",effect_pack="common_hit",time=5000,type=0,pos_ref={ref_type=1}
}
};

return this;