-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_throw_shells_prop.lua

module("logicconfig.config.t_throw_shells_prop", package.seeall)

local title = {
	gravity = 12,
	shoot = 7,
	idle = 6,
	propId = 1,
	leaderLen = 8,
	damage = 9,
	range = 10,
	path = 3,
	src = 2,
	wind = 11,
	boom = 5,
	airDragFactor = 13,
	quality = 14,
	qiangkou = 4
}
local dataList = {
	{
		1,
		"icon_xxy_hlb",
		"fx_ui_dandaofeibiao",
		"fx_ui_dandaofeibiaobao",
		"fx_ui_dandaobaodian_02",
		"idle2",
		"skill2",
		600,
		250,
		{
			0,
			120
		},
		80,
		60,
		5,
		5
	},
	{
		2,
		"icon_xxy_yj",
		"fx_ui_dandaogongjian",
		"fx_ui_dandaogongjianbao",
		"fx_ui_dandaobaodian_03",
		"idle3",
		"skill3",
		500,
		300,
		{
			0,
			120
		},
		90,
		60,
		5,
		5
	},
	{
		3,
		"icon_xxy_dp",
		"fx_ui_dandaozidan_01",
		"fx_ui_dandaoqiangkou_01",
		"fx_ui_dandaobaodian_01",
		"idle1",
		"skill1",
		900,
		400,
		{
			0,
			150
		},
		100,
		70,
		5,
		10
	}
}
local t_throw_shells_prop = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_throw_shells_prop.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_throw_shells_prop
