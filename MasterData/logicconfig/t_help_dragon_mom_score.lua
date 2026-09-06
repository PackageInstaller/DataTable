-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_help_dragon_mom_score.lua

module("logicconfig.config.t_help_dragon_mom_score", package.seeall)

local title = {
	score = 3,
	scoreAddPlanId = 1,
	id = 2,
	weight = 4,
	desc = 5
}
local dataList = {
	{
		1,
		1,
		1,
		10,
		"能量+1"
	},
	{
		1,
		2,
		5,
		20,
		"暴击+5"
	},
	{
		1,
		3,
		10,
		70,
		"超暴击+10"
	}
}
local t_help_dragon_mom_score = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_help_dragon_mom_score.dataList = dataList

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

return t_help_dragon_mom_score
