--FireBall数据
local this = 
{
[-686817241]={
{time=3500,type=0,cue_sheet="cv/Pyrock.acb",cue_name="Pyrock_10",cue_feature=1},
{time=3500,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="20030_Cast_01"},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6}}
},
[1310282141]={
{time=12300,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="20030_Cast_02"},
{delay=9600,time=12300,type=0,cue_sheet="cv/Pyrock.acb",cue_name="Pyrock_12",cue_feature=1},
{time=13000,type=1,hit_type=1,hits={9074,9274,9374}},
{effect="cast2_eff",time=12300,type=0,pos_ref={ref_type=6}},
{delay=60,time=12300,type=0,cue_sheet="cv/Pyrock.acb",cue_name="Pyrock_11",cue_feature=1}
},
[-1609092943]={
{delay=2200,time=4000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=100,range2=100,hz=50,decay_value=0.6},hits={0}},
{time=3500,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="20030_Cast_00"},
{effect="cast0_hit",time=6000,type=0,pos_ref={ref_type=1,offset_row=-250}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{time=3500,type=0,cue_sheet="cv/Pyrock.acb",cue_name="Pyrock_09",cue_feature=1}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{time=3500,type=0}
}
};

return this;