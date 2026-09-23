--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",time=1500,type=0,pos_ref={ref_type=6,offset_row=5,offset_height=-20}},
{delay=600,time=2000,type=0,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_01"},
{delay=900,time=2000,type=0,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_01"},
{time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="roma2_attack_skill_01"},
{time=2000,type=1,hit_type=0,camera_shake={time=280,shake_dir=1,range=250,range1=100,hz=30,decay_value=0.25},hit_creates={806661594},hits={600,900}}
},
[806661594]={
effect="cast0_hit",time=1500,type=0,pos_ref={ref_type=7,part_index=0}
},
[-1609092943]={
{delay=700,time=2000,type=0,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_01"},
{effect="cast0_eff",time=1200,type=0,pos_ref={ref_type=6}},
{time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="roma2_attack_general"},
{delay=620,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=200,range1=100,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}}
},
[661633433]={
effect="cast0_hit",time=1200,type=0,pos_ref={ref_type=7,part_index=0}
}
};

return this;