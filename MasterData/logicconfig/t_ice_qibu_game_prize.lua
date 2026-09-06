-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ice_qibu_game_prize.lua

module("logicconfig.config.t_ice_qibu_game_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	timeRange = 3
}
local dataList = {
	{
		507001,
		1,
		{
			1,
			30
		},
		"4:389:500"
	},
	{
		507001,
		2,
		{
			31,
			45
		},
		"4:389:400"
	},
	{
		507001,
		3,
		{
			46,
			60
		},
		"4:389:300"
	}
}
local t_ice_qibu_game_prize = {
	[507001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_ice_qibu_game_prize.dataList = dataList

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

return t_ice_qibu_game_prize
