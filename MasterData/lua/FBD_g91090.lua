--FireBall数据
local this = 
{
[-686817241]={
{delay=1250,time=4000,type=1,hit_type=1,camera_shake={time=100,shake_dir=1,range=200,range1=350,range2=200,hz=60,decay_value=0.6},hit_creates={1192467788},hits={0,100}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Kadath_attack_skill_01"}
},
[1192467788]={
effect="cast1_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[1310282141]={
{time=4000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=200,range1=100,range2=150,hz=30,decay_value=0.3},hit_creates={2124325257},hits={1150,1700,2450}},
{effect="cast2_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Kadath_attack_skill_02"}
},
[2124325257]={
effect="cast2_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{time=4000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=300,range1=100,range2=100,hz=30,decay_value=0.3},hit_creates={1349028111},hits={500}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Kadath_attack_general"}
},
[1349028111]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-316323548]={
{time=3500,type=0}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{time=3500,type=0}
}
};

return this;