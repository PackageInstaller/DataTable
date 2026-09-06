-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_hyur_challenge_buff.lua

module("logicconfig.config.t_god_hyur_challenge_buff", package.seeall)

local title = {
	name = 2,
	buffPlanId = 1,
	des = 3
}
local dataList = {
	{
		1,
		"重生Ⅰ",
		"敌阵精灵可重生并恢复<color=#c54949>30%</color>生命值1次"
	},
	{
		2,
		"重生Ⅱ",
		"敌阵精灵可重生并恢复<color=#c54949>50%</color>生命值1次"
	},
	{
		3,
		"重生Ⅲ",
		"敌阵精灵可重生并恢复<color=#c54949>100%</color>生命值1次"
	},
	{
		4,
		"增强Ⅰ",
		"敌阵精灵每回合结束时永久提高自身全属性<color=#c54949>5%</color>"
	},
	{
		5,
		"增强Ⅱ",
		"敌阵精灵每回合结束时永久提高自身全属性<color=#c54949>10%</color>"
	},
	{
		6,
		"增强Ⅲ",
		"敌阵精灵每回合结束时永久提高自身全属性<color=#c54949>20%</color>"
	}
}
local t_god_hyur_challenge_buff = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_god_hyur_challenge_buff.dataList = dataList

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

return t_god_hyur_challenge_buff
