--FireBall数据
local this = 
{
[1310282141]={
{time=7200,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Thunder_attack_skill_02"},
{delay=4700,time=7000,type=1,hit_type=1,hits={0,1200,1300,1400}},
{effect="cast2_hit",time=7200,type=0,pos_ref={ref_type=1}},
{effect="cast2_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Thunder.acb",cue_name="Thunder_11",cue_feature=1}
},
[806661594]={
effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=4,offset_row=25,part_index=1}
},
[-686817241]={
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Thunder.acb",cue_name="Thunder_10",cue_feature=1,path_target={ref_type=1}},
{time=3000,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Thunder_attack_skill_01"},
{delay=1900,time=2000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=500,range2=25,hz=30,decay_value=0.3},hit_creates={806661594},hits={0}},
{delay=2700,time=2000,type=3,hits={0}}
},
[-1609092943]={
{time=2000,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Thunder_attack_general"},
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Thunder.acb",cue_name="Thunder_08",cue_feature=1,path_target={ref_type=1}},
{delay=1150,time=2000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=150,range1=50,range2=150,hz=40,decay_value=0.4},hit_creates={661633433},hits={0}}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;