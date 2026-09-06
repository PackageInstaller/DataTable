-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fengbaobao_challenge_monster.lua

module("logicconfig.config.t_fengbaobao_challenge_monster", package.seeall)

local title = {
	creepMasterHeadIcon = 4,
	name = 2,
	skipTime = 3,
	formCondition = 8,
	retreatMsgType = 10,
	supportPlanId = 11,
	btlMode = 9,
	btlBg = 5,
	enableGainExp = 7,
	creepsMasterId = 1,
	heroSkillId = 6
}
local dataList = {
	{
		1,
		"王也",
		15,
		10381,
		"",
		"",
		false,
		0,
		"",
		0,
		1001
	}
}
local t_fengbaobao_challenge_monster = {
	dataList[1]
}

t_fengbaobao_challenge_monster.dataList = dataList

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

return t_fengbaobao_challenge_monster
