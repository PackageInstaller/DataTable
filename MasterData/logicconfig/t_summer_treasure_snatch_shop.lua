-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summer_treasure_snatch_shop.lua

module("logicconfig.config.t_summer_treasure_snatch_shop", package.seeall)

local title = {
	matStr = 5,
	type = 3,
	id = 2,
	itemParam = 4,
	activityId = 1
}
local dataList = {
	{
		623001,
		1,
		1,
		1,
		"1004:1745"
	},
	{
		623001,
		2,
		1,
		2,
		"1004:1746"
	},
	{
		623001,
		3,
		2,
		1,
		"1004:1746"
	},
	{
		623001,
		4,
		2,
		2,
		"1004:1746"
	},
	{
		623001,
		5,
		2,
		3,
		"1004:1746"
	},
	{
		623001,
		6,
		2,
		4,
		"1004:1746"
	},
	{
		623001,
		7,
		2,
		5,
		"1004:1746"
	},
	{
		623001,
		8,
		2,
		6,
		"1004:1746"
	},
	{
		623001,
		9,
		2,
		7,
		"1004:1746"
	}
}
local t_summer_treasure_snatch_shop = {
	[623001] = {
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

t_summer_treasure_snatch_shop.dataList = dataList

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

return t_summer_treasure_snatch_shop
