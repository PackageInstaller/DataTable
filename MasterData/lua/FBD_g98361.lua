--FireBall数据
local this = 
{
[-686817241]={
{time=2000,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="98361_cast_01"},
{time=2500,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=50,decay_value=0.6},hit_creates={1192467788},hits={780,1120,1490}},
{effect="cast1_eff",time=2500,type=0,pos_ref={ref_type=6},path_target={ref_type=1}}
},
[1192467788]={
effect="cast1_hit",time=2500,type=0,pos_ref={ref_type=4,part_index=1}
},
[1310282141]={
{time=2200,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="98361_cast_02"},
{delay=1138,time=3000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=150,range2=150,hz=50,decay_value=0.6},hits={0,300}},
{effect="cast2_eff",time=3000,type=0,pos_ref={ref_type=6,offset_row=-15}}
},
[958292235]={
{time=1300,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="98361_cast_03"},
{effect="cast3_eff",time=3000,type=0,pos_ref={ref_type=6}}
},
[-1609092943]={
{time=1500,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="98361_cast_00"},
{delay=320,time=3000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=150,range2=150,hz=50,decay_value=0.5},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=6},path_target={ref_type=1}}
},
[1349028111]={
effect="cast0_hit",delay=320,time=3000,type=0,pos_ref={ref_type=4,part_index=1}
}
};

return this;