-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fame_hall_vote_fame_desc.lua

module("logicconfig.config.t_fame_hall_vote_fame_desc", package.seeall)

local title = {
	fameHallDesc = 2,
	hasParam = 3,
	fameHallType = 1
}
local dataList = {
	{
		1,
		"少年竞技王全服总冠军",
		false
	},
	{
		2,
		"王者竞技场战皇次数榜第一",
		false
	},
	{
		3,
		"2025年获得巅峰赛全服总冠军%d次",
		true
	},
	{
		4,
		"2025年获得经典排位赛冠军%d次",
		true
	},
	{
		5,
		"2025年获得极限排位赛冠军%d次",
		true
	},
	{
		6,
		"2025年获得出师榜第一名%d次",
		true
	}
}
local t_fame_hall_vote_fame_desc = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_fame_hall_vote_fame_desc.dataList = dataList

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

return t_fame_hall_vote_fame_desc
