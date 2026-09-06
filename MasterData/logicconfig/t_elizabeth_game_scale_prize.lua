-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_elizabeth_game_scale_prize.lua

module("logicconfig.config.t_elizabeth_game_scale_prize", package.seeall)

local title = {
	planId = 1,
	scale = 2,
	flowerNum = 3
}
local dataList = {
	{
		1,
		15,
		10
	},
	{
		1,
		45,
		10
	},
	{
		1,
		75,
		10
	},
	{
		1,
		90,
		20
	}
}
local t_elizabeth_game_scale_prize = {
	{
		[15] = dataList[1],
		[45] = dataList[2],
		[75] = dataList[3],
		[90] = dataList[4]
	}
}

t_elizabeth_game_scale_prize.dataList = dataList

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

return t_elizabeth_game_scale_prize
