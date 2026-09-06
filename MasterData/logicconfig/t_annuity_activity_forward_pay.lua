-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annuity_activity_forward_pay.lua

module("logicconfig.config.t_annuity_activity_forward_pay", package.seeall)

local title = {
	extraPrize = 4,
	openTime = 2,
	activityId = 1,
	endTime = 3
}
local dataList = {
	{
		8001,
		nil,
		nil,
		""
	},
	{
		8002,
		nil,
		nil,
		""
	},
	{
		8003,
		"2022-12-23T05:00:00",
		"2022-12-30T05:00:00",
		"104:2:888#8:1:1000"
	}
}
local t_annuity_activity_forward_pay = {
	[8001] = dataList[1],
	[8002] = dataList[2],
	[8003] = dataList[3]
}

t_annuity_activity_forward_pay.dataList = dataList

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

return t_annuity_activity_forward_pay
