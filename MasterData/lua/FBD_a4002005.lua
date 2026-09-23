--FireBall数据
local this = 
{
[-686817241]={
{delay=1350,time=4000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=400,range1=450,range2=200,hz=30,decay_value=0.3},hit_creates={-646510353},hits={0}},
{effect="cast1_eff",effect_pack="a40020",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fourteen.acb",cue_name="Trade_attack_skill_01",path_target={ref_type=3}},
{time=3500,type=0,cue_sheet="cv/Trade.acb",cue_name="Trade_10",cue_feature=1},
{effect="cast1_hit",effect_pack="a40020",time=3500,type=0,pos_ref={ref_type=3}}
},
[-646510353]={
time=2000,type=0
},
[1310282141]={
{delay=6250,time=4000,type=1,hit_type=1,hit_creates={161059103},hits={0,200,330,460}},
{delay=7150,time=4000,type=1,hit_type=1,hits={0}},
{effect="cast2_eff",effect_pack="a40020",time=8000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fourteen.acb",cue_name="Trade_attack_skill_02"},
{time=3500,type=0,cue_sheet="cv/Trade.acb",cue_name="Trade_11",cue_feature=1}
},
[161059103]={
effect="cast2_hit",effect_pack="a40020",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{delay=940,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range1=200,range2=200,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{effect="cast0_eff",effect_pack="a40020",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fourteen.acb",cue_name="Trade_attack_general"},
{time=3500,type=0,cue_sheet="cv/Trade.acb",cue_name="Trade_09",cue_feature=1}
},
[661633433]={
effect="cast0_hit",effect_pack="a40020",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-601574123]={
{time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range1=200,range2=200,hz=30,decay_value=0.3},hit_creates={-192693043},hits={0}}
},
[-192693043]={
time=2000,type=0
}
};

return this;