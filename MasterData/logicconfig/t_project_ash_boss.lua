-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_project_ash_boss.lua

module("logicconfig.config.t_project_ash_boss", package.seeall)

local title = {
	selfBuffProviderId = 10,
	name = 2,
	WinDesc = 4,
	skipTime = 5,
	retreatMsgType = 9,
	formCondition = 11,
	stageDesc = 13,
	btlMode = 7,
	btlBg = 6,
	missionDesc = 3,
	winId = 8,
	creepsMasterId = 1,
	heroSkillId = 12
}
local dataList = {
	{
		1001,
		"boss",
		"",
		"尽可能的多伤害BOSS吧",
		3,
		"",
		"",
		117,
		0,
		0,
		162,
		"",
		"五回合内尽力对BOSS造成更多的伤害"
	}
}
local t_project_ash_boss = {
	[1001] = dataList[1]
}

t_project_ash_boss.dataList = dataList

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

return t_project_ash_boss
