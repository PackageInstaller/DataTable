--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6,offset_row=50},cue_sheet="fight/effect/thrid.acb",cue_name="Shaping2_attack_skill_01"},
{delay=1300,time=4000,type=1,hit_type=1,camera_shake={time=700,shake_dir=1,range=200,hz=30,decay_value=0.25},hits={0}},
{effect="cast1_hit",time=4000,type=0,pos_ref={ref_type=6,offset_row=50}},
{delay=1250,time=3500,type=0,cue_sheet="fight/effect/explosion_.acb",cue_name="future_gun_hit_1"},
{delay=1350,time=3500,type=0,cue_sheet="fight/effect/explosion_.acb",cue_name="future_gun_hit_1"},
{delay=1350,time=3500,type=0,cue_sheet="fight/effect/explosion_.acb",cue_name="future_gun_hit_1"},
{delay=1450,time=3500,type=0,cue_sheet="fight/effect/explosion_.acb",cue_name="future_gun_hit_1"}
},
[-1609092943]={
{effect="cast0_eff",time=4000,path_index=0,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="Shaping2_attack_skill_01",path_target={ref_type=1}},
{delay=850,time=4000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=0,camera_shake={time=90,shake_dir=1,range=50,range1=10,hz=30,decay_value=0.3},hit_creates={-944091001},hits={0}},
{delay=950,time=4000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=0,camera_shake={time=90,shake_dir=1,range=50,range1=10,hz=30,decay_value=0.3},hit_creates={-1329766383},hits={0}},
{delay=1050,time=4000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=0,camera_shake={time=200,shake_dir=1,range=50,range1=10,hz=30,decay_value=0.3},hit_creates={1443023035},hits={0}}
},
[-944091001]={
effect="cast0_hit02",time=5000,type=0,pos_ref={ref_type=1}
},
[-1329766383]={
effect="cast0_hit01",time=5000,type=0,pos_ref={ref_type=1}
},
[1443023035]={
effect="cast0_hit01",time=5000,type=0,pos_ref={ref_type=1}
}
};

return this;