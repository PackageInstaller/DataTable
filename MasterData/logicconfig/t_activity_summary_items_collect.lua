-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activity_summary_items_collect.lua

module("logicconfig.config.t_activity_summary_items_collect", package.seeall)

local title = {
	actItemEntry = 4,
	summaryId = 1,
	id = 2,
	sudId = 3,
	maxNum = 5
}
local dataList = {
	{
		17043,
		226,
		1,
		"10:17013",
		5460
	},
	{
		17043,
		226,
		2,
		"10:17012",
		9650
	},
	{
		17043,
		227,
		1,
		"10:17013",
		900
	},
	{
		17043,
		228,
		1,
		"10:17013",
		6000
	},
	{
		17043,
		228,
		2,
		"10:17012",
		3000
	}
}
local t_activity_summary_items_collect = {
	[17043] = {
		[226] = {
			dataList[1],
			dataList[2]
		},
		[227] = {
			dataList[3]
		},
		[228] = {
			dataList[4],
			dataList[5]
		}
	}
}

t_activity_summary_items_collect.dataList = dataList

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

return t_activity_summary_items_collect
