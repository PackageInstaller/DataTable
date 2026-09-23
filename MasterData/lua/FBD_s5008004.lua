--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",effect_pack="s50080",time=2550,type=0,pos_ref={ref_type=6},cue_sheet="cv/Sandfly.acb",cue_name="Sandfly_11",cue_feature=1},
{time=6500,type=0,cue_sheet="fight/effect/sandfly_cast.acb",cue_name="sandfly_attack_skill_02"},
{effect="cast2_hit2",effect_pack="s50080",time=6500,type=0,pos_ref={ref_type=13,offset_height=50},dont_remove_when_skip=1},
{delay=3500,time=6000,type=3,work_delay=800,hit_creates={2124325257,250893574},hits={0}}
},
[2124325257]={
effect="cast2_hit",effect_pack="s50080",time=6500,type=0,pos_ref={ref_type=4,part_index=0},dont_remove_when_skip=1
},
[250893574]={
effect="cure",effect_pack="common",time=6500,type=0,pos_ref={ref_type=4,part_index=0},dont_remove_when_skip=1
},
[-686817241]={
{time=3000,type=0,cue_sheet="fight/effect/sandfly_cast.acb",cue_name="sandfly_attack_skill_01"},
{effect="cast1_eff",effect_pack="s50080",time=3500,type=0,pos_ref={ref_type=15,offset_row=4},cue_sheet="cv/Sandfly.acb",cue_name="Sandfly_10",cue_feature=1},
{effect="cast1_hit",effect_pack="s50080",delay=500,time=3500,type=0,pos_ref={ref_type=15},cue_sheet="fight/effect/sandfly_cast.acb",cue_name="sandfly_attack_skill_01"},
{delay=2500,time=3000,type=3,hits={0}},
{delay=1200,time=3000,type=3,hit_creates={930703811},hits={0}}
},
[930703811]={
effect="cure",effect_pack="common",time=3000,type=0,pos_ref={ref_type=4,offset_row=4,part_index=0}
},
[-1609092943]={
{effect="common_hit1",effect_pack="common_hit",delay=600,time=2000,type=0,pos_ref={ref_type=1}},
{time=2000,type=0,cue_sheet="fight/effect/sandfly_cast.acb",cue_name="sandfly_attack_general"},
{effect="cast0_eff",effect_pack="s50080",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Sandfly.acb",cue_name="Sandfly_09",cue_feature=1},
{effect="cast0_hit",effect_pack="s50080",delay=600,time=2000,type=0,pos_ref={ref_type=1},cue_sheet="fight/effect/element_hit.acb",cue_name="magic_hit_01"},
{delay=600,time=2000,type=1,cue_sheet="fight/effect/common_hit.acb",cue_name="common_hit_04",hit_type=0,camera_shake={time=300,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hits={0}}
}
};

return this;