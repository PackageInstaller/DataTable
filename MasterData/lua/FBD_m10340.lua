--FireBall数据
local this = 
{
[-686817241]={
{time=4000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hits={300,1400}},
{effect="cast1_hit",time=3500,type=0,pos_ref={ref_type=4,offset_row=-250,part_index=1,lock_row=1}},
{time=3500,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="10340_Cast_01"},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6,lock_row=1}}
},
[1310282141]={
{time=7100,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="10340_Cast_02"},
{time=7500,type=3,hits={0}},
{effect="cast2_eff",time=7100,type=0,pos_ref={ref_type=6}}
},
[-1609092943]={
{time=2000,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="10340_Cast_00"},
{effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=1}},
{delay=700,time=4000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.2},hits={0}},
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6}}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=1,offset_row=-250,lock_row=1}}
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=1,offset_row=-250,lock_row=1}}
}
};

return this;