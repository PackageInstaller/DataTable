-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_fee_preheat_information.lua

module("logicconfig.config.t_annual_fee_preheat_information", package.seeall)

local title = {
	id = 2,
	informationPlanId = 1,
	eventParams = 6,
	progress = 3,
	showTip = 4,
	unlockTip = 7,
	btnEvent = 5
}
local dataList = {
	{
		1,
		1,
		150000,
		"赤的职业：魔法",
		"",
		"",
		"全服累计揭秘15万可以解锁"
	},
	{
		1,
		2,
		300000,
		"赤是解神一族的后裔",
		"rule",
		"annual_fee_story",
		"全服累计揭秘30万可以解锁"
	},
	{
		1,
		3,
		450000,
		"关系：赤、亦、西芙",
		"rule",
		"annual_fee_relationship",
		"全服累计揭秘45万可以解锁"
	},
	{
		1,
		4,
		600000,
		"新属性：空、创",
		"rule",
		"annual_fee_new_attribute",
		"全服累计揭秘60万可以解锁"
	},
	{
		1,
		5,
		750000,
		"赤的技能可以将精灵锁在“域”中",
		"",
		"",
		"全服累计揭秘75万可以解锁"
	},
	{
		1,
		6,
		1000000,
		"双生形态，属性切换",
		"skin",
		"17000#1",
		"全服累计揭秘100万可以解锁"
	}
}
local t_annual_fee_preheat_information = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_annual_fee_preheat_information.dataList = dataList

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

return t_annual_fee_preheat_information
