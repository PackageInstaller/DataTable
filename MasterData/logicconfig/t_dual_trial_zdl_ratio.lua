-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dual_trial_zdl_ratio.lua

module("logicconfig.config.t_dual_trial_zdl_ratio", package.seeall)

local title = {
	playerZdl = 3,
	ratioId = 2,
	activityId = 1,
	ratio = 4
}
local dataList = {
	{
		468001,
		1,
		0,
		9000
	},
	{
		468001,
		2,
		10000,
		9000
	},
	{
		468001,
		3,
		20000,
		9000
	},
	{
		468001,
		4,
		30000,
		9000
	},
	{
		468001,
		5,
		40000,
		9000
	},
	{
		468001,
		6,
		50000,
		9000
	},
	{
		468001,
		7,
		60000,
		9000
	},
	{
		468001,
		8,
		70000,
		9000
	},
	{
		468001,
		9,
		80000,
		9000
	},
	{
		468001,
		10,
		90000,
		9000
	}
}
local t_dual_trial_zdl_ratio = {
	[468001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_dual_trial_zdl_ratio.dataList = dataList

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

return t_dual_trial_zdl_ratio
