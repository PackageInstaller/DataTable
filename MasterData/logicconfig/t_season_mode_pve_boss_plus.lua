-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_boss_plus.lua

module("logicconfig.config.t_season_mode_pve_boss_plus", package.seeall)

local title = {
	txtTitle = 3,
	raceIdWithBuff = 4,
	seasonId = 1,
	buffDesc = 5,
	id = 2,
	skinId = 6,
	imgRes = 7
}
local dataList = {
	{
		2,
		7557,
		"石姬新娘·镭拉",
		{
			14011,
			10181,
			16010
		},
		"每使用下面精灵进入战斗，全阵伤害提高10%",
		10332,
		"board_s2_saijiwanfa_33"
	},
	{
		2,
		1010,
		"灭世魔女·艾希",
		{
			15013,
			10183,
			11002
		},
		"每使用下面精灵进入战斗，全阵受伤降低10%",
		10330,
		"board_s2_saijiwanfa_34"
	},
	{
		2,
		8433,
		"魔魂·暗影之子",
		{
			17006,
			17002,
			17003
		},
		"每使用下面精灵进入战斗，全阵初始气势增加15点",
		10162,
		"board_s2_saijiwanfa_35"
	}
}
local t_season_mode_pve_boss_plus = {
	[2] = {
		[7557] = dataList[1],
		[1010] = dataList[2],
		[8433] = dataList[3]
	}
}

t_season_mode_pve_boss_plus.dataList = dataList

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

return t_season_mode_pve_boss_plus
