-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_stripe_basic_property.lua

module("logicconfig.config.t_holy_stripe_basic_property", package.seeall)

local title = {
	doc = 4,
	propertyId = 2,
	propertyType = 3,
	positionType = 1
}
local dataList = {
	{
		1,
		1,
		1,
		"攻击"
	},
	{
		2,
		1,
		2,
		"速度"
	},
	{
		2,
		2,
		10,
		"生命"
	},
	{
		2,
		3,
		1,
		"攻击"
	},
	{
		2,
		4,
		5,
		"双防"
	},
	{
		3,
		1,
		5,
		"双防"
	},
	{
		4,
		1,
		2,
		"速度"
	},
	{
		4,
		2,
		1,
		"攻击"
	},
	{
		4,
		3,
		10,
		"生命"
	},
	{
		4,
		4,
		5,
		"双防"
	},
	{
		5,
		1,
		10,
		"生命"
	}
}
local t_holy_stripe_basic_property = {
	{
		dataList[1]
	},
	{
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11]
	}
}

t_holy_stripe_basic_property.dataList = dataList

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

return t_holy_stripe_basic_property
