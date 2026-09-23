--FireBall数据
local this = 
{
[-686817241]={
{delay=2400,time=5500,type=2,hits={0}},
{delay=2400,time=5500,type=3,hits={0}},
{effect="cast1_eff1",time=5500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Horus_attack_skill_01"},
{effect="cast1_eff2",time=5500,type=0,pos_ref={ref_type=13}},
{time=5500,type=0,cue_sheet="cv/Horus.acb",cue_name="Horus_10",cue_feature=1}
},
[2124325257]={
effect="cast2_hit",time=5500,type=0,pos_ref={ref_type=4,part_index=1},dont_remove_when_skip=1
},
[1310282141]={
{delay=6600,time=5500,type=3,hit_creates={2124325257},hits={0}},
{effect="cast2_eff",time=5900,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Horus_attack_skill_02"},
{time=5600,type=0,cue_sheet="cv/Horus.acb",cue_name="Horus_11",cue_feature=1},
{effect="cast2_eff2",delay=5700,time=5500,type=0,pos_ref={ref_type=13},dont_remove_when_skip=1}
},
[-1609092943]={
{delay=920,time=5500,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=400,range1=330,hz=300,decay_value=0.25},hits={0}},
{effect="cast0_hit",time=5500,type=0,pos_ref={ref_type=0}},
{effect="cast0_eff",time=5500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Horus_attack_general"},
{time=5500,type=0,cue_sheet="cv/Horus.acb",cue_name="Horus_09",cue_feature=1}
},
[-316323548]={
{time=5500,type=0}
},
[-1183793042]={
{effect="enter",time=5500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",time=5500,type=0,pos_ref={ref_type=6}}
}
};

return this;