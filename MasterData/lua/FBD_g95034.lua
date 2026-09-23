--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",time=5000,type=0,pos_ref={ref_type=6}},
{time=5000,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="95034_Cast_01"}
},
[1310282141]={
{time=3000,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="95034_Cast_02"},
{time=1800,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hits={890,1250,2216,2300}},
{effect="cast2_eff",time=3000,type=0,pos_ref={ref_type=6}},
{effect="cast2_hit",time=5400,type=0,pos_ref={ref_type=3}}
},
[-1609092943]={
{time=1800,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=200,range2=200,hz=10,decay_value=0.6},hits={933}},
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=6}},
{time=3000,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="95034_Cast_00"},
{effect="cast0_hit",delay=933,time=3000,type=0,pos_ref={ref_type=1}}
}
};

return this;