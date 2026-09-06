-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_boss_panel_step.lua

module("logicconfig.config.t_season_mode_pve_boss_panel_step", package.seeall)

local title = {
	content = 3,
	phaseId = 1,
	jumpTo = 6,
	grids = 5,
	title = 2,
	btnDesc = 4
}
local dataList = {
	{
		1,
		"<size=70>圣</size>境挑战·第1章",
		"到达影子圣殿区域，快前往“监视之瞳”下方，打开中央圣殿的传送阵吧",
		"传送阵",
		"1359",
		""
	},
	{
		2,
		"<size=70>圣</size>境挑战·第1章",
		"传送阵已打开，向中央圣殿进发吧",
		"撒达位置",
		"1349",
		""
	},
	{
		3,
		"<size=70>圣</size>境挑战·终章",
		"请指挥3支队伍，分别消灭撒达的分身",
		"分身位置",
		"894#1804#1346",
		""
	},
	{
		4,
		"<size=70>圣</size>境挑战·终章",
		"最终挑战！请指挥3支队伍，共同挑战撒达（全部队伍抵达撒达下方后开启挑战）",
		"撒达",
		"1349",
		""
	},
	{
		5,
		"挑战完成",
		"恭喜你，在<迷雾骰局>中成功击败撒达！",
		"领取精灵",
		"",
		"ui#seasonpassporttabview"
	}
}
local t_season_mode_pve_boss_panel_step = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_season_mode_pve_boss_panel_step.dataList = dataList

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

return t_season_mode_pve_boss_panel_step
