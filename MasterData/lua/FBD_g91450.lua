--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=15500,type=0,pos_ref={ref_type=6}},
{time=15500,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="80410_Cast_02"},
{time=12000,type=1,hit_type=0,hit_creates={2124325257},hits={5700,12900,9200}}
},
[2124325257]={
time=12000,type=0
},
[-686817241]={
{time=4000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=130,range2=30,hz=70,decay_value=0.5},hit_creates={1192467788},hits={570,790,1010}},
{effect="cast1_eff",time=2000,type=0,pos_ref={ref_type=6}},
{time=2000,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="80410_Cast_01"},
{time=4000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=130,range2=30,hz=70,decay_value=0.5},hits={1110,1210,1310,1410,1510}}
},
[1192467788]={
effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{effect="cast0_eff",time=2300,type=0,pos_ref={ref_type=6}},
{time=4000,type=1,hit_type=0,camera_shake={time=330,shake_dir=1,range=200,hz=200,decay_value=0.45},hit_creates={1349028111},hits={950,1650}},
{time=2300,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="80410_Cast_00"}
},
[1349028111]={
time=4000,type=0
},
[-316323548]={
{effect="deadLarge_common_eff",effect_pack="common",delay=2586,time=6000,type=0,pos_ref={ref_type=6}},
{time=6000,type=0,cue_sheet="fight/effect/nineth.acb",cue_name="Censor_Die"}
}
};

return this;