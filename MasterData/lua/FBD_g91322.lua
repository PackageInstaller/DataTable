--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",time=10000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="CorruptSword_attack_skill_01"},
{time=10000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,range2=200,hz=50,decay_value=0.6},hit_creates={1192467788},hits={1200}}
},
[1192467788]={
time=10000,type=0
},
[-1609092943]={
{effect="cast0_eff",time=10000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="CorruptSword_attack_general"},
{time=10000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=200,range2=200,hz=50,decay_value=0.6},hit_creates={1349028111},hits={560}}
},
[1349028111]={
effect="cast0_hit",time=10000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1328923786]={
{effect="win",time=10000,type=0,pos_ref={ref_type=6}}
}
};

return this;