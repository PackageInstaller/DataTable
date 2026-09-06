-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_angel_power_transfer_plan.lua

module("logicconfig.config.t_angel_power_transfer_plan", package.seeall)

local title = {
	counterBuffId = 3,
	transferAttrId = 2,
	transferPlanId = 1
}
local dataList = {
	{
		1,
		1,
		20057719
	},
	{
		1,
		2,
		20057717
	},
	{
		1,
		3,
		20057718
	},
	{
		1,
		4,
		20057720
	},
	{
		1,
		5,
		20057721
	},
	{
		1,
		6,
		20057722
	},
	{
		1,
		7,
		20057723
	}
}
local t_angel_power_transfer_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_angel_power_transfer_plan.dataList = dataList

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

return t_angel_power_transfer_plan
