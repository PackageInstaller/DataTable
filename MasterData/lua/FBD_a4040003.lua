--FireBall数据
local this = 
{
[-865403415]={
{delay=400,time=13200,type=0,cue_sheet="fight/effect/twelfth.acb",cue_name="Collapsar_summon"},
{delay=167,time=13200,type=0,cue_sheet="cv/Collapsar.acb",cue_name="Collapsar_39",cue_feature=1},
{effect="call_eff",effect_pack="a40400",time=13200,type=0,pos_ref={ref_type=6}}
},
[1310282141]={
{delay=10500,time=4000,type=1,hit_type=1,hits={0}},
{effect="cast2_eff",effect_pack="a40400",time=12000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="Collapsar_attack_skill_02"},
{delay=9600,time=4000,type=1,hit_type=1,hits={0}},
{delay=11000,time=4000,type=1,hit_type=1,hits={0}},
{delay=9400,time=4000,type=1,hit_type=1,hits={0}},
{delay=1066,time=12000,type=0,cue_sheet="cv/Collapsar.acb",cue_name="Collapsar_11",cue_feature=1}
},
[-686817241]={
{time=3600,type=0,cue_sheet="cv/Collapsar.acb",cue_name="Collapsar_10",cue_feature=1},
{delay=2000,time=3600,type=1,hit_type=0,camera_shake={time=350,shake_dir=1,range=250,range1=500,hz=50,decay_value=0.25},hits={0}},
{effect="cast1_hit",effect_pack="a40400",time=3000,type=0,pos_ref={ref_type=0,lock_col=1}},
{effect="cast1_eff",effect_pack="a40400",time=3600,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="Collapsar_attack_skill_01"},
{delay=1460,time=3600,type=1,hit_type=0,camera_shake={time=100,shake_dir=1,range=150,range1=300,hz=55,decay_value=0.25},hits={0}}
},
[-1609092943]={
{delay=1080,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=300,range1=120,hz=50,decay_value=0.25},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",effect_pack="a40400",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="Collapsar_attack_general"},
{time=2000,type=0,cue_sheet="cv/Collapsar.acb",cue_name="Collapsar_09",cue_feature=1}
},
[1349028111]={
effect="cast0_hit",effect_pack="a40400",time=2000,type=0,pos_ref={ref_type=1}
},
[-1183793042]={
{time=4000,type=0}
}
};

return this;