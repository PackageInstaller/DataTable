--FireBall数据
local this = 
{
[1310282141]={
{delay=6183,time=5000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=50,range2=50,hz=30,decay_value=0.3},hits={0}},
{delay=666,time=7550,type=0,cue_sheet="cv/Rainbow.acb",cue_name="Rainbow_11",cue_feature=1},
{effect="Cast2_eff",time=7550,type=0,pos_ref={ref_type=6}},
{delay=4500,time=5000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=50,range2=50,hz=30,decay_value=0.3},hits={0}},
{time=7550,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Rainbow_attack_skill_02"}
},
[-686817241]={
{effect="cast1_eff",time=2200,type=0,pos_ref={ref_type=6},cue_sheet="cv/Rainbow.acb",cue_name="Rainbow_10",cue_feature=1},
{delay=200,time=2200,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Rainbow_attack_skill_01"},
{delay=1000,time=2000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=229,range1=25,range2=116,hz=30,decay_value=0.4},hit_creates={806661594},hits={0}}
},
[806661594]={
effect="cast1_hit",delay=1050,time=2200,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1609092943]={
{effect="cast0_eff",time=1800,type=0,pos_ref={ref_type=6},cue_sheet="cv/Rainbow.acb",cue_name="Rainbow_09",cue_feature=1,path_target={ref_type=1}},
{time=1800,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Rainbow_attack_general"},
{delay=900,time=2000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=222,range1=111,range2=25,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}}
},
[661633433]={
effect="cast0_hit",delay=955,time=1800,type=0,pos_ref={ref_type=4,part_index=0}
},
[958292235]={
{effect="passive_eff",time=2333,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/nineth.acb",cue_name="Rainbow_Passive"},
{delay=1366,time=2333,type=1,hit_type=0,camera_shake={time=222,shake_dir=1,range=500,range2=25,hz=44,decay_value=0.3},hits={0}},
{delay=1366,time=2333,type=4,hit_creates={518161756},hits={0}}
},
[518161756]={
effect="passive_hit",time=2333,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;