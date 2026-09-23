--状态数据
local this = 
{
change={play_time=4500,transform_delay=4500,transform_enter_state="change",transform_enter_state_delay=0},
transform={play_time=4700,common_camera="common_buff",transform_delay=0,transform_enter_state="change",transform_enter_state_delay=0},
cast1={play_time=3500},
cast2={play_time=14000,start_pos={ref_type=3,offset_row=-100},last_hit=13000,showDatas={{delay=0,isEnemy=1},{delay=5000,showState=1,isEnemy=1}}},
cast0={play_time=3300,face_to_target=1,last_hit=1900,dont_hide_friend=1},
enter={play_time=2500},
win={play_time=3000}
};

return this;