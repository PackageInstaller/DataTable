--FireBall数据
local this = 
{
[1310282141]={
{effect="cast2_eff",time=12200,type=0,pos_ref={ref_type=10,offset_row=-450},cue_sheet="fight/effect/twelfth.acb",cue_name="OKA_attack_skill_02"},
{delay=8023,time=3000,type=1,hit_type=1,hits={0}},
{delay=11000,time=3000,type=1,hit_type=1,hits={0}},
{delay=8500,time=3000,type=1,hit_type=1,hits={0}},
{delay=10644,time=3000,type=1,hit_type=1,hits={0}}
},
[-686817241]={
{effect="cast1_eff",time=2800,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="OKA_attack_skill_01"},
{delay=633,time=3000,type=1,hit_type=0,camera_shake={time=444,shake_dir=1,range=300,range1=144,range2=30,hz=22,decay_value=0.3},hits={0}},
{delay=1133,time=3000,type=1,hit_type=0,camera_shake={time=444,shake_dir=1,range=300,range1=144,range2=30,hz=22,decay_value=0.3},hits={0}}
},
[-1609092943]={
{effect="cast0_eff",time=2000,path_index=0,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="OKA_attack_general",path_target={ref_type=1}},
{delay=850,time=2000,type=1,hit_type=0,camera_shake={time=330,shake_dir=1,range=350,range1=250,range2=33,hz=30,decay_value=0.3},hit_creates={-838067028},hits={0}},
{delay=550,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=300,range1=200,range2=25,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}}
},
[-838067028]={
effect="cast0_hit2",time=2000,type=0,pos_ref={ref_type=1,offset_height=-50}
},
[661633433]={
effect="cast0_hit1",time=2000,type=0,pos_ref={ref_type=1,offset_height=-50}
},
[-1328923786]={
{time=4000,type=0}
}
};

return this;