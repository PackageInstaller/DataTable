-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_run2023_game_common.lua

module("logicconfig.config.t_run2023_game_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"BackGround_NormalSpeed",
		"1"
	},
	{
		"BackGround_AccelerateSpeed",
		"2"
	},
	{
		"BackGround_DecelerateSpeed",
		"0.5"
	},
	{
		"Interact_Speed",
		"500"
	},
	{
		"Stone_Percent",
		"20"
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
		"Bubble_Max_Num",
		"3"
	}
}
local t_run2023_game_common = {
	BackGround_NormalSpeed = dataList[1],
	BackGround_AccelerateSpeed = dataList[2],
	BackGround_DecelerateSpeed = dataList[3],
	Interact_Speed = dataList[4],
	Stone_Percent = dataList[5],
	Bubble_Min_Speed = dataList[6],
	Bubble_Max_Speed = dataList[7],
	Bubble_Max_Num = dataList[8]
}

t_run2023_game_common.dataList = dataList

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

return t_run2023_game_common
