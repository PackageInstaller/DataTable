-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_direct_purchase.lua

module("logicconfig.config.t_direct_purchase", package.seeall)

local title = {
	shopItemId = 3,
	jumpShopId = 4,
	id = 2,
	activityId = 1,
	jumpIcon = 5
}
local dataList = {
	{
		75001,
		1,
		12011,
		0,
		""
	},
	{
		75002,
		1,
		12018,
		0,
		""
	},
	{
		75003,
		1,
		12036,
		0,
		""
	},
	{
		86001,
		1,
		12037,
		12039,
		"board_jlzg_longnv"
	},
	{
		75004,
		1,
		12040,
		12044,
		"board_jlzg_yadianna"
	},
	{
		86002,
		1,
		530,
		0,
		""
	}
}
local t_direct_purchase = {
	[75001] = {
		dataList[1]
	},
	[75002] = {
		dataList[2]
	},
	[75003] = {
		dataList[3]
	},
	[86001] = {
		dataList[4]
	},
	[75004] = {
		dataList[5]
	},
	[86002] = {
		dataList[6]
	}
}

t_direct_purchase.dataList = dataList

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

return t_direct_purchase
