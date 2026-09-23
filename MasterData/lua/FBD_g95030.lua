--FireBall数据
local this = 
{
[-686817241]={
{time=2300,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="95030_cast_01"},
{time=1800,type=1,hit_type=0,camera_shake={time=150,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.5},hits={500,800}},
{effect="cast1_eff",time=5000,type=0,pos_ref={ref_type=6}},
{effect="cast1_hit",time=5000,type=0,pos_ref={ref_type=1,offset_row=-150}}
},
[1310282141]={
{time=2800,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="95030_cast_02"},
{time=3000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hits={200,800,1500,1700}},
{effect="cast2_eff",time=3000,type=0,pos_ref={ref_type=6}},
{effect="cast2_hit",time=5400,type=0,pos_ref={ref_type=1,offset_row=-150}}
},
[-1609092943]={
{time=1400,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="95030_cast_00"},
{time=1800,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hits={500}},
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=6}},
{effect="cast0_hit",time=3000,type=0,pos_ref={ref_type=1,offset_row=-175,lock_col=1}}
}
};

return this;