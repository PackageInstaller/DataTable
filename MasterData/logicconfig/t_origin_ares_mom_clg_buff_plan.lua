-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ares_mom_clg_buff_plan.lua

module("logicconfig.config.t_origin_ares_mom_clg_buff_plan", package.seeall)

local title = {
	startEnergy = 2,
	buffPlanId = 1,
	desc = 3
}
local dataList = {
	{
		1,
		5,
		"敌阵+20%最大生命值及生命上限"
	},
	{
		1,
		10,
		"敌阵+40%最大生命值及生命上限"
	},
	{
		1,
		15,
		"敌阵+60%最大生命值及生命上限"
	},
	{
		1,
		20,
		"敌阵+80%最大生命值及生命上限"
	},
	{
		1,
		25,
		"敌阵+100%最大生命值及生命上限"
	},
	{
		1,
		30,
		"敌阵+120%最大生命值及生命上限"
	},
	{
		1,
		35,
		"敌阵+150%最大生命值及生命上限"
	}
}
local t_origin_ares_mom_clg_buff_plan = {
	{
		[5] = dataList[1],
		[10] = dataList[2],
		[15] = dataList[3],
		[20] = dataList[4],
		[25] = dataList[5],
		[30] = dataList[6],
		[35] = dataList[7]
	}
}

t_origin_ares_mom_clg_buff_plan.dataList = dataList

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

return t_origin_ares_mom_clg_buff_plan
