-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_legend_challenge_map_list.lua

module("logicconfig.config.t_legend_challenge_map_list", package.seeall)

local title = {
	mapId = 1,
	mapName = 4,
	petPlan = 3,
	zdlRecommend = 5,
	dealType = 2
}
local dataList = {
	{
		1,
		1,
		0,
		"开端情怀宠",
		1
	},
	{
		2,
		2,
		1,
		"新手梦之队",
		200000
	},
	{
		3,
		3,
		2,
		"进阶强力宠",
		300000
	}
}
local t_legend_challenge_map_list = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_legend_challenge_map_list.dataList = dataList

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

return t_legend_challenge_map_list
