--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=16500,type=0,pos_ref={ref_type=6}},
{effect="cast2_hit",time=16500,type=0,pos_ref={ref_type=2,offset_row=-100}},
{time=16000,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="80180_cast_02"},
{time=16300,type=1,hit_type=1,hits={14300,14400,14500}},
{time=16300,type=1,hit_type=1,hits={4300,5200,6800,6850,14200}}
},
[-686817241]={
{effect="cast1_buff",time=3500,type=0,pos_ref={ref_type=13}},
{time=3500,type=3,hits={2100}},
{time=3500,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="80180_cast_01"},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1609092943]={
{delay=2000,time=2166,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=50,decay_value=0.6},hits={0,300}},
{effect="cast0_hit",delay=1750,time=3000,type=0,pos_ref={ref_type=1,offset_row=-250,offset_col=-100}},
{time=3500,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="80180_cast_00"},
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=6}}
}
};

return this;