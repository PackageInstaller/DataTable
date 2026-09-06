-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_light_base.lua

module("logicconfig.config.t_holy_light_base", package.seeall)

local title = {
	masterPlanId = 7,
	refreshPlanId = 6,
	petPlanId = 5,
	dicePlanId = 3,
	gridPlanId = 2,
	finishPlanId = 4,
	activityId = 1
}
local dataList = {
	{
		254001,
		1,
		1,
		1,
		1,
		1,
		1
	},
	{
		254002,
		2,
		2,
		2,
		2,
		2,
		2
	},
	{
		254003,
		3,
		3,
		3,
		3,
		3,
		3
	},
	{
		254004,
		4,
		4,
		4,
		4,
		4,
		4
	}
}
local t_holy_light_base = {
	[254001] = dataList[1],
	[254002] = dataList[2],
	[254003] = dataList[3],
	[254004] = dataList[4]
}

t_holy_light_base.dataList = dataList

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

return t_holy_light_base
