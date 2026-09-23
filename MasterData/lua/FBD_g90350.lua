--FireBall数据
local this = 
{
[-1457652640]={
effect="cast1_eff2",effect_no_flip=1,delay=10,time=2000,path_index=100,type=0,pos_ref={ref_type=6}
},
[-686817241]={
{time=2000,type=1,hit_type=0,is_fake=1,hit_creates={-1457652640},hits={480}},
{delay=580,time=2000,type=1,hit_type=0,hit_delay_coeff_dis=20,hit_dis_offset=0,camera_shake={time=500,shake_dir=1,range=250,range1=50,range2=25,hz=30,decay_value=0.3},hit_creates={-646510353},hits={0}},
{effect="cast1_eff",delay=500,time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/monsters_cast.acb",cue_name="harpie1_attack_skill_01"}
},
[-646510353]={
effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{effect="cast0_eff",delay=360,time=2000,type=0,pos_ref={ref_type=6}},
{effect="cast0_hit",delay=440,time=2000,type=0,pos_ref={ref_type=1}},
{delay=580,time=2000,type=1,hit_type=0,camera_shake={time=350,shake_dir=1,range=350,hz=30,decay_value=0.25},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/monsters_cast.acb",cue_name="harpie1_attack_general"}
}
};

return this;