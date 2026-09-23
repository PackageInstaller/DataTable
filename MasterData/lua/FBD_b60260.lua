--FireBall数据
local this = 
{
[-686817241]={
{time=3500,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="60260_Cast_01"},
{effect="cast1_buff",time=3500,type=0,pos_ref={ref_type=15}},
{effect="cast1_eff_02",time=3500,type=0,pos_ref={ref_type=15}},
{effect="cast1_buff_end",time=3500,type=0,pos_ref={ref_type=15}},
{time=3500,type=3,hits={0}},
{effect="cast1_eff_01",time=3500,type=0,pos_ref={ref_type=6}}
},
[1310282141]={
{time=13100,type=1,hit_type=0,hits={2500,5800,11500}},
{time=13200,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="60260_Cast_02"},
{effect="cast2_eff",time=13200,type=0,pos_ref={ref_type=6}}
},
[-1609092943]={
{delay=800,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="60260_Cast_00"},
{effect="cast0_eff_01",time=2000,type=0,pos_ref={ref_type=6}},
{effect="cast0_eff_02",delay=500,time=1650,type=0,pos_ref={ref_type=1}},
{effect="cast0_hit",time=3500,type=0,pos_ref={ref_type=1}}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;