-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_awaken_oath_ancestor_master.lua

module("logicconfig.config.t_awaken_oath_ancestor_master", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	heavenAwakenSummonPetId = 12,
	skipTime = 3,
	retreatMsgType = 7,
	heavenAwakenMasterId = 11,
	ruleDesc = 13,
	btlMode = 5,
	btlBg = 4,
	selfBuffProviderId = 8,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 10
}
local dataList = {
	{
		1001,
		"唤醒誓祖-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"每个大回合结束时，敌阵全体精灵获得100点气势"
	},
	{
		1002,
		"唤醒誓祖-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵攻击时，优先攻击与自身相同站位的精灵"
	},
	{
		1003,
		"唤醒誓祖-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"每个大回合结束时，敌阵全体精灵获得100点气势"
	},
	{
		1004,
		"唤醒誓祖-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵攻击时，优先攻击与自身相同站位的精灵"
	},
	{
		1005,
		"唤醒誓祖-5",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"每个大回合结束时，敌阵全体精灵获得100点气势"
	},
	{
		1006,
		"唤醒誓祖-6",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵攻击时，优先攻击与自身相同站位的精灵"
	}
}
local t_awaken_oath_ancestor_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6]
}

t_awaken_oath_ancestor_master.dataList = dataList

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

return t_awaken_oath_ancestor_master
