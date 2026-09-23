--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=6000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="gram_attack_skill_02"},
{delay=4700,time=8000,type=1,hit_type=1,camera_shake={time=199,shake_dir=1,range=200,range1=200,range2=200,hz=30,decay_value=0.3},hits={0}},
{delay=5700,time=8000,type=1,hit_type=1,camera_shake={time=1200,shake_dir=1,range=400,range1=200,range2=400,hz=30,decay_value=0.3},hits={0}},
{delay=4900,time=8000,type=1,hit_type=1,camera_shake={time=199,shake_dir=1,range=200,range1=200,range2=200,hz=30,decay_value=0.3},hits={0}},
{delay=5100,time=8000,type=1,hit_type=1,camera_shake={time=199,shake_dir=1,range=200,range1=200,range2=200,hz=30,decay_value=0.3},hits={0}},
{delay=5300,time=8000,type=1,hit_type=1,camera_shake={time=199,shake_dir=1,range=200,range1=200,range2=200,hz=30,decay_value=0.3},hits={0}},
{delay=5500,time=8000,type=1,hit_type=1,camera_shake={time=199,shake_dir=1,range=200,range1=200,range2=200,hz=30,decay_value=0.3},hits={0}},
{delay=200,time=8000,type=0,cue_sheet="cv/gram.acb",cue_name="gram_11",cue_feature=1},
{delay=3267,time=8000,type=0,cue_sheet="cv/gram.acb",cue_name="gram_12",cue_feature=1}
},
[-686817241]={
{effect="cast1_eff",time=2500,type=0,pos_ref={ref_type=6}},
{delay=1400,time=2000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=1,camera_shake={time=800,shake_dir=1,range=400,range1=100,range2=200,hz=30,decay_value=0.3},hit_creates={-1368377223},hits={0}},
{time=2000,type=0,cue_sheet="cv/gram.acb",cue_name="gram_10",cue_feature=1},
{time=3000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="gram_attack_skill_01"}
},
[-1368377223]={
effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="gram_attack_general"},
{delay=800,time=2000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=100,range1=300,range2=100,hz=30,decay_value=0.3},hits={0}},
{time=2000,type=0,cue_sheet="cv/gram.acb",cue_name="gram_09",cue_feature=1},
{effect="common_hit2",effect_pack="common_hit",delay=800,time=2000,type=0,pos_ref={ref_type=1}}
}
};

return this;