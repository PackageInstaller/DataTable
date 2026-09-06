-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_teen_champion_king_qualifier_match.lua

module("logicconfig.config.t_teen_champion_king_qualifier_match", package.seeall)

local title = {
	matchId = 2,
	matchPlanId = 1
}
local dataList = {
	{
		1,
		1
	},
	{
		1,
		2
	},
	{
		1,
		3
	},
	{
		1,
		4
	},
	{
		1,
		5
	}
}
local t_teen_champion_king_qualifier_match = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_teen_champion_king_qualifier_match.dataList = dataList

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

return t_teen_champion_king_qualifier_match
