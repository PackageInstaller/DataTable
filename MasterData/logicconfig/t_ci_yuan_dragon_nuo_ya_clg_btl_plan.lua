-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ci_yuan_dragon_nuo_ya_clg_btl_plan.lua

module("logicconfig.config.t_ci_yuan_dragon_nuo_ya_clg_btl_plan", package.seeall)

local title = {
	balanceType = 2,
	planId = 1,
	desc = 3
}
local dataList = {
	{
		1,
		1,
		"光系+%s点"
	},
	{
		2,
		1,
		"暗系+%s点"
	},
	{
		3,
		1,
		"空系+%s点"
	},
	{
		4,
		2,
		"常规回合结算：破阵成功+%s点"
	},
	{
		5,
		2,
		"极限回合结算"
	}
}
local t_ci_yuan_dragon_nuo_ya_clg_btl_plan = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_ci_yuan_dragon_nuo_ya_clg_btl_plan.dataList = dataList

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

return t_ci_yuan_dragon_nuo_ya_clg_btl_plan
