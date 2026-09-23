--FireBall数据
local this = 
{
[-686817241]={
{time=2500,type=0,cue_sheet="cv/Vodka.acb",cue_name="Vodka_10",cue_feature=1},
{time=3000,type=3,hit_creates={1192467788},hits={0}},
{effect="cast1_eff02",effect_pack="d75010",time=3500,type=0,pos_ref={ref_type=6,offset_row=100},cue_sheet="fight/effect/seventeen.acb",cue_name="Vodka_Mirror_attack_skill_01"},
{effect="cast1_eff01",effect_pack="d75010",time=3500,type=0,pos_ref={ref_type=13,offset_row=100}}
},
[1192467788]={
time=3000,type=0
},
[1310282141]={
{time=2500,type=0,cue_sheet="cv/Vodka.acb",cue_name="Vodka_11",cue_feature=1},
{delay=2967,time=7800,type=0,cue_sheet="cv/Vodka.acb",cue_name="Vodka_12",cue_feature=1},
{time=7800,type=1,hit_type=1,hits={5000,6300,6500,6700}},
{effect="cast2_eff",effect_pack="d75010",time=7800,type=0,pos_ref={ref_type=6,offset_row=100},cue_sheet="fight/effect/seventeen.acb",cue_name="Vodka_Mirror_attack_skill_02"},
{effect="cast2_hit",effect_pack="d75010",time=7800,type=0,pos_ref={ref_type=1,offset_row=-300}}
},
[-1609092943]={
{time=2500,type=0,cue_sheet="cv/Vodka.acb",cue_name="Vodka_09",cue_feature=1},
{time=2500,type=0,cue_sheet="fight/effect/seventeen.acb",cue_name="Vodka_Mirror_attack_general"},
{delay=801,time=3000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=100,range2=100,hz=10,decay_value=0.6},hit_creates={1349028111},hits={0,860}},
{effect="cast0_eff",effect_pack="d75010",time=3000,type=0,pos_ref={ref_type=6,offset_row=100},path_target={ref_type=1}}
},
[1349028111]={
effect="cast0_hit",effect_pack="d75010",time=3000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1183793042]={
{effect="enter",effect_pack="d75010",time=3000,type=0,pos_ref={ref_type=6,offset_row=100}}
},
[-1328923786]={
{effect="win",effect_pack="d75010",time=3000,type=0,pos_ref={ref_type=6,offset_row=100}}
}
};

return this;