-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_magic_school_pvp_monster.lua

module("logicconfig.config.t_magic_school_pvp_monster", package.seeall)

local title = {
	skipTime = 5,
	name = 2,
	WinDesc = 4,
	formCondition = 8,
	missionDesc = 3,
	heavenAwakenMasterId = 10,
	heavenAwakenSummonPetId = 11,
	selfBuffProviderId = 7,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 9
}
local dataList = {
	{
		1001,
		"boss1",
		"10回合结束战斗",
		"10回合结束战斗",
		5,
		0,
		506,
		0,
		"",
		"",
		""
	},
	{
		1002,
		"boss2",
		"10回合结束战斗",
		"10回合结束战斗",
		5,
		0,
		506,
		0,
		"",
		"",
		""
	},
	{
		1003,
		"boss3",
		"10回合结束战斗",
		"10回合结束战斗",
		5,
		0,
		506,
		0,
		"",
		"",
		""
	}
}
local t_magic_school_pvp_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3]
}

t_magic_school_pvp_monster.dataList = dataList

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

return t_magic_school_pvp_monster
