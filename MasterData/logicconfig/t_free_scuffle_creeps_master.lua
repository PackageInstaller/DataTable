-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_free_scuffle_creeps_master.lua

module("logicconfig.config.t_free_scuffle_creeps_master", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	ruleDesc = 11,
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
		1001,
		"灵能乱斗",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1002,
		"灵能乱斗",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1003,
		"灵能乱斗",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	}
}
local t_free_scuffle_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3]
}

t_free_scuffle_creeps_master.dataList = dataList

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

return t_free_scuffle_creeps_master
