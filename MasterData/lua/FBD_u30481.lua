--FireBall数据
local this = 
{
[1120628288]={
{time=3000,type=0,cue_sheet="cv/Ushuaia.acb",cue_name="Ushuaia_41",cue_feature=1}
},
[1310282141]={
{delay=3666,time=12500,type=0,cue_sheet="cv/Ushuaia.acb",cue_name="Ushuaia_49",cue_feature=1},
{delay=8600,time=4000,type=1,hit_type=1,hits={0,250,500,750,1000,1600,2100,2300}},
{effect="cast2_eff",time=12500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="homology_Ushuaia_attack_skill_02"}
},
[-686817241]={
{delay=1780,time=4000,type=1,hit_type=1,camera_shake={time=100,shake_dir=1,range=200,range2=200,hz=10,decay_value=0.6},hits={0,130,260,390,520,650}},
{effect="cast1_hit",delay=1000,time=3000,type=0,pos_ref={ref_type=3}},
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="homology_Ushuaia_attack_skill_01"},
{time=13000,type=0,cue_sheet="cv/Ushuaia.acb",cue_name="Ushuaia_48",cue_feature=1}
},
[-1609092943]={
{delay=2440,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range2=100,hz=30,decay_value=0.3},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",time=13000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="homology_Ushuaia_attack_general"},
{time=13000,type=0,cue_sheet="cv/Ushuaia.acb",cue_name="Ushuaia_47",cue_feature=1}
},
[1349028111]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1328923786]={
{effect="win",time=13000,type=0,pos_ref={ref_type=6}}
}
};

return this;