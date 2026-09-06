-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_music_game_plan.lua

module("logicconfig.config.t_music_game_plan", package.seeall)

local title = {
	randomStageIdList = 4,
	name = 3,
	gamePlanId = 1,
	gameTypeId = 2
}
local dataList = {
	{
		1,
		1,
		"普通模式",
		{
			1,
			2,
			3
		}
	},
	{
		1,
		2,
		"困难模式",
		{
			4,
			5,
			6
		}
	}
}
local t_music_game_plan = {
	{
		dataList[1],
		dataList[2]
	}
}

t_music_game_plan.dataList = dataList

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

return t_music_game_plan
