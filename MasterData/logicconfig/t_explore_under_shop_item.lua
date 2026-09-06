-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_explore_under_shop_item.lua

module("logicconfig.config.t_explore_under_shop_item", package.seeall)

local title = {
	itemId = 2,
	discount = 5,
	price = 4,
	iconId = 6,
	content = 3,
	itemPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"4:34:1",
		"105:6014:50",
		1.7,
		4
	},
	{
		1,
		2,
		"4:33:1",
		"105:6022:30",
		2,
		4
	},
	{
		1,
		3,
		"4:32:1",
		"105:6023:15",
		2,
		4
	},
	{
		2,
		1,
		"4:36:1",
		"105:6016:135",
		9,
		4
	},
	{
		2,
		2,
		"4:31:1",
		"105:6017:135",
		9,
		4
	},
	{
		2,
		3,
		"4:112:1",
		"105:6018:108",
		7.2,
		4
	},
	{
		3,
		1,
		"4:111:1",
		"105:6019:108",
		7.2,
		4
	},
	{
		3,
		2,
		"4:31:1",
		"105:6017:135",
		9,
		4
	},
	{
		3,
		3,
		"4:112:1",
		"105:6018:108",
		7.2,
		4
	},
	{
		4,
		1,
		"4:71003:1",
		"204:201:15",
		3.9,
		4
	},
	{
		4,
		2,
		"4:90215:1",
		"204:202:20",
		6.3,
		4
	},
	{
		4,
		3,
		"4:90137:1",
		"204:203:5",
		5.6,
		4
	},
	{
		5,
		1,
		"8:1:1000000",
		"105:6025:180",
		6,
		4
	},
	{
		5,
		2,
		"8:1:500000",
		"105:6026:90",
		6,
		4
	},
	{
		5,
		3,
		"8:1:250000",
		"105:6027:45",
		6,
		4
	}
}
local t_explore_under_shop_item = {
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
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_explore_under_shop_item.dataList = dataList

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

return t_explore_under_shop_item
