--FireBall数据
local this = 
{
[1310282141]={
{effect="csat2_eff",time=12666,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/eleventh.acb",cue_name="Badlands_attack_skill_02"},
{delay=9900,time=7000,type=1,hit_type=1,hits={0}},
{delay=10200,time=7000,type=1,hit_type=1,hits={0}},
{delay=1166,time=12666,type=0,cue_sheet="cv/Badlands.acb",cue_name="Badlands_11",cue_feature=1},
{delay=9600,time=7000,type=1,hit_type=1,hits={0}},
{delay=5162,time=12666,type=0,cue_sheet="cv/Badlands.acb",cue_name="Badlands_12_b",cue_feature=1},
{delay=10500,time=7000,type=1,hit_type=1,hits={0}}
},
[-686817241]={
{time=3800,type=0,cue_sheet="cv/Badlands.acb",cue_name="Badlands_10",cue_feature=1},
{effect="cast1_eff",time=3800,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/eleventh.acb",cue_name="Badlands_attack_skill_01"},
{time=3600,type=1,hit_type=0,is_fake=1,hit_creates={806661594},hits={0}},
{delay=2740,time=5000,type=1,hit_type=0,camera_shake={time=350,shake_dir=1,range=250,range1=30,range2=30,hz=35,decay_value=0.35},hits={0}},
{delay=1222,time=5000,type=1,hit_type=0,camera_shake={time=1500,shake_dir=1,range=100,range1=25,range2=25,hz=35,decay_value=0.8},hits={0}}
},
[806661594]={
effect="cast1_hit",time=4000,type=0,pos_ref={ref_type=4,offset_row=-400,part_index=1}
},
[-1609092943]={
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/eleventh.acb",cue_name="Badlands_attack_general"},
{delay=1100,time=2278,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=400,range2=200,hz=30,decay_value=0.3},hits={0}},
{effect="cast0_hit",time=3200,type=0,pos_ref={ref_type=0}},
{delay=1644,time=1578,type=1,hit_type=0,camera_shake={time=1000,shake_dir=1,range=200,range2=200,hz=30,decay_value=0.3},hits={0}},
{time=3500,type=0,cue_sheet="cv/Badlands.acb",cue_name="Badlands_09",cue_feature=1}
}
};

return this;