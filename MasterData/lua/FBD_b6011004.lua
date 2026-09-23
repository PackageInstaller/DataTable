--FireBall数据
local this = 
{
[1310282141]={
{delay=4200,time=8100,type=0,cue_sheet="cv/Burtgang.acb",cue_name="Burtgang_11",cue_feature=1},
{delay=7200,time=8000,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=300,range1=100,range2=300,hz=30,decay_value=0.3},hits={0}},
{delay=1400,time=8100,type=0,cue_sheet="cv/Burtgang.acb",cue_name="Burtgang_07",cue_feature=1},
{effect="cast2_eff",effect_pack="b60110",time=8100,type=0,pos_ref={ref_type=6}},
{delay=5800,time=8000,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=300,range1=100,range2=300,hz=30,decay_value=0.3},hits={0}},
{time=8000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="Burtgang_attack_skill_02"},
{delay=2575,time=6000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range1=100,range2=300,hz=30,decay_value=0.3},hits={0}}
},
[-686817241]={
{time=2500,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="Burtgang_attack_skill_01"},
{effect="cast1_eff",effect_pack="b60110",time=2500,type=0,pos_ref={ref_type=6},cue_sheet="cv/Burtgang.acb",cue_name="Burtgang_10",cue_feature=1},
{time=2000,type=3,hits={0}}
},
[-1609092943]={
{delay=900,time=2000,type=0,cue_sheet="fight/effect/sword_hit.acb",cue_name="sword_hit_02"},
{delay=1000,time=3000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=400,range2=50,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="Burtgang_attack_general"},
{effect="cast0_eff",effect_pack="b60110",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Burtgang.acb",cue_name="Burtgang_09",cue_feature=1}
},
[661633433]={
effect="cast0_hit",effect_pack="b60110",time=2000,type=0,pos_ref={ref_type=1}
}
};

return this;