--FireBall数据
local this = 
{
[1310282141]={
{delay=13500,time=16000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={100,200,300,400,500}},
{delay=14000,time=16000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0,100,200}},
{time=16000,type=0},
{effect="cast2_eff",time=16000,type=0,pos_ref={ref_type=6}},
{delay=600,time=16000,type=0,cue_sheet="cv/Midnight.acb",cue_name="Midnight_11",cue_feature=1},
{delay=12167,time=16000,type=0,cue_sheet="cv/Midnight.acb",cue_name="Midnight_12",cue_feature=1},
{time=16000,type=0,cue_sheet="fight/effect/seventeen.acb",cue_name="Midnight_attack_skill_02"}
},
[-686817241]={
{time=4000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=100,range2=100,hz=10,decay_value=0.6},hits={600}},
{effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=1,lock_col=1}},
{time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.6},hits={1500}},
{time=11000,type=0,cue_sheet="fight/effect/seventeen.acb",cue_name="Midnight_attack_skill_01"},
{effect="cast1_eff",time=11000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Midnight.acb",cue_name="Midnight_10",cue_feature=1}
},
[-1609092943]={
{time=11000,type=0,cue_sheet="fight/effect/seventeen.acb",cue_name="Midnight_attack_general"},
{delay=400,time=4000,type=1,hit_type=1,camera_shake={time=100,shake_dir=1,range=500,range2=500,hz=10,decay_value=0.6},hits={500}},
{delay=400,time=4000,type=1,hit_type=1,camera_shake={time=100,shake_dir=1,range=100,range2=100,hz=10,decay_value=0.6},hits={0}},
{effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=1}},
{effect="cast0_eff",time=11000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Midnight.acb",cue_name="Midnight_09",cue_feature=1}
},
[-1183793042]={
{effect="enter",time=11000,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",time=11000,type=0,pos_ref={ref_type=6}}
}
};

return this;