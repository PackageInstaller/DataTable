--FireBall数据
local this = 
{
[-1183793042]={
{effect="enter",time=2500,type=0,pos_ref={ref_type=6}}
},
[1310282141]={
{delay=9220,time=15000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}},
{delay=5900,time=15000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}},
{time=11000,type=0,cue_sheet="fight/effect/twelfth.acb",cue_name="Ruby_attack_skill_02"},
{delay=9600,time=15000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}},
{delay=5400,time=11000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}},
{delay=9900,time=15000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}},
{effect="cast2_eff",time=11000,type=0,pos_ref={ref_type=6}},
{delay=6727,time=11000,type=0,cue_sheet="cv/Ruby.acb",cue_name="Ruby_12",cue_feature=1},
{delay=9900,time=15000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}},
{delay=9700,time=15000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}},
{delay=9900,time=15000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}},
{delay=733,time=11000,type=0,cue_sheet="cv/Ruby.acb",cue_name="Ruby_11",cue_feature=1}
},
[-1609092943]={
{delay=950,time=2050,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=500,range1=250,range2=50,hz=30,decay_value=0.3},hit_creates={1349028111},hits={0}},
{time=2050,type=0,cue_sheet="cv/Ruby.acb",cue_name="Ruby_09",cue_feature=1},
{delay=365,time=2050,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=300,range1=150,hz=30,decay_value=0.25},hit_creates={661633433},hits={0}},
{effect="cast0_eff",time=2050,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="Ruby_attack_general"}
},
[661633433]={
effect="cast0_hit1",time=2050,type=0,pos_ref={ref_type=4,part_index=1}
},
[1349028111]={
effect="cast0_hit2",time=2050,type=0,pos_ref={ref_type=4,part_index=1}
}
};

return this;