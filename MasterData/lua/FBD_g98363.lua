--FireBall数据
local this = 
{
[-686817241]={
{time=1600,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="98363_cast_01"},
{effect="cast1_eff",time=2500,type=0,pos_ref={ref_type=6}},
{time=2500,type=3,hits={0}}
},
[1310282141]={
{time=1900,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="98363_cast_02"},
{effect="cast2_eff",time=3000,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{delay=1040,time=3000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=50,decay_value=0.6},hit_creates={2124325257},hits={0}}
},
[2124325257]={
effect="cast2_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=1}
},
[958292235]={
{time=1600,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="98361_cast_03"},
{effect="cast3_eff",effect_pack="g98361",time=3000,type=0,pos_ref={ref_type=6}}
},
[-1609092943]={
{time=1500,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="98363_cast_00"},
{delay=592,time=3000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=20,decay_value=0.6},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=6}}
},
[1349028111]={
effect="cast0_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=1}
}
};

return this;