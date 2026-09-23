--状态数据
local this = 
{
eff_addition_pack={"common_hit"},
enter={play_time=5000},
summon={play_time=8100,hide_scene=1,skill_scene="black",hide_buff=1,summon_delay=0},
cast2={play_time=5200,start_pos={ref_type=12,offset_row=400},last_hit=4200,hide_scene=1,hide_buff=1,showDatas={{delay=2700,showState=1,isEnemy=1},{delay=0,isEnemy=1}}},
cast1={play_time=2800,start_pos={ref_type=0,offset_row=-150},feature=1,feature_camera_no_transform=1,last_hit=1900,hide_buff=1},
cast0={play_time=1450,start_pos={ref_type=0,offset_row=-150},last_hit=600,hide_buff=1}
};

return this;