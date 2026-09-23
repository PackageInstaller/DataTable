--FireBall数据
local this = 
{
[-686817241]={
{time=3500,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="80100_cast_01"},
{delay=1150,time=4000,type=3,hit_creates={1192467788},hits={0}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6}}
},
[1192467788]={
effect="cast1_buff",time=2000,type=0,pos_ref={ref_type=15}
},
[1310282141]={
{time=22000,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="80100_cast_02"},
{effect="cast2_eff1",delay=16750,time=22000,type=0,pos_ref={ref_type=6}},
{delay=7266,time=22000,type=0},
{time=22000,type=1,hit_type=1,hits={6370,6840,18420}},
{effect="j80100_cast2_1",effect_pack="videos",delay=7300,time=20000,type=0,pos_ref={ref_type=6}},
{effect="j80100_cast2_2",effect_pack="videos",delay=19650,time=20000,type=0,pos_ref={ref_type=6}},
{effect="cast2_eff",time=22000,type=0,pos_ref={ref_type=6}}
},
[-1609092943]={
{time=4000,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="80100_cast_00"},
{delay=1240,time=4000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hits={0,700}},
{effect="cast0_hit",delay=1260,time=2000,type=0,pos_ref={ref_type=1}},
{effect="cast0_eff",time=4000,type=0,pos_ref={ref_type=6},path_target={ref_type=1}}
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;