--FireBall数据
local this = 
{
[1310282141]={
{time=3000,type=0,cue_sheet="fight/effect/ijen_cast.acb",cue_name="ijen_attack_skill_02"},
{effect="cast2_eff2",time=4400,type=0,pos_ref={ref_type=6},cue_sheet="cv/Ijen.acb",cue_name="Ijen_11",cue_feature=1},
{time=5000,type=4,hit_creates={161059103},hits={3000}}
},
[161059103]={
effect="cast2_hit",time=4200,type=0,pos_ref={ref_type=4,part_index=0},cue_sheet="fight/effect/element_hit.acb",cue_name="poison_hit_01"
},
[-686817241]={
{time=2000,type=3,hits={1600}},
{time=2000,type=0,cue_sheet="fight/effect/ijen_cast.acb",cue_name="ijen_attack_passive"},
{effect="cast1_eff2",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Ijen.acb",cue_name="Ijen_10",cue_feature=1}
},
[-1609092943]={
{time=2200,type=0,cue_sheet="fight/effect/ijen_cast.acb",cue_name="ijen_attack_general"},
{delay=920,time=2000,type=1,cue_sheet="fight/effect/element_hit.acb",cue_name="poison_hit_02",hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{effect="cast0_eff2",time=2200,type=0,pos_ref={ref_type=6},cue_sheet="cv/Ijen.acb",cue_name="Ijen_09",cue_feature=1,path_target={ref_type=1,offset_row=100}}
},
[661633433]={
effect="cast0_hit2",time=2200,type=0,pos_ref={ref_type=1},cue_sheet="fight/effect/element_hit.acb",cue_name="poison_hit_02"
}
};

return this;