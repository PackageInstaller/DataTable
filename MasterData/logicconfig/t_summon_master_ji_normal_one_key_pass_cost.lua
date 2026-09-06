-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_ji_normal_one_key_pass_cost.lua

module("logicconfig.config.t_summon_master_ji_normal_one_key_pass_cost", package.seeall)

local title = {
	cost = 3,
	leftProgress = 2,
	activityId = 1
}
local dataList = {
	{
		348001,
		10,
		"204:348001:200"
	},
	{
		348001,
		20,
		"204:348001:400"
	},
	{
		348001,
		30,
		"204:348001:600"
	},
	{
		348001,
		40,
		"204:348001:800"
	},
	{
		348001,
		50,
		"204:348001:1000"
	},
	{
		348001,
		60,
		"204:348001:1200"
	},
	{
		348001,
		70,
		"204:348001:1400"
	},
	{
		348001,
		80,
		"204:348001:1600"
	},
	{
		348001,
		90,
		"204:348001:1800"
	}
}
local t_summon_master_ji_normal_one_key_pass_cost = {
	[348001] = {
		[10] = dataList[1],
		[20] = dataList[2],
		[30] = dataList[3],
		[40] = dataList[4],
		[50] = dataList[5],
		[60] = dataList[6],
		[70] = dataList[7],
		[80] = dataList[8],
		[90] = dataList[9]
	}
}

t_summon_master_ji_normal_one_key_pass_cost.dataList = dataList

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

return t_summon_master_ji_normal_one_key_pass_cost
