-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_never_land_master.lua

module("logicconfig.config.t_never_land_master", package.seeall)

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
		101,
		"攻击试炼",
		"在限定回合内尽可能对敌阵造成更多的伤害",
		"在限定回合内尽可能对敌阵造成更多的伤害",
		3,
		"",
		"",
		117,
		0,
		0,
		0,
		"",
		"在限定回合内尽可能对敌阵造成更多的伤害"
	},
	{
		102,
		"防御试炼",
		"尽可能坚持更多的回合",
		"尽可能坚持更多的回合",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"尽可能坚持更多的回合"
	}
}
local t_never_land_master = {
	[101] = dataList[1],
	[102] = dataList[2]
}

t_never_land_master.dataList = dataList

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

return t_never_land_master
