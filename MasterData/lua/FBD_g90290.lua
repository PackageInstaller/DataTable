--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",time=4000,type=0,pos_ref={ref_type=6,offset_row=5,offset_height=-20}},
{delay=600,time=2000,type=0,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_01"},
{delay=900,time=2000,type=0,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_01"},
{time=2000,type=1,hit_type=0,camera_shake={time=280,shake_dir=1,range=250,range1=100,hz=30,decay_value=0.25},hit_creates={-1368377223},hits={600,900}},
{time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="roma2_attack_skill_01"}
},
[-1368377223]={
effect="cast0_hit",time=4000,type=0,pos_ref={ref_type=7,part_index=0}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6}},
{delay=700,time=2000,type=0,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_01"},
{delay=620,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=200,range1=100,hz=30,decay_value=0.25},hit_creates={-838067028},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="roma2_attack_general"}
},
[-838067028]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=7,part_index=0}
}
};

return this;