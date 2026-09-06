-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ji_normal_clg_buff.lua

module("logicconfig.config.t_divine_ji_normal_clg_buff", package.seeall)

local title = {
	activityId = 1,
	buffId = 2,
	desc = 3
}
local dataList = {
	{
		421001,
		1,
		"水buff-己方精灵反弹10%的伤害给攻击者"
	},
	{
		421001,
		2,
		"火buff-己方精灵魔伤减免+10%"
	},
	{
		421001,
		3,
		"草buff-己方精灵格挡率+10%"
	},
	{
		421001,
		4,
		"光buff-己方精灵闪避率+15%"
	},
	{
		421001,
		5,
		"暗buff-己方精灵攻击吸血+10%"
	},
	{
		421001,
		6,
		"空buff-己方精灵防御加成+12%"
	},
	{
		421002,
		1,
		"水buff-己方精灵反弹10%的伤害给攻击者"
	},
	{
		421002,
		2,
		"火buff-己方精灵魔伤减免+10%"
	},
	{
		421002,
		3,
		"草buff-己方精灵格挡率+10%"
	},
	{
		421002,
		4,
		"光buff-己方精灵闪避率+15%"
	},
	{
		421002,
		5,
		"暗buff-己方精灵攻击吸血+10%"
	},
	{
		421002,
		6,
		"空buff-己方精灵防御加成+12%"
	}
}
local t_divine_ji_normal_clg_buff = {
	[421001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[421002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_divine_ji_normal_clg_buff.dataList = dataList

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

return t_divine_ji_normal_clg_buff
