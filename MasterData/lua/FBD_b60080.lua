--FireBall数据
local this = 
{
[1310282141]={
{time=5000,type=1,hit_type=1,hits={3500}},
{delay=2800,time=6000,type=0,cue_sheet="cv/Claimh_Solais.acb",cue_name="Claimh_Solais_12",cue_feature=1},
{effect="cast2_eff",time=9000,type=0,pos_ref={ref_type=6}},
{delay=3000,time=6000,type=0,cue_sheet="fight/effect/explosion_.acb",cue_name="Explode_Texture_01"},
{time=5000,type=1,hit_type=1,camera_shake={time=600,range=350,range1=50,range2=350,hz=80,decay_value=0.4},hits={3000}},
{time=6000,type=0,cue_sheet="fight/effect/clausolas_cast.acb",cue_name="clausolas_attack_skill_02"},
{time=6000,type=0,cue_sheet="cv/Claimh_Solais.acb",cue_name="Claimh_Solais_11",cue_feature=1}
},
[-1368377223]={
effect="qc_shoot_medium_hit",effect_pack="common_hit",time=2200,type=0,pos_ref={ref_type=1}
},
[-686817241]={
{effect="cast1_eff",time=2200,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{time=2200,type=0,cue_sheet="fight/effect/clausolas_cast.acb",cue_name="clausolas_attack_skill_01"},
{delay=1050,time=2000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=300,range1=200,range2=15,hz=30,decay_value=0.3},hit_creates={-1368377223},hits={0}},
{time=2200,type=0,cue_sheet="cv/Claimh_Solais.acb",cue_name="Claimh_Solais_10",cue_feature=1}
},
[-1609092943]={
{effect="cast0_eff",time=2200,type=0,pos_ref={ref_type=6}},
{delay=1000,time=2000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=100,range1=700,hz=30,decay_value=0.3},hit_creates={661633433,537034112},hits={0}},
{time=2200,type=0,cue_sheet="cv/Claimh_Solais.acb",cue_name="Claimh_Solais_09",cue_feature=1},
{time=2200,type=0,cue_sheet="fight/effect/clausolas_cast.acb",cue_name="clausolas_attack_general"}
},
[661633433]={
effect="cast0_hit",time=2200,type=0,pos_ref={ref_type=4,part_index=0}
},
[537034112]={
effect="qc_blunt_medium_hit",effect_pack="common_hit",time=2200,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;