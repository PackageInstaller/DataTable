--FireBall数据
local this = 
{
[1079508512]={
{time=2350,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="60321_change"},
{effect="change",time=4500,type=0,pos_ref={ref_type=6}}
},
[-686817241]={
{time=3500,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="60321_cast_01"},
{delay=500,time=4000,type=3,hits={0}},
{time=3500,type=0,cue_sheet="cv/Dainslef.acb",cue_name="Dainslef_20",cue_feature=1},
{effect="cast1_hit",time=3500,type=0,pos_ref={ref_type=6}},
{delay=500,time=4000,type=3,hits={0}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6}},
{delay=500,time=4000,type=3,hits={0}}
},
[1310282141]={
{time=13700,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="60321_cast_02"},
{time=14000,type=1,hit_type=1,hits={6410,7430,7600,8928,11187,12047}},
{delay=4200,time=9500,type=0,cue_sheet="cv/Dainslef.acb",cue_name="Dainslef_22",cue_feature=1},
{effect="cast2_hit",delay=11666,time=2734,type=0,pos_ref={ref_type=1,offset_row=-450}},
{time=13700,type=0,cue_sheet="cv/Dainslef.acb",cue_name="Dainslef_21",cue_feature=1},
{effect="cast2_eff",time=14400,type=0,pos_ref={ref_type=6}},
{delay=10000,time=3700,type=0,cue_sheet="cv/Dainslef.acb",cue_name="Dainslef_11",cue_feature=1}
},
[-1609092943]={
{time=2350,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="60321_cast_00"},
{delay=700,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hits={0,948}},
{time=2350,type=0,cue_sheet="cv/Dainslef.acb",cue_name="Dainslef_10",cue_feature=1},
{effect="cast0_hit",time=3000,type=0,pos_ref={ref_type=0,offset_row=-200,offset_col=-100}},
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=1}}
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=6,offset_row=-250}}
}
};

return this;