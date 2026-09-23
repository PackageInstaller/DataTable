--状态数据
local this = 
{
transform={play_time=3000,common_camera="common_buff",transform_delay=1,transform_enter_state="transform_enter",transform_enter_state_delay=1},
cast2={play_time=12000,start_pos={ref_type=10,offset_row=50},last_hit=8300,hide_scene=1,hide_buff=1,showDatas={{delay=0,isEnemy=1},{delay=6000,showState=1,isEnemy=1}},faceDatas={{delay=0,name="1"},}},
cast1={play_time=3300,face_to_target=1,feature=1,feature_camera_no_transform=1,last_hit=2400},
cast0={play_time=1500,face_to_target=1,last_hit=900},
enter={play_time=3000},
win={play_time=3000}
};

return this;