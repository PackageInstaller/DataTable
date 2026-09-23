--FireBall数据
local this = 
{
[-686817241]={
{time=3500,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="10330_Cast_01"},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6}}
},
[1310282141]={
{time=12500,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="10330_Cast_02"},
{time=13000,type=1,hit_type=1,hit_creates={2124325257},hits={4600,4800,9000,11000}},
{effect="cast2_eff",time=12500,type=0,pos_ref={ref_type=6}}
},
[2124325257]={
time=2000,type=0
},
[958292235]={
{time=4000,type=1,hit_type=1,camera_shake={time=250,shake_dir=1,range=300,range2=300,hz=10,decay_value=0.6},hits={500,800,1000}},
{effect="cast3_hit",time=3000,type=0,pos_ref={ref_type=1,offset_row=-250,offset_col=-100}},
{effect="cast3_eff",time=3500,type=0,pos_ref={ref_type=6}},
{time=3500,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="10330_Cast_03"}
},
[-1609092943]={
{time=3500,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="10330_Cast_00"},
{time=4000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hits={500}},
{effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=1,offset_row=-250}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1183793042]={
{time=3500,type=0}
},
[-1328923786]={
{time=3500,type=0}
}
};

return this;