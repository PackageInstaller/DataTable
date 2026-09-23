--FireBall数据
local this = 
{
[-686817241]={
{delay=1430,time=3000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hits={0}},
{delay=1100,time=3000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hit_creates={-1457652640},hits={0}},
{time=3000,type=0,cue_sheet="fight/effect/thirteen.acb",cue_name="Riel_Vanguard_attack_skill_01"}
},
[-1457652640]={
effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=0,offset_row=42}
},
[-1609092943]={
{delay=930,time=2000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hit_creates={661633433},hits={0,200}},
{time=2500,type=0,cue_sheet="fight/effect/thirteen.acb",cue_name="Riel_Vanguard_attack_general"},
{effect="cast0_eff",delay=280,time=2500,type=0,pos_ref={ref_type=6}}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1183793042]={
{effect="enter",time=3000,type=0,pos_ref={ref_type=6}}
}
};

return this;