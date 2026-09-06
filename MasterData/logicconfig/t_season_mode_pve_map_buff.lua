-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_map_buff.lua

module("logicconfig.config.t_season_mode_pve_map_buff", package.seeall)

local title = {
	param = 4,
	id = 2,
	seasonId = 1,
	clazz = 3,
	icon = 5,
	desc = 6
}
local dataList = {
	{
		2,
		1,
		"MySideBuff",
		"2:99",
		"icon_expedition_shanghaitisheng",
		"在下面%d次战斗中，伤害增加20%%，胜利之后次数减一"
	},
	{
		2,
		2,
		"MySideBuff",
		"20024274:99",
		"icon_expedition_kezhizengqiang",
		"在下面%d次战斗中，精灵属性克制伤害增加40%%，胜利之后次数减一"
	},
	{
		2,
		3,
		"DecStrengthCost",
		"0.5",
		"icon_expedition_changsheng",
		"在下面%d次战斗中，体力消耗减少50%%，胜利之后次数减一"
	},
	{
		3,
		1,
		"MySideBuff",
		"2:99",
		"icon_expedition_shanghaitisheng",
		"在下面%d次战斗中，伤害增加20%%，胜利之后次数减一"
	},
	{
		3,
		2,
		"MySideBuff",
		"20024274:99",
		"icon_expedition_kezhizengqiang",
		"在下面%d次战斗中，精灵属性克制伤害增加40%%，胜利之后次数减一"
	},
	{
		3,
		3,
		"DecStrengthCost",
		"0.5",
		"icon_expedition_changsheng",
		"在下面%d次战斗中，体力消耗减少50%%，胜利之后次数减一"
	}
}
local t_season_mode_pve_map_buff = {
	[2] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[3] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_season_mode_pve_map_buff.dataList = dataList

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

return t_season_mode_pve_map_buff
