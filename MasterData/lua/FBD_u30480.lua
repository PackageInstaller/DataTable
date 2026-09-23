--FireBall数据
local this = 
{
[1310282141]={
{delay=9200,time=4000,type=1,hit_type=1,hit_creates={2124325257},hits={0,200,400,600,800,1000}},
{delay=700,time=12000,type=0,cue_sheet="cv/Ushuaia.acb",cue_name="Ushuaia_11",cue_feature=1},
{effect="cast2_eff",time=11500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Ushuaia_attack_skill_02"}
},
[2124325257]={
time=2000,type=0
},
[-686817241]={
{time=3500,type=0,cue_sheet="cv/Ushuaia.acb",cue_name="Ushuaia_10",cue_feature=1},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Ushuaia_attack_skill_01"},
{delay=800,time=3500,type=3,hits={0}}
},
[-1609092943]={
{delay=800,time=4000,type=1,hit_type=0,camera_shake={time=280,shake_dir=1,range=150,range2=100,hz=30,decay_value=0.3},hits={0,160,300}},
{effect="cast0_hit",delay=800,time=2000,type=0,pos_ref={ref_type=1}},
{time=3500,type=0,cue_sheet="cv/Ushuaia.acb",cue_name="Ushuaia_09",cue_feature=1},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Ushuaia_attack_general",path_target={ref_type=1}}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;