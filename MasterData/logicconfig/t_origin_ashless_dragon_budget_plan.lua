-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ashless_dragon_budget_plan.lua

module("logicconfig.config.t_origin_ashless_dragon_budget_plan", package.seeall)

local title = {
	riskUnit = 3,
	constructionUnit = 2,
	budgetPlanId = 1
}
local dataList = {
	{
		1,
		1,
		1
	}
}
local t_origin_ashless_dragon_budget_plan = {
	dataList[1]
}

t_origin_ashless_dragon_budget_plan.dataList = dataList

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

return t_origin_ashless_dragon_budget_plan
