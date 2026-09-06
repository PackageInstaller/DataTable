-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ai_xin_mm_monster.lua

module("logicconfig.config.t_ai_xin_mm_monster", package.seeall)

local title = {
	description = 11,
	name = 2,
	heroSkillId = 6,
	modelSize = 10,
	showRaceId = 7,
	btlMode = 9,
	btlBg = 5,
	selfBuffProviderId = 8,
	enableGainExp = 4,
	creepsMasterId = 1,
	creepMasterHeadIcon = 3
}
local dataList = {
	{
		1,
		"哆啦梦梦",
		10338,
		false,
		"",
		"",
		10338,
		0,
		"",
		{
			-22,
			-53,
			1.1
		},
		"挑战以<color=#09FFF5FF>【哆啦梦梦】</color>为核心的敌阵，战斗中敌阵会合体成强大的<color=#09FFF5FF>【超维梦梦·哆啦】</color>，完成全部合体梦梦挑战，即可获得爱心梦梦进化石！"
	},
	{
		2,
		"暗黑梦梦",
		10339,
		false,
		"",
		"",
		10339,
		0,
		"",
		{
			-164,
			-242,
			1.3
		},
		"挑战以<color=#FF98F4FF>【暗黑梦梦】</color>为核心的敌阵，战斗中敌阵会合体成强大的<color=#FF98F4FF>【超维梦梦·暗黑】</color>，完成全部合体梦梦挑战，即可获得爱心梦梦进化石！"
	},
	{
		3,
		"爱心梦梦",
		10343,
		false,
		"",
		"",
		10343,
		0,
		"",
		{
			-51,
			77,
			1
		},
		"挑战以<color=#F1FF00FF>【爱心梦梦】</color>为核心的敌阵，战斗中敌阵会合体成强大的<color=#F1FF00FF>【超维梦梦·爱心】</color>，完成全部合体梦梦挑战，即可获得爱心梦梦进化石！"
	},
	{
		4,
		"炼金梦梦",
		10341,
		false,
		"",
		"",
		10341,
		0,
		"",
		{
			-131,
			-25,
			1.35
		},
		"挑战以<color=#40FF51FF>【炼金梦梦】</color>为核心的敌阵，战斗中敌阵会合体成强大的<color=#40FF51FF>【超维梦梦·炼金】</color>，完成全部合体梦梦挑战，即可获得爱心梦梦进化石！"
	},
	{
		5,
		"热血梦梦",
		10342,
		false,
		"",
		"",
		10342,
		0,
		"",
		{
			-145,
			-312,
			1.4
		},
		"挑战以<color=#FF5869FF>【热血梦梦】</color>为核心的敌阵，战斗中敌阵会合体成强大的<color=#FF5869FF>【超维梦梦·热血】</color>，完成全部合体梦梦挑战，即可获得爱心梦梦进化石！"
	}
}
local t_ai_xin_mm_monster = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_ai_xin_mm_monster.dataList = dataList

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

return t_ai_xin_mm_monster
