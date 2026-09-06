-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_run_game_common.lua

module("logicconfig.config.t_run_game_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"BackGround_NormalSpeed",
		"800"
	},
	{
		"BackGround_AccelerateSpeed",
		"1600"
	},
	{
		"BackGround_RollingTime",
		"2"
	},
	{
		"Interact_Speed",
		"800"
	},
	{
		"Stone_Percent",
		"15"
	},
	{
		"Bubble_Min_Speed",
		"300"
	},
	{
		"Bubble_Max_Speed",
		"500"
	},
	{
		"Bubble_IntervalTime",
		"2"
	},
	{
		"Camera_Time",
		"5"
	},
	{
		"OpenTime",
		"2024-03-15 05:00:00#2024-03-29 05:00:00"
	},
	{
		"Jump_Shop",
		"func#191#228#228004"
	}
}
local t_run_game_common = {
	BackGround_NormalSpeed = dataList[1],
	BackGround_AccelerateSpeed = dataList[2],
	BackGround_RollingTime = dataList[3],
	Interact_Speed = dataList[4],
	Stone_Percent = dataList[5],
	Bubble_Min_Speed = dataList[6],
	Bubble_Max_Speed = dataList[7],
	Bubble_IntervalTime = dataList[8],
	Camera_Time = dataList[9],
	OpenTime = dataList[10],
	Jump_Shop = dataList[11]
}

t_run_game_common.dataList = dataList

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

return t_run_game_common
