--状态数据
local this = 
{
eff_addition_pack={"g90770","g90610"},
enter={play_time=5000,camera_shakes={{time=400,delay=500,range=300,hz=30,decay_value=20}}},
cast2={play_time=3300,feature=1,feature_camera_no_transform=1,last_hit=2100,no_cast_camera=1,camera_shakes={{time=360,delay=730,range=130,hz=160,decay_value=55},{time=600,delay=1800,range=180,hz=200,decay_value=55}}},
cast1={play_time=2800,feature=1,feature_camera_no_transform=1,last_hit=1450},
cast0={play_time=2000,face_to_target=1,last_hit=620},
dead={play_time=3000}
};

return this;