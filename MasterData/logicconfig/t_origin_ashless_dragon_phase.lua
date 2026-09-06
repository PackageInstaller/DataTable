-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ashless_dragon_phase.lua

module("logicconfig.config.t_origin_ashless_dragon_phase", package.seeall)

local title = {
	activityId = 1,
	constructionCondition = 5,
	phaseId = 2,
	overAddBudget = 6,
	prize = 3,
	budgetPlanId = 4
}
local dataList = {
	{
		564001,
		1,
		"8:1:1000000",
		1,
		400,
		1
	},
	{
		564001,
		2,
		"4:510703:100",
		1,
		400,
		1
	}
}
local t_origin_ashless_dragon_phase = {
	[564001] = {
		dataList[1],
		dataList[2]
	}
}

t_origin_ashless_dragon_phase.dataList = dataList

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

return t_origin_ashless_dragon_phase
