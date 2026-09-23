--FireBall数据
local this = 
{
[1310282141]={
{time=9000,type=1,hit_type=1,hits={7000,7400,7500}},
{time=9000,type=1,hit_type=1,hit_creates={-520473558},hits={3300,3800,4180,5100,6200,6900}},
{effect="cast2_eff",time=9500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/Nineteen.acb",cue_name="30300_cast_02"},
{delay=1833,time=9500,type=0,cue_sheet="cv/Bluebuck.acb",cue_name="Bluebuck_11",cue_feature=1}
},
[-520473558]={
effect="cast2_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-686817241]={
{delay=800,time=4000,type=3,hit_creates={1192467788},hits={0}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/Nineteen.acb",cue_name="30300_cast_01"},
{time=3500,type=0,cue_sheet="cv/Bluebuck.acb",cue_name="Bluebuck_10",cue_feature=1}
},
[1192467788]={
effect="cast1_buff",time=2000,type=0,pos_ref={ref_type=15}
},
[-1609092943]={
{time=4000,type=1,hit_type=1,camera_shake={time=260,shake_dir=1,range=200,range2=100,hz=30,decay_value=0.3},hits={350,1850}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/Nineteen.acb",cue_name="30300_cast_00"},
{time=3500,type=0,cue_sheet="cv/Bluebuck.acb",cue_name="Bluebuck_09",cue_feature=1}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;