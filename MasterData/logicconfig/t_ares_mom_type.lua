-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ares_mom_type.lua

module("logicconfig.config.t_ares_mom_type", package.seeall)

local title = {
	challengeId = 1,
	prizePlanId = 6,
	type = 2,
	specialRuleDesc = 8,
	gridPlanId = 4,
	num = 11,
	cost = 10,
	rewardRuleDesc = 7,
	stagePlanId = 3,
	formRuleDesc = 9,
	useSystemPet = 5
}
local dataList = {
	{
		51,
		1,
		1,
		1,
		false,
		1,
		"奖励说明：\n根据所有关卡的累计伤害领取奖励",
		"特殊说明：\n本关无特殊说明规则",
		"上阵说明：\n使用玩家自身养成精灵战斗",
		"204:1990014:1",
		1
	},
	{
		51,
		2,
		2,
		2,
		true,
		2,
		"奖励说明：\n所有关卡水、火、草任意属性存活总数量",
		"特殊说明：\n本关无特殊说明规则",
		"上阵说明：\n使用系统精灵战斗",
		"204:1990014:1",
		1
	},
	{
		51,
		3,
		3,
		3,
		false,
		3,
		"奖励说明：\n所有关卡水、火、草中一种属性存活总数量",
		"特殊说明：\n五只上同种属性精灵 敌阵防御能力降低20%",
		"上阵说明：\n使用玩家自身养成精灵战斗",
		"204:1990014:5",
		1
	},
	{
		127,
		1,
		4,
		4,
		false,
		4,
		"奖励说明：\n根据所有关卡的累计伤害领取奖励",
		"特殊说明：\n本关无特殊说明规则",
		"上阵说明：\n使用玩家自身养成精灵战斗",
		"204:1990014:1",
		1
	},
	{
		127,
		2,
		5,
		5,
		true,
		5,
		"奖励说明：\n所有关卡水、火、草任意属性存活总数量",
		"特殊说明：\n本关无特殊说明规则",
		"上阵说明：\n使用系统精灵战斗",
		"204:1990014:1",
		1
	},
	{
		127,
		3,
		6,
		6,
		false,
		6,
		"奖励说明：\n所有关卡水、火、草中一种属性存活总数量",
		"特殊说明：\n五只上同种属性精灵 敌阵防御能力降低20%",
		"上阵说明：\n使用玩家自身养成精灵战斗",
		"204:1990014:5",
		1
	}
}
local t_ares_mom_type = {
	[51] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[127] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_ares_mom_type.dataList = dataList

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

return t_ares_mom_type
