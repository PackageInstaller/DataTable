--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="Shaping1_attack_skill_01"},
{delay=1200,time=4000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={-646510353},hits={0}},
{delay=1700,time=4000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={-1368377223},hits={0}}
},
[-646510353]={
effect="cast1_hit01",time=4000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1368377223]={
effect="cast0_hit02",effect_pack="g90750",time=4000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{effect="cast0_eff",time=2500,path_index=0,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="Shaping1_attack_general",path_target={ref_type=1}},
{delay=800,time=4000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}},
{delay=1200,time=4000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={-1190450118},hits={0}}
},
[661633433]={
effect="qc_shoot_hit1",effect_pack="common_hit",time=4000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1190450118]={
effect="cast0_hit02",effect_pack="g90750",time=4000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;