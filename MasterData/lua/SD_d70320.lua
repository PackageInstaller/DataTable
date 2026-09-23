--状态数据
local this = 
{
SummonTeammate={play_time=200},
idle={play_time=6000,hide_buff=1},
cast1={play_time=500,feature=1,feature_camera_no_transform=1,hide_buff=1},
cast2={play_time=8500,start_pos={ref_type=10,offset_row=1200},last_hit=7500,hide_scene=1,hide_scene_time=8300,hide_buff=1,showDatas={{delay=2150,isFriend=1,includeSelf=1}}},
cast3_1={play_time=1500,feature=1,feature_time=1500,hide_buff=1},
cast3_2={play_time=8000,start_pos={ref_type=10},spe_setting="spe_setting_cast3_2",last_hit=1700,hide_buff=1},
cast0={play_time=2000,face_to_target=1,last_hit=1010,hide_buff=1},
enter={play_time=7200,start_pos={ref_type=10}},
win={play_time=2000,hide_buff=1},
cast4={play_time=2000,last_hit=900,hide_buff=1}
};

return this;