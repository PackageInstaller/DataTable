-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_team_play_war_zone.lua

module("logicconfig.config.t_team_play_war_zone", package.seeall)

local title = {
	typeIcon = 6,
	name = 3,
	zoneId = 1,
	isOpen = 4,
	icon = 7,
	tpye = 2,
	bgIcon = 5
}
local dataList = {
	{
		1,
		"光",
		"光明战区",
		true,
		"board_guangjzwj_bg",
		"board_jzwj_guang",
		"board_jzwj_15"
	},
	{
		2,
		"暗",
		"黑暗战区",
		true,
		"bg_lsq",
		"board_jzwj_an",
		"board_jzwj_13"
	},
	{
		3,
		"草",
		"生命战区",
		true,
		"bg_zhmy_01",
		"board_jzwj_cao",
		"board_jzwj_17"
	},
	{
		4,
		"火",
		"赤炎战区",
		true,
		"board_huojzwj_bg",
		"board_jzwj_huo",
		"board_jzwj_16"
	},
	{
		5,
		"水",
		"冰霜战区",
		true,
		"board_shuijzwj_bg",
		"board_jzwj_shui",
		"board_jzwj_14"
	},
	{
		6,
		"空",
		"虚空战区",
		true,
		"pq_bg01",
		"board_jzwj_kong",
		"board_jzwj_18"
	},
	{
		7,
		"创",
		"创造战区",
		false,
		"sg_bg01",
		"board_jzwj_chuang",
		"board_jzwj_19"
	}
}
local t_team_play_war_zone = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_team_play_war_zone.dataList = dataList

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

return t_team_play_war_zone
