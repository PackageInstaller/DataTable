-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_yu_hui_clg_monster.lua

module("logicconfig.config.t_divine_yu_hui_clg_monster", package.seeall)

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
		"神曜余灰-1",
		"击败敌阵全体精灵即可过关",
		"击败敌阵全体精灵即可过关",
		5,
		0,
		411,
		0,
		"",
		"",
		""
	},
	{
		1002,
		"神曜余灰-2",
		"击败敌阵全体精灵即可过关",
		"击败敌阵全体精灵即可过关",
		5,
		0,
		411,
		0,
		"",
		"5",
		"6"
	},
	{
		1003,
		"神曜余灰-3",
		"击败敌阵全体精灵即可过关",
		"击败敌阵全体精灵即可过关",
		5,
		0,
		0,
		0,
		"414029",
		"5",
		"6"
	},
	{
		1004,
		"神曜余灰-4",
		"击败敌阵全体精灵即可过关",
		"击败敌阵全体精灵即可过关",
		5,
		0,
		0,
		0,
		"",
		"",
		""
	},
	{
		1005,
		"神曜余灰-5",
		"击败敌阵全体精灵即可过关",
		"击败敌阵全体精灵即可过关",
		5,
		0,
		0,
		0,
		"",
		"",
		""
	},
	{
		1006,
		"神曜余灰-6",
		"击败敌阵全体精灵即可过关",
		"击败敌阵全体精灵即可过关",
		5,
		0,
		0,
		0,
		"",
		"",
		""
	},
	{
		1007,
		"神曜余灰-7",
		"击败敌阵全体精灵即可过关",
		"击败敌阵全体精灵即可过关",
		5,
		0,
		0,
		0,
		"",
		"5",
		"6"
	}
}
local t_divine_yu_hui_clg_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7]
}

t_divine_yu_hui_clg_monster.dataList = dataList

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

return t_divine_yu_hui_clg_monster
