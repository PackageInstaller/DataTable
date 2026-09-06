-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_strengthen_activity.lua

module("logicconfig.config.t_pay_strengthen_activity", package.seeall)

local title = {
	payGoodsId = 4,
	payType = 3,
	type = 2,
	activityId = 1,
	times = 5
}
local dataList = {
	{
		101001,
		1,
		2,
		"204:110001:128",
		1
	},
	{
		101001,
		2,
		2,
		"204:110002:98",
		1
	},
	{
		101001,
		3,
		2,
		"204:110003:128",
		1
	},
	{
		101001,
		4,
		2,
		"204:110004:368",
		1
	},
	{
		101001,
		5,
		2,
		"204:110005:398",
		1
	},
	{
		101001,
		6,
		2,
		"204:110001:128",
		1
	},
	{
		101001,
		7,
		2,
		"204:110001:128",
		1
	},
	{
		101001,
		8,
		2,
		"204:110001:128",
		1
	},
	{
		101001,
		9,
		2,
		"204:110001:128",
		1
	}
}
local t_pay_strengthen_activity = {
	[101001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_pay_strengthen_activity.dataList = dataList

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

return t_pay_strengthen_activity
