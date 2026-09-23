--FireBall数据
local this = 
{
[1310282141]={
{delay=4500,time=5000,type=1,hit_type=1,camera_shake={time=700,shake_dir=1,range=250,range1=100,range2=25,hz=30,decay_value=0.3},hits={0}},
{delay=2700,time=5000,type=1,hit_type=0,hits={0}},
{time=5800,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Jadeite_attack_skill_02"},
{effect="cast2_hit",time=5200,type=0,pos_ref={ref_type=1,lock_col=1}},
{effect="cast2_eff",time=4860,type=0,pos_ref={ref_type=6},cue_sheet="cv/Jadeite.acb",cue_name="Jadeite_11",cue_feature=1}
},
[-686817241]={
{delay=400,time=3000,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Jadeite_attack_skill_01"},
{effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=15}},
{effect="cast1_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Jadeite.acb",cue_name="Jadeite_10",cue_feature=1},
{delay=2200,time=2000,type=3,hits={0}}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=1}
},
[-1609092943]={
{time=2000,type=1,hit_type=0,is_fake=1,fake_damage=1,camera_shake={time=100,shake_dir=1,range=100,range2=25,hz=30,decay_value=0.3},hits={400,950}},
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Jadeite.acb",cue_name="Jadeite_09",cue_feature=1},
{effect="cast0_eff2",delay=330,time=3000,type=0,pos_ref={ref_type=1}},
{delay=1500,time=2000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=350,range1=100,range2=25,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{time=3000,type=0,cue_sheet="fight/effect/eighth.acb",cue_name="Jadeite_attack_general"}
}
};

return this;