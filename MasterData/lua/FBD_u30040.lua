--FireBall数据
local this = 
{
[-686817241]={
{time=3700,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="30040_cast_01"},
{effect="cast1_hit3",time=6000,type=0,pos_ref={ref_type=1,offset_row=250,lock_row=1}},
{delay=2000,time=6000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=250,range2=250,hz=60,decay_value=0.5},hits={0}},
{effect="cast1_hit",time=6000,type=0,pos_ref={ref_type=1,offset_row=250,offset_col=50,lock_row=1}},
{effect="cast1_eff",time=6000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Canis.acb",cue_name="Canis_10",cue_feature=1},
{effect="cast1_hit2",delay=2439,time=6000,type=0,pos_ref={ref_type=1,offset_row=250,offset_col=50,lock_row=1}},
{delay=2439,time=6000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=250,range2=250,hz=60,decay_value=0.5},hits={0}}
},
[1310282141]={
{time=6500,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="30040_cast_02"},
{delay=5000,time=3000,type=1,hit_type=1,hits={0}},
{effect="cast2_hit",delay=5000,time=1500,type=0,pos_ref={ref_type=3}},
{effect="cast2_eff",time=6000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Canis.acb",cue_name="Canis_11",cue_feature=1}
},
[-1609092943]={
{time=1800,type=0,cue_sheet="fight/effect/Nineteen.acb",cue_name="30040_cast_00"},
{delay=1000,time=4000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=250,range2=250,hz=30,decay_value=0.5},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Canis.acb",cue_name="Canis_09",cue_feature=1,path_target={ref_type=1}}
},
[1349028111]={
effect="cast0_hit",time=5000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;