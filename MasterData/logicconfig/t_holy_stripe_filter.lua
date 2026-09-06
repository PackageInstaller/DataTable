-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_stripe_filter.lua

module("logicconfig.config.t_holy_stripe_filter", package.seeall)

local title = {
	id = 1,
	filterPropertyType = 2
}
local dataList = {
	{
		1,
		"生命"
	},
	{
		2,
		"攻击"
	},
	{
		3,
		"物防"
	},
	{
		4,
		"魔防"
	},
	{
		5,
		"速度"
	},
	{
		6,
		"暴击率"
	},
	{
		7,
		"防暴率"
	},
	{
		8,
		"命中率"
	},
	{
		9,
		"闪避率"
	},
	{
		10,
		"破击率"
	},
	{
		11,
		"格挡率"
	},
	{
		12,
		"暴击伤害"
	},
	{
		13,
		"克制增伤"
	},
	{
		14,
		"普攻增伤"
	},
	{
		15,
		"超杀增伤"
	},
	{
		16,
		"普攻减伤"
	},
	{
		17,
		"超杀减伤"
	}
}
local t_holy_stripe_filter = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17]
}

t_holy_stripe_filter.dataList = dataList

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

return t_holy_stripe_filter
