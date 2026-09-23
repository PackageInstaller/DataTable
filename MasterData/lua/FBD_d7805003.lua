--FireBall数据
local this = 
{
[1310282141]={
{delay=1400,time=20500,type=0,cue_sheet="cv/Osiris.acb",cue_name="Osiris_11",cue_feature=1},
{delay=9300,time=20500,type=1,hit_type=1,hits={100,200,300,400,500,8700}},
{delay=13900,time=20500,type=0,cue_sheet="cv/Osiris.acb",cue_name="Osiris_12",cue_feature=1},
{time=20500,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="78050_Cast_02"},
{effect="cast2_eff",effect_pack="d78050",time=21000,type=0,pos_ref={ref_type=6}}
},
[-686817241]={
{time=4000,type=0,cue_sheet="cv/Osiris.acb",cue_name="Osiris_10",cue_feature=1},
{effect="cast1_buff2",effect_pack="d78050",delay=1500,time=4000,type=0,pos_ref={ref_type=15}},
{effect="cast1_buff1",effect_pack="d78050",time=4000,type=0,pos_ref={ref_type=6}},
{delay=500,time=4000,type=3,hits={0}},
{time=4000,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="78050_Cast_01"}
},
[-1609092943]={
{time=3500,type=0,cue_sheet="cv/Osiris.acb",cue_name="Osiris_09",cue_feature=1},
{delay=1300,time=4000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hit_creates={1349028111},hits={0,300}},
{time=3500,type=0,cue_sheet="fight/effect/Twenty.acb",cue_name="78050_Cast_00"},
{effect="cast0_eff",effect_pack="d78050",time=3500,type=0,pos_ref={ref_type=6},path_target={ref_type=1}}
},
[1349028111]={
effect="cast0_hit",effect_pack="d78050",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1183793042]={
{effect="enter",effect_pack="d78050",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",effect_pack="d78050",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;