--FireBall数据
local this = 
{
[1310282141]={
{time=11000,type=1,hit_type=1,hits={5860,6060,6260,6460,9450,9300}},
{time=11000,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="30330_cast_02"},
{effect="cast2_eff",time=15000,type=0,pos_ref={ref_type=6}}
},
[-686817241]={
{delay=1500,time=4000,type=3,hits={0}},
{time=2500,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="30330_cast_01"},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=13}}
},
[-1609092943]={
{time=3000,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="30330_cast_00"},
{delay=1950,time=4000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=200,range2=200,hz=10,decay_value=0.6},hits={0,300}},
{effect="cast0_hit",delay=1950,time=2000,type=0,pos_ref={ref_type=4,part_index=0}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},path_target={ref_type=1}}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;