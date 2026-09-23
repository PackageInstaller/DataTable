--FireBall数据
local this = 
{
[1310282141]={
{delay=1300,time=10000,type=0,cue_sheet="cv/Scorching.acb",cue_name="Scorching_06",cue_feature=1},
{delay=9000,time=4000,type=1,hit_type=1,hits={0,500,500}},
{delay=3000,time=10000,type=0,cue_sheet="cv/Scorching.acb",cue_name="Scorching_11",cue_feature=1},
{effect="cast2_hit",effect_pack="a40230",delay=9600,time=1400,type=0,pos_ref={ref_type=1,offset_row=-250,offset_col=-50}},
{effect="cast2_eff",effect_pack="a40230",time=10000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Scorching_attack_skill_02"}
},
[-686817241]={
{delay=2500,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range2=300,hz=10,decay_value=0.6},hits={0}},
{effect="cast1_hit",effect_pack="a40230",time=4000,type=0,pos_ref={ref_type=1,offset_row=-150,offset_col=100}},
{effect="cast1_eff",effect_pack="a40230",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="cv/Scorching.acb",cue_name="Scorching_10",cue_feature=1},
{time=3500,type=0,cue_sheet="fight/effect/seventeen.acb",cue_name="Scorching_attack_skill_01"}
},
[-1609092943]={
{delay=1300,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hits={0}},
{effect="cast0_hit",effect_pack="a40230",time=2000,type=0,pos_ref={ref_type=1,offset_row=-250}},
{effect="cast0_eff",effect_pack="a40230",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Scorching_attack_general",path_target={ref_type=1}},
{delay=1000,time=3500,type=0,cue_sheet="cv/Scorching.acb",cue_name="Scorching_09",cue_feature=1}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;