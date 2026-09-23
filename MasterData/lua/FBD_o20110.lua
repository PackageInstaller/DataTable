--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=7300,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="Clara_Haskil_attack_skill_02"},
{delay=7300,time=5000,type=3,hits={0,200,400}},
{delay=167,time=5000,type=0,cue_sheet="cv/Arpeggio.acb",cue_name="Arpeggio_11",cue_feature=1},
{delay=7300,time=5000,type=2,hits={0}}
},
[-686817241]={
{time=5000,type=0,cue_sheet="fight/effect/twelfth.acb",cue_name="Clara_Haskil_attack_skill_01"},
{effect="cast1_eff2",delay=1700,time=5000,type=0,pos_ref={ref_type=13}},
{delay=2200,time=1900,type=3,hit_creates={-646510353},hits={0}},
{effect="cast1_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Arpeggio.acb",cue_name="Arpeggio_10",cue_feature=1}
},
[-646510353]={
effect="cast1_buff",time=5000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Arpeggio.acb",cue_name="Arpeggio_09",cue_feature=1,path_target={ref_type=1}},
{time=3000,type=0,cue_sheet="fight/effect/twelfth.acb",cue_name="Clara_Haskil_attack_general"},
{delay=1180,time=2000,type=1,hit_type=0,hit_delay_coeff_dis=30,hit_dis_offset=0,camera_shake={time=190,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=1}
}
};

return this;