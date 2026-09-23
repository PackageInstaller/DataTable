--FireBall数据
local this = 
{
[-58110172]={
{effect="martina_transform",effect_pack="u30010",time=3000,type=0,pos_ref={ref_type=6}},
{delay=500,time=3000,type=0,cue_sheet="cv/machairodus.acb",cue_name="0_4",cue_feature=1}
},
[1310282141]={
{effect="cast2_eff",time=14000,type=0,pos_ref={ref_type=10}},
{effect="cast2_hit",time=14000,type=0,pos_ref={ref_type=10}},
{time=5000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=500,range2=25,hz=30,decay_value=0.3},hits={2250,2900}},
{time=8000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=100,range1=300,range2=25,hz=30,decay_value=0.3},hits={3500}},
{time=8000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=500,range2=300,hz=30,decay_value=0.3},hits={5000,5700,6400,7700}},
{time=8000,type=1,hit_type=0,is_fake=1,fake_damage=1,camera_shake={time=500,shake_dir=1,range=500,range2=300,hz=30,decay_value=0.3},hits={6700,6900}},
{time=13000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=200,range1=200,range2=200,hz=30,decay_value=0.3},hits={9100}},
{time=13000,type=1,hit_type=1,camera_shake={time=2000,shake_dir=1,range=100,range1=100,range2=100,hz=30,decay_value=0.3},hits={10500}},
{delay=500,time=14000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="dinocrocuta_fight_attack_skill_02"}
},
[-686817241]={
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="dinocrocuta_fight_attack_skill_01"},
{delay=600,time=3500,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03",hit_type=1,camera_shake={time=450,shake_dir=1,range=500,range2=25,hz=30,decay_value=0.3},hits={0}},
{delay=1100,time=3500,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03",hit_type=1,camera_shake={time=500,shake_dir=1,range=200,range1=200,range2=25,hz=30,decay_value=0.3},hits={0}},
{time=3500,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=500,range1=100,range2=25,hz=30,decay_value=0.3},hits={1700,1800}},
{delay=1700,time=3500,type=0,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_04"},
{delay=1800,time=3500,type=0,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05"}
},
[-1609092943]={
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=1},cue_sheet="fight/effect/thrid.acb",cue_name="dinocrocuta_fight_attack_general"},
{delay=400,time=3000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03",hit_type=0,camera_shake={time=350,shake_dir=1,range=300,range1=100,range2=25,hz=30,decay_value=0.3},hits={0}},
{delay=800,time=3000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03",hit_type=1,camera_shake={time=400,shake_dir=1,range=200,range2=25,hz=30,decay_value=0.6},hits={0}}
},
[-1328923786]={
{time=3000,type=0}
}
};

return this;