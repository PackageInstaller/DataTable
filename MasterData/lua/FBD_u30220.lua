--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=7000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Rex.acb",cue_name="Rex_12",cue_feature=1},
{time=7000,type=0,cue_sheet="fight/effect/fourth.acb",cue_name="TessRevel_attack_skill_02"},
{effect="cast2_hit",delay=4700,time=5000,type=0,pos_ref={ref_type=1}},
{time=6000,type=1,hit_type=1,hits={1200}},
{time=6000,type=1,hit_type=1,hits={4600,5200}}
},
[-686817241]={
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Rex.acb",cue_name="Rex_11",cue_feature=1},
{time=3000,type=0,cue_sheet="fight/effect/fourth.acb",cue_name="TessRevel_attack_skill_01"},
{time=3000,type=3,hits={2000}}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Rex.acb",cue_name="Rex_09",cue_feature=1},
{delay=400,time=2000,type=0,cue_sheet="fight/effect/fourth.acb",cue_name="TessRevel_attack_general"},
{time=2000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=200,range1=500,hz=200,decay_value=0.25},hit_creates={661633433},hits={550}}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;