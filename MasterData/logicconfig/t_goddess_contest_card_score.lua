-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_contest_card_score.lua

module("logicconfig.config.t_goddess_contest_card_score", package.seeall)

local title = {
	rankId = 2,
	cardScorePlanId = 1,
	gainScore = 3
}
local dataList = {
	{
		1,
		1,
		10
	},
	{
		1,
		2,
		8
	},
	{
		1,
		3,
		6
	},
	{
		1,
		4,
		4
	}
}
local t_goddess_contest_card_score = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_goddess_contest_card_score.dataList = dataList

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

return t_goddess_contest_card_score
