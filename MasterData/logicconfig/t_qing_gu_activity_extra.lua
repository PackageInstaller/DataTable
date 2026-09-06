-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_qing_gu_activity_extra.lua

module("logicconfig.config.t_qing_gu_activity_extra", package.seeall)

local title = {
	extraPrize = 3,
	maskSelection = 4,
	posId = 2,
	activityId = 1
}
local dataList = {
	{
		202001,
		1,
		"4:91016:2",
		false
	},
	{
		202001,
		2,
		"4:149:10",
		false
	},
	{
		202001,
		3,
		"4:510095:1",
		true
	},
	{
		202001,
		4,
		"4:90316:1",
		true
	}
}
local t_qing_gu_activity_extra = {
	[202001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_qing_gu_activity_extra.dataList = dataList

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

return t_qing_gu_activity_extra
