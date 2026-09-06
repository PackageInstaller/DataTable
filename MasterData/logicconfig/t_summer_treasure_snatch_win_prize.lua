-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summer_treasure_snatch_win_prize.lua

module("logicconfig.config.t_summer_treasure_snatch_win_prize", package.seeall)

local title = {
	winNum = 2,
	score = 3,
	activityId = 1
}
local dataList = {
	{
		623001,
		0,
		10
	},
	{
		623001,
		1,
		20
	},
	{
		623001,
		2,
		30
	},
	{
		623001,
		3,
		40
	}
}
local t_summer_treasure_snatch_win_prize = {
	[623001] = {
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_summer_treasure_snatch_win_prize.dataList = dataList

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

return t_summer_treasure_snatch_win_prize
