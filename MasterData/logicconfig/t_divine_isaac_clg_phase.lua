-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_isaac_clg_phase.lua

module("logicconfig.config.t_divine_isaac_clg_phase", package.seeall)

local title = {
	activityId = 1,
	ruleDesc = 5,
	phaseId = 2,
	puppetNum = 3,
	prize = 4
}
local dataList = {
	{
		491001,
		1,
		1,
		"4:293:20",
		"1、本层包含3个平行关卡，每关<color=#96fa73>通关（破阵且合成合金数量达标）</color>后可获得合金，通关后可重复挑战，每关最多产出6个合成合金。\r\n2、计算合金数量时，若己阵存在多种合成所需的元素，则取最小值进行合成。\r\n3、本层傀儡合成数量达标后视为本层通关，可领取奖励并进入下一层。\r\n4、敌阵首次攻击时，会对目标造成高额的非直接伤害"
	},
	{
		491001,
		2,
		1,
		"4:293:30",
		"1、本层包含5个平行关卡，每关<color=#96fa73>通关（破阵且合成合金数量达标）</color>后可获得合金，通关后可重复挑战，每关最多产出6个合成合金。\r\n2、计算合金数量时，若己阵存在多种合成所需的元素，则取最小值进行合成。\r\n3、本层傀儡合成数量达标后视为本层通关，可领取奖励并进入下一层。\r\n4、敌阵首次攻击时，会对目标造成高额的非直接伤害"
	},
	{
		491001,
		3,
		6,
		"4:293:50",
		"1、本层包含7个平行关卡，每关<color=#96fa73>通关（破阵且合成合金数量达标）</color>后可获得合金，通关后可重复挑战，每关最多产出6个合成合金。\r\n2、计算合金数量时，若己阵存在多种合成所需的元素，则取最小值进行合成。\r\n3、本层傀儡合成数量达标后视为本层通关，可领取奖励并进入下一层。\r\n4、敌阵首次攻击时，会对目标造成高额的非直接伤害"
	}
}
local t_divine_isaac_clg_phase = {
	[491001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_divine_isaac_clg_phase.dataList = dataList

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

return t_divine_isaac_clg_phase
