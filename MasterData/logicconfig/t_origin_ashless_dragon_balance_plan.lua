-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ashless_dragon_balance_plan.lua

module("logicconfig.config.t_origin_ashless_dragon_balance_plan", package.seeall)

local title = {
	constructionAddUnit = 3,
	balanceType = 2,
	balancePlanId = 1,
	formatDesc = 4
}
local dataList = {
	{
		1,
		"aliveNum",
		10,
		"精灵存活<color=#eb4624>%s</color>只"
	},
	{
		2,
		"ultimateNum",
		5,
		"超杀数<color=#eb4624>%s</color>次"
	}
}
local t_origin_ashless_dragon_balance_plan = {
	dataList[1],
	dataList[2]
}

t_origin_ashless_dragon_balance_plan.dataList = dataList

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

return t_origin_ashless_dragon_balance_plan
