-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_send_goddess_flower_plan.lua

module("logicconfig.config.t_send_goddess_flower_plan", package.seeall)

local title = {
	flowerItem = 3,
	refundItem = 5,
	flowerPlanId = 1,
	intimacy = 4,
	flowerId = 2
}
local dataList = {
	{
		1,
		1,
		"10:137001:1",
		5,
		"8:1:10000"
	},
	{
		1,
		2,
		"10:137101:1",
		15,
		"8:1:10000"
	}
}
local t_send_goddess_flower_plan = {
	{
		dataList[1],
		dataList[2]
	}
}

t_send_goddess_flower_plan.dataList = dataList

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

return t_send_goddess_flower_plan
