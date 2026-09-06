-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_magic_school_pvp_boss.lua

module("logicconfig.config.t_magic_school_pvp_boss", package.seeall)

local title = {
	bossId = 2,
	param = 5,
	targetDesc = 6,
	type = 4,
	creepsMasterId = 3,
	resultTargetDesc = 7,
	activityId = 1,
	bossDesc = 8
}
local dataList = {
	{
		514001,
		1,
		1001,
		"MORE_DAMAGE",
		"",
		"对BOSS造成伤害大于敌队阵营",
		"伤害超过敌营",
		"无效果，10回合结束战斗"
	},
	{
		514001,
		2,
		1002,
		"MEET_RANDOM_ATTRIBUTE_RATE",
		"0.25_光,暗,空,创",
		"对BOSS%s属性伤害>=25%%",
		"属性伤害>=25%",
		"伤害+50%，10回合结束战斗"
	},
	{
		514001,
		3,
		1003,
		"NOTHING",
		"",
		"对BOSS造成伤害更多的伤害",
		"造成伤害",
		"拥有40%免伤，10回合结束战斗"
	}
}
local t_magic_school_pvp_boss = {
	[514001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_magic_school_pvp_boss.dataList = dataList

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

return t_magic_school_pvp_boss
