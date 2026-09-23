--FireBall数据
local this = 
{
[1310282141]={
{time=5000,type=0,cue_sheet="cv/Hermes.acb",cue_name="Hermes_11",cue_feature=1},
{effect="cast2_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="hermes_attack_skill_02"},
{time=5000,type=3,work_delay=800,hits={4200}},
{time=5000,type=3,work_delay=800,hit_creates={-520473558},hits={4000}}
},
[-520473558]={
effect="cure",effect_pack="common",time=2000,type=0,pos_ref={ref_type=4,part_index=0},dont_remove_when_skip=1
},
[-686817241]={
{time=2500,type=0,cue_sheet="cv/Hermes.acb",cue_name="Hermes_10",cue_feature=1},
{effect="cast1_eff",time=2500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="hermes_attack_skill_01"},
{time=2000,type=3,hits={1400}},
{time=2000,type=3,hit_creates={806661594},hits={1400}}
},
[806661594]={
effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="hermes_attack_general"},
{delay=800,time=2000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03",hit_type=0,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{time=2000,type=0,cue_sheet="cv/Hermes.acb",cue_name="Hermes_09",cue_feature=1}
}
};

return this;