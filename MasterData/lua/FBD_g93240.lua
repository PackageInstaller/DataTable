--FireBall数据
local this = 
{
[-686817241]={
{delay=1100,time=3000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=300,range1=100,hz=30,decay_value=0.4},hit_creates={1192467788},hits={0}},
{effect="cast1_eff",delay=650,time=2000,type=0,pos_ref={ref_type=6}},
{delay=500,time=2800,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="harpie1_attack_general"}
},
[1192467788]={
effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=4,offset_row=-5,part_index=0}
},
[-1609092943]={
{effect="cast0_eff",delay=50,time=2000,type=0,pos_ref={ref_type=6}},
{time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="robot2_attack_general",volume_coeff=50},
{delay=500,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_03",volume_coeff=0,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.25},hit_creates={1349028111},hits={0}}
},
[1349028111]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;