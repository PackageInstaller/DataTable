--FireBall数据
local this = 
{
[1310282141]={
{delay=3950,time=7000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=0,camera_shake={time=299,shake_dir=1,range=500,range1=500,range2=500,hz=30,decay_value=0.3},hits={0}},
{effect="cast2_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="hurricane_attack_skill_02"},
{delay=3900,time=7000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=0,camera_shake={time=299,shake_dir=1,range=500,range1=500,range2=500,hz=30,decay_value=0.3},hits={0}},
{effect="cast2_hit",time=7000,type=0,pos_ref={ref_type=3}},
{delay=3800,time=7000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=0,camera_shake={time=299,shake_dir=1,range=500,range1=500,range2=500,hz=30,decay_value=0.3},hits={0}},
{delay=5000,time=7000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=0,camera_shake={time=700,shake_dir=1,range=800,range1=800,range2=800,hz=30,decay_value=0.3},hits={0}},
{delay=4200,time=7000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=0,camera_shake={time=299,shake_dir=1,range=300,range1=300,range2=300,hz=30,decay_value=0.3},hits={0}},
{delay=4150,time=7000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="Explode_Texture_03",hit_type=1,camera_shake={time=299,shake_dir=1,range=500,range1=500,range2=500,hz=30,decay_value=0.3},hits={0}},
{delay=200,time=4000,type=0,cue_sheet="cv/Hurricane.acb",cue_name="Hurricane_12",cue_feature=1}
},
[-686817241]={
{time=3000,type=1,hit_type=1,hits={1900}},
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{time=3000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="hurricane_attack_skill_01"},
{effect="cast1_hit",time=4000,type=0,pos_ref={ref_type=5,offset_row=50,offset_col=-50}},
{delay=100,time=2000,type=0,cue_sheet="cv/Hurricane.acb",cue_name="Hurricane_10",cue_feature=1},
{time=3000,type=1,hit_type=0,camera_shake={time=900,shake_dir=1,range=350,range1=200,range2=100,hz=30,decay_value=0.3},hits={1600}}
},
[-1609092943]={
{time=2000,type=0,cue_sheet="cv/Hurricane.acb",cue_name="Hurricane_09",cue_feature=1},
{effect="cast0_eff",time=1900,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="hurricane_attack_general"},
{time=2000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=500,range2=25,hz=30,decay_value=0.3},hit_creates={661633433},hits={800}}
},
[661633433]={
effect="cast0_hit",time=1900,type=0,pos_ref={ref_type=4,part_index=0},cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_03"
},
[-1328923786]={
{time=4000,type=0},
{effect="win",time=4000,type=0,pos_ref={ref_type=6}}
}
};

return this;