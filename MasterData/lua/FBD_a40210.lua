--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=7000,type=0,pos_ref={ref_type=6},cue_sheet="cv/desert.acb",cue_name="desert_11",cue_feature=1},
{time=7300,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Desert_attack_skill_02"},
{delay=1800,time=5000,type=1,hit_type=1,hit_creates={161059103},hits={0,350,1100,1350,1850}},
{delay=6500,time=5000,type=1,hit_type=1,hits={0}},
{effect="cast2_hit2",delay=6000,time=6000,type=0,pos_ref={ref_type=1}}
},
[161059103]={
effect="cast2_hit ",time=6000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-686817241]={
{effect="Cast1_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="cv/desert.acb",cue_name="desert_08",cue_feature=1},
{effect="Cast1_eff2",delay=250,time=4000,type=0,pos_ref={ref_type=5}},
{delay=280,time=2000,type=1,hit_type=0,camera_shake={time=180,shake_dir=1,range=200,range1=100,range2=20,hz=30,decay_value=0.3},hit_creates={-646510353},hits={0,200,400}},
{delay=1550,time=2000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=200,range1=100,range2=20,hz=30,decay_value=0.3},hits={0}},
{time=4000,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Desert_attack_skill_01"}
},
[-646510353]={
effect="cast1_hit",time=4000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{delay=1150,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=250,range2=25,hz=30,decay_value=0.3},hit_creates={-838067028},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Desert_attack_general"},
{delay=650,time=2500,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=250,range2=25,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/desert.acb",cue_name="desert_09",cue_feature=1,path_target={ref_type=1}}
},
[-838067028]={
effect="cast0_hit2",time=2000,type=0,pos_ref={ref_type=1}
},
[661633433]={
effect="cast0_hit1",time=2000,type=0,pos_ref={ref_type=1}
}
};

return this;