-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_domain_adventure_dispatch_progress_plan.lua

module("logicconfig.config.t_domain_adventure_dispatch_progress_plan", package.seeall)

local title = {
	progressId = 2,
	value = 3,
	progress = 4,
	progressPlanId = 1
}
local dataList = {
	{
		1,
		1,
		1,
		1
	},
	{
		1,
		2,
		50,
		2
	},
	{
		1,
		3,
		100,
		3
	},
	{
		2,
		1,
		1,
		1
	},
	{
		2,
		2,
		3,
		2
	},
	{
		2,
		3,
		4,
		3
	},
	{
		3,
		1,
		0,
		1
	},
	{
		3,
		2,
		2,
		2
	},
	{
		3,
		3,
		4,
		3
	},
	{
		3,
		4,
		6,
		4
	}
}
local t_domain_adventure_dispatch_progress_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_domain_adventure_dispatch_progress_plan.dataList = dataList

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

return t_domain_adventure_dispatch_progress_plan
