-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_dragon_team.lua

module("logicconfig.config.t_divine_king_dragon_team", package.seeall)

local title = {
	stageDesc = 4,
	teamId = 2,
	bgPath = 5,
	tipsDesc = 6,
	creepsMasterId = 3,
	teamPlanId = 1
}
local dataList = {
	{
		1,
		1,
		101,
		"1",
		"btn_sywzsl_05",
		"高血量：该精灵生命值提高30%"
	},
	{
		1,
		2,
		102,
		"2",
		"btn_sywzsl_05",
		"高攻击：该精灵攻击力提高30%"
	},
	{
		1,
		3,
		103,
		"3",
		"btn_sywzsl_05",
		"满气势：该精灵进场时获得满气势"
	},
	{
		2,
		1,
		201,
		"1",
		"btn_sywzsl_06",
		"高血量：该精灵生命值提高30%；\n高攻击：该精灵攻击力提高30%"
	},
	{
		2,
		2,
		202,
		"2",
		"btn_sywzsl_06",
		"高攻击：该精灵攻击力提高30%；\n满气势：该精灵进场时获得满气势"
	},
	{
		2,
		3,
		203,
		"3",
		"btn_sywzsl_06",
		"高血量：该精灵生命值提高30%；\n满气势：该精灵进场时获得满气势"
	},
	{
		3,
		1,
		301,
		"1",
		"btn_sywzsl_07",
		"隐身：该精灵获得隐身直到己阵其他精灵全部阵亡；\n复活：该精灵受到致命伤害时，恢复满血（最多触发2次）；\n嘲讽：该精灵获得嘲讽"
	},
	{
		3,
		2,
		302,
		"2",
		"btn_sywzsl_07",
		"隐身：该精灵获得隐身直到己阵其他精灵全部阵亡；\n复活：该精灵受到致命伤害时，恢复满血（最多触发2次）；\n嘲讽：该精灵获得嘲讽"
	},
	{
		3,
		3,
		303,
		"3",
		"btn_sywzsl_07",
		"隐身：该精灵获得隐身直到己阵其他精灵全部阵亡；\n复活：该精灵受到致命伤害时，恢复满血（最多触发2次）；\n嘲讽：该精灵获得嘲讽"
	}
}
local t_divine_king_dragon_team = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_divine_king_dragon_team.dataList = dataList

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

return t_divine_king_dragon_team
