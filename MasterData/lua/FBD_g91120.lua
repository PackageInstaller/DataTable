--FireBall数据
local this = 
{
[-390021739]={
{effect="cast1_summon",time=6000,type=0,pos_ref={ref_type=10},cue_sheet="fight/effect/thirteen.acb",cue_name="Osiris_attack_skill_05_2"}
},
[-686817241]={
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Hyper_Kraken_attack_skill_05"}
},
[2124325257]={
effect="cast2_hit",time=3500,type=0,pos_ref={ref_type=4,part_index=1}
},
[1310282141]={
{effect="cast2_eff",time=5600,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Kraken_attack_skill_01"},
{delay=3400,time=3500,type=1,hit_type=0,hit_creates={2124325257},hits={0,400,800}}
},
[-1609092943]={
{effect="cast0_hit",delay=950,time=3500,type=0,pos_ref={ref_type=1}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Kraken_attack_general",path_target={ref_type=1,offset_row=100,lock_col=1}},
{delay=950,time=3500,type=1,hit_type=0,camera_shake={time=100,shake_dir=1,range=330,range2=100,hz=10,decay_value=0.6},hits={0,50,100,150,200,250}}
},
[-316323548]={
{effect="dead",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Kraken_enter2"}
}
};

return this;