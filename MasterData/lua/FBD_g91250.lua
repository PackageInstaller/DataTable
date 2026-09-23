--FireBall数据
local this = 
{
[-686817241]={
{delay=1500,time=3500,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=200,range2=200,hz=50,decay_value=0.6},hit_creates={1192467788},hits={0}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Furious_Gunner_attack_skill_01"}
},
[1192467788]={
effect="cast1_hit",time=3500,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1609092943]={
{delay=950,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=200,range2=200,hz=50,decay_value=0.6},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Furious_Gunner_attack_general",path_target={ref_type=1}}
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