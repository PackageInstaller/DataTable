--FireBall数据
local this = 
{
[-686817241]={
{delay=2000,time=3500,type=3,hits={0}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Harvest_attack_skill_01"},
{time=3500,type=0,cue_sheet="cv/Harvest.acb",cue_name="Harvest_10",cue_feature=1}
},
[1310282141]={
{delay=5333,time=8000,type=0,cue_sheet="cv/Harvest.acb",cue_name="Harvest_12",cue_feature=1},
{effect="cast2_eff",time=8000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Harvest_attack_skill_02"},
{time=10000,type=3,hits={0}},
{delay=333,time=8000,type=0,cue_sheet="cv/Harvest.acb",cue_name="Harvest_11",cue_feature=1}
},
[-1609092943]={
{time=4000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hits={800}},
{effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=1}},
{time=3500,type=0,cue_sheet="cv/Harvest.acb",cue_name="Harvest_09",cue_feature=1},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Harvest_attack_general"}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;