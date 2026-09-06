-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ci_yuan_holy_dragon_clg_monster.lua

module("logicconfig.config.t_ci_yuan_holy_dragon_clg_monster", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	skipTime = 3,
	retreatMsgType = 7,
	btlMode = 5,
	btlBg = 4,
	selfBuffProviderId = 8,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 10
}
local dataList = {
	{
		999001,
		"水火草试炼",
		5,
		"",
		"",
		117,
		0,
		0,
		167,
		""
	},
	{
		999002,
		"光暗试炼",
		5,
		"",
		"",
		117,
		0,
		0,
		169,
		""
	},
	{
		999003,
		"空创试炼",
		5,
		"",
		"",
		117,
		0,
		0,
		168,
		""
	}
}
local t_ci_yuan_holy_dragon_clg_monster = {
	[999001] = dataList[1],
	[999002] = dataList[2],
	[999003] = dataList[3]
}

t_ci_yuan_holy_dragon_clg_monster.dataList = dataList

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

return t_ci_yuan_holy_dragon_clg_monster
