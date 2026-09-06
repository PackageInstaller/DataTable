-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_newyear_goods_shop.lua

module("logicconfig.config.t_newyear_goods_shop", package.seeall)

local title = {
	raceId = 3,
	trans = 4,
	activityId = 1,
	ruleKey = 2
}
local dataList = {
	{
		219007,
		"nianhuoshop_tips",
		1202801,
		{
			401.9,
			-718.3,
			1
		}
	},
	{
		219009,
		"nianhuoshop_tips",
		12030,
		{
			449,
			-597,
			1.2
		}
	},
	{
		219010,
		"nianhuoshop_tips",
		12042,
		{
			492,
			-631,
			1
		}
	},
	{
		219011,
		"nianhuoshop_tips",
		13030,
		{
			464,
			-498
		}
	}
}
local t_newyear_goods_shop = {
	[219007] = dataList[1],
	[219009] = dataList[2],
	[219010] = dataList[3],
	[219011] = dataList[4]
}

t_newyear_goods_shop.dataList = dataList

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

return t_newyear_goods_shop
