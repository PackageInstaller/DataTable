--FireBall数据
local this = 
{
[-686817241]={
{delay=2000,time=4000,type=1,hit_type=1,camera_shake={time=150,shake_dir=1,range=400,range1=350,range2=400,hz=10,decay_value=0.6},hits={0}},
{effect="cast1_hit",delay=2000,time=2000,type=0,pos_ref={ref_type=1,offset_row=-250,lock_col=1}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Backpacker_attack_skill_01",path_target={ref_type=1}}
},
[1310282141]={
{time=4000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=400,range1=100,range2=400,hz=10,decay_value=0.3},hits={1590}},
{effect="cast2_hit",time=6000,type=0,pos_ref={ref_type=1,offset_row=-150,lock_col=1}},
{effect="cast2_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Backpacker_attack_skill_02",path_target={ref_type=3}},
{time=4000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=400,range1=100,range2=400,hz=10,decay_value=0.3},hits={1986}},
{time=4000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=400,range1=100,range2=400,hz=10,decay_value=0.3},hits={2800}}
},
[-1609092943]={
{time=4000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=300,range1=100,range2=100,hz=10,decay_value=0.6},hit_creates={1349028111},hits={500}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Backpacker_attack_general"}
},
[1349028111]={
effect="cast0_hit",delay=1000,time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win_eff",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;