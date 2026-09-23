--FireBall数据
local this = 
{
[-686817241]={
{time=2500,type=0,cue_sheet="cv/Barbera.acb",cue_name="Barbera_10",cue_feature=1},
{time=3000,type=3,hit_creates={1192467788},hits={0}},
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6,offset_row=100}},
{time=2500,type=0,cue_sheet="fight/effect/seventeen.acb",cue_name="Barbera_Red_attack_skill_01"}
},
[1192467788]={
time=3000,type=0
},
[1310282141]={
{delay=533,time=3400,type=0,cue_sheet="cv/Barbera.acb",cue_name="Barbera_11",cue_feature=1},
{time=11000,type=0,cue_sheet="fight/effect/seventeen.acb",cue_name="Barbera_Red_attack_skill_02"},
{time=13000,type=1,hit_type=1,hits={4450,5800,8000,9500,5000,9300}},
{delay=6333,time=11000,type=0,cue_sheet="cv/Barbera.acb",cue_name="Barbera_12",cue_feature=1},
{effect="cast2_eff",time=11000,type=0,pos_ref={ref_type=6,offset_row=100}}
},
[-1609092943]={
{time=2500,type=0,cue_sheet="cv/Barbera.acb",cue_name="Barbera_09",cue_feature=1},
{time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range2=300,hz=50,decay_value=0.6},hits={1000,1200}},
{effect="cast0_hit",time=5000,type=0,pos_ref={ref_type=0}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=0,offset_row=-250}},
{time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range2=300,hz=50,decay_value=0.6},hits={2200,2300}},
{time=2500,type=0,cue_sheet="fight/effect/seventeen.acb",cue_name="Barbera_Red_attack_general"},
{effect="cast0_disappear",time=4500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="enter",time=3000,type=0,pos_ref={ref_type=10,offset_row=100}}
},
[-1183793042]={
{effect="win",time=3000,type=0,pos_ref={ref_type=10,offset_row=100}}
}
};

return this;