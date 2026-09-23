--FireBall数据
local this = 
{
[-686817241]={
{time=2500,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="95032_Cast_01"},
{effect="cast1_eff",time=2500,type=0,pos_ref={ref_type=6}}
},
[1310282141]={
{time=1800,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hits={200,500,1500,1700}},
{time=1800,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="95032_Cast_02"},
{effect="cast2_eff",time=1800,type=0,pos_ref={ref_type=6}}
},
[-1609092943]={
{time=1800,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hit_creates={1349028111},hits={500}},
{time=1800,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="95032_Cast_00"},
{effect="cast0_eff",time=1800,type=0,pos_ref={ref_type=6}}
},
[1349028111]={
effect="cast0_hit",time=1800,type=0,pos_ref={ref_type=4,part_index=1}
}
};

return this;