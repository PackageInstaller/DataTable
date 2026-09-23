--FireBall数据
local this = 
{
[-686817241]={
{time=4000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=200,range1=100,range2=150,hz=30,decay_value=0.3},hits={772,1757}},
{effect="cast1_hit",time=4000,type=0,pos_ref={ref_type=1}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Tentacle_attack_skill_01"}
},
[-1609092943]={
{time=4000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=200,range1=100,range2=150,hz=30,decay_value=0.3},hit_creates={1349028111},hits={1312}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Tentacle_attack_general",path_target={ref_type=1}}
},
[1349028111]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-316323548]={
{effect="dead",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;