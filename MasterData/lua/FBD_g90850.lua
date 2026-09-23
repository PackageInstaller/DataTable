--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",effect_pack="g90020",delay=1000,time=2000,type=0,pos_ref={ref_type=6}},
{delay=1100,time=3000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_01",hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={1192467788},hits={0}},
{delay=500,time=2800,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="harpie1_attack_general"}
},
[1192467788]={
effect="qc_shoot_hit1",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=4,offset_row=-5,part_index=0}
},
[-1609092943]={
{effect="cast0_eff2",effect_pack="g90020",delay=200,time=2000,type=0,pos_ref={ref_type=6}},
{delay=600,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_03",volume_coeff=0,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={1349028111},hits={0}},
{delay=400,time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="robot2_attack_general",volume_coeff=50}
},
[1349028111]={
effect="qc_shoot_hit1",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;