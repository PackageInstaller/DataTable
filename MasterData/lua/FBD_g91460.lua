--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=12000,type=0,pos_ref={ref_type=6}},
{time=12000,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="80400_Cast_02"},
{time=12000,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="80400_Cast_02"},
{time=12000,type=1,hit_type=0,hit_creates={2124325257},hits={5700,5950,9900}}
},
[2124325257]={
effect="cast2_hit",time=12000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-686817241]={
{time=4000,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="80400_Cast_01"},
{time=4000,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="80400_Cast_01"},
{delay=680,time=4000,type=3,hits={0}},
{effect="cast1_buff",time=2000,type=0,pos_ref={ref_type=15}},
{effect="cast1_eff",time=4000,type=0,pos_ref={ref_type=6}}
},
[-1609092943]={
{time=4000,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="80400_Cast_00"},
{effect="cast0_eff",time=4000,type=0,pos_ref={ref_type=6}},
{time=4000,type=1,hit_type=0,camera_shake={time=330,shake_dir=1,range=200,hz=200,decay_value=0.45},hit_creates={-838067028},hits={950,1350}},
{time=4000,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="80400_Cast_00"}
},
[-838067028]={
effect="cast0_hit",time=4000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-316323548]={
{effect="deadLarge_common_eff",effect_pack="common",delay=2586,time=6000,type=0,pos_ref={ref_type=6}},
{time=6000,type=0,cue_sheet="fight/effect/nineth.acb",cue_name="Censor_Die"}
},
[-1328923786]={
{effect="win",time=4000,type=0,pos_ref={ref_type=6}}
}
};

return this;