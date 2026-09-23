--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_hit",effect_pack="b60210",delay=1084,time=2000,type=0,pos_ref={ref_type=3,offset_row=-250}},
{delay=1120,time=4000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=100,range2=100,hz=60,decay_value=0.6},hits={0,100}},
{delay=1120,time=4000,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=150,range2=150,hz=50,decay_value=0.6},hits={840,940,990,1040}},
{time=3500,type=0,cue_sheet="cv/Longxian.acb",cue_name="Longxian_10",cue_feature=1},
{effect="cast1_eff",effect_pack="b60210",effect_no_flip=1,time=3500,path_index=300,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Longxian_attack_skill_01",path_target={ref_type=3,lock_col=1}}
},
[1310282141]={
{delay=5367,time=14000,type=0,cue_sheet="cv/Longxian.acb",cue_name="Longxian_12",cue_feature=1},
{effect="cast2_eff",effect_pack="b60210",time=13800,type=0,pos_ref={ref_type=10},cue_sheet="fight/effect/seventeen.acb",cue_name="Longxian_attack_skill_02"},
{time=14000,type=1,hit_type=1,hit_creates={2124325257},hits={6800,7700,8000,12000,12200,12600,12800,13000}},
{time=14000,type=0,cue_sheet="cv/Longxian.acb",cue_name="Longxian_11",cue_feature=1}
},
[2124325257]={
time=3500,type=0
},
[-1609092943]={
{effect="cast0_hit_3",effect_pack="b60210",delay=1150,time=2000,type=0,pos_ref={ref_type=1}},
{time=2500,type=1,hit_type=0,camera_shake={time=700,shake_dir=1,range=100,range2=100,hz=200,decay_value=0.5},hits={1050}},
{time=2500,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={1100,1150,1260}},
{effect="cast0_hit_4",effect_pack="b60210",delay=1260,time=2500,type=0,pos_ref={ref_type=1}},
{effect="cast0_hit_1",effect_pack="b60210",delay=1050,time=2000,type=0,pos_ref={ref_type=1}},
{effect="cast0_eff",effect_pack="b60210",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Longxian_attack_general",path_target={ref_type=1}},
{effect="cast0_hit_2",effect_pack="b60210",delay=1100,time=2000,type=0,pos_ref={ref_type=1}},
{time=3500,type=0,cue_sheet="cv/Longxian.acb",cue_name="Longxian_09",cue_feature=1}
},
[-1183793042]={
{effect="enter",effect_pack="b60210",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",effect_pack="b60210",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;