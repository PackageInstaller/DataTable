--FireBall数据
local this = 
{
[-686817241]={
{time=3500,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=200,range2=200,hz=30,decay_value=0.6},hit_creates={1192467788},hits={800}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Anchor_Berserker_attack_skill_01"}
},
[1192467788]={
effect="cast1_hit",delay=800,time=3500,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1609092943]={
{delay=1100,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=10,decay_value=0.6},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/sixteen.acb",cue_name="Anchor_Berserker_attack_general"}
},
[1349028111]={
effect="cast0_hit",delay=1100,time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-316323548]={
{effect="dead",delay=566,time=3500,type=0,pos_ref={ref_type=6}}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;