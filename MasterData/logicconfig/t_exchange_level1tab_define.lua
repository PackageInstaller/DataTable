-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_exchange_level1tab_define.lua

module("logicconfig.config.t_exchange_level1tab_define", package.seeall)

local title = {
	redPointIds = 9,
	activityIds = 12,
	type = 1,
	jumpTo = 10,
	rank = 2,
	name = 3,
	jobIds = 17,
	preview = 18,
	endTime = 14,
	viewName = 7,
	reportBehavior = 15,
	param = 8,
	jumpInTag = 4,
	activityType = 11,
	tabBelongTo = 5,
	funcId = 6,
	costMats = 16,
	startTime = 13
}
local dataList = {
	{
		3,
		1,
		"兑换",
		"",
		0,
		470,
		"",
		"",
		nil,
		"",
		0,
		nil,
		"",
		"",
		200252,
		"204:2#104:2#8:1",
		nil,
		false
	}
}
local t_exchange_level1tab_define = {
	[3] = dataList[1]
}

t_exchange_level1tab_define.dataList = dataList

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

return t_exchange_level1tab_define
