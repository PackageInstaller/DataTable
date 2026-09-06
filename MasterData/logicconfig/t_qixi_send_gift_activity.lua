-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_qixi_send_gift_activity.lua

module("logicconfig.config.t_qixi_send_gift_activity", package.seeall)

local title = {
	romancePlanId = 5,
	actId = 1,
	sugarPlanId = 4,
	msgId = 6,
	passPortType = 2,
	itemPlanId = 3
}
local dataList = {
	{
		245001,
		14,
		1,
		1,
		1,
		51
	},
	{
		245002,
		14,
		2,
		2,
		2,
		51
	}
}
local t_qixi_send_gift_activity = {
	[245001] = dataList[1],
	[245002] = dataList[2]
}

t_qixi_send_gift_activity.dataList = dataList

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

return t_qixi_send_gift_activity
