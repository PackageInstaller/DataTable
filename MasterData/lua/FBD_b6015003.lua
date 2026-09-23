--FireBall数据
local this = 
{
[-865403415]={
{time=13000,type=0,cue_sheet="cv/Tyrfing.acb",cue_name="Tyrfing_46",cue_feature=1},
{effect="call_eff",effect_pack="b60150",time=13000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/Tyrfing_summon.acb",cue_name="Tyrfing_summon"}
},
[-686817241]={
{time=3500,type=0,cue_sheet="cv/Tyrfing.acb",cue_name="Tyrfing_10",cue_feature=1},
{delay=1160,time=4000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=150,range2=150,hz=120,decay_value=0.6},hits={0,100,200}},
{effect="cast1_hit",effect_pack="b60150",delay=1160,time=4000,type=0,pos_ref={ref_type=3,offset_row=-250}},
{effect="cast1_eff",effect_pack="b60150",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Tyrfing_attack_skill_01"}
},
[1310282141]={
{delay=9200,time=5000,type=1,hit_type=0,hits={0,100,200,300}},
{effect="cast2_hit",effect_pack="b60150",delay=8915,time=1600,type=0,pos_ref={ref_type=0,offset_row=450}},
{time=10500,type=0,cue_sheet="cv/Tyrfing.acb",cue_name="Tyrfing_11",cue_feature=1},
{delay=8096,time=5000,type=1,hit_type=0,hits={0}},
{effect="cast2_eff",effect_pack="b60150",time=10500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Tyrfing_attack_skill_02"},
{delay=5000,time=10500,type=0,cue_sheet="cv/Tyrfing.acb",cue_name="Tyrfing_12",cue_feature=1}
},
[958292235]={
{delay=1200,time=4000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=300,range2=300,hz=60,decay_value=0.6},hits={0}},
{effect="cast3_hit",effect_pack="b60150",delay=1200,time=2000,type=0,pos_ref={ref_type=1}},
{effect="cast3_eff",effect_pack="b60150",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Tyrfing_attack_general",path_target={ref_type=1}},
{time=3500,type=0,cue_sheet="cv/Tyrfing.acb",cue_name="Tyrfing_08",cue_feature=1}
},
[-1609092943]={
{time=3500,type=0,cue_sheet="cv/Tyrfing.acb",cue_name="Tyrfing_09",cue_feature=1},
{delay=1200,time=4000,type=1,hit_type=1,camera_shake={time=170,shake_dir=1,range=120,range1=120,range2=120,hz=60,decay_value=0.6},hits={0,200,400}},
{effect="cast0_hit",effect_pack="b60150",delay=1200,time=4000,type=0,pos_ref={ref_type=0,offset_row=50}},
{effect="cast0_eff",effect_pack="b60150",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Tyrfing_attack_general",path_target={ref_type=1}}
}
};

return this;