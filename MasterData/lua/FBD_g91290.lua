--FireBall数据
local this = 
{
[-686817241]={
{time=3500,type=0,cue_sheet="fight/effect/sixteen.acb",cue_name="Mimic_sea_creature_type_Ⅱ_attack_skill_01"},
{time=3500,type=3,hit_creates={-1457652640},hits={500}}
},
[-1457652640]={
time=3500,type=0
},
[1310282141]={
{delay=700,time=4000,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=150,range2=150,hz=50,decay_value=0.6},hits={0}},
{delay=700,time=4000,type=1,hit_type=1,hits={100,200,300,400,500}},
{effect="cast2_hit",delay=700,time=5000,type=0,pos_ref={ref_type=1,offset_row=-250}},
{effect="cast2_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Mimic_sea_creature_type_Ⅱ_attack_skill_02",path_target={ref_type=1}}
},
[-1609092943]={
{delay=1500,time=4000,type=1,hit_type=1,hits={100,200,300}},
{effect="cast0_hit",delay=1500,time=5000,type=0,pos_ref={ref_type=1,offset_row=-250}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Mimic_sea_creature_type_Ⅱ_attack_general",path_target={ref_type=1}},
{delay=1500,time=4000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=100,range2=100,hz=50,decay_value=0.6},hits={0}}
},
[-316323548]={
{effect="dead",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{time=3500,type=0}
}
};

return this;