-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_battle_pillar_info.lua

module("logicconfig.config.t_family_battle_pillar_info", package.seeall)

local title = {
	bigIcon = 4,
	smallIcon = 3,
	name = 2,
	midIcon = 5,
	pillarId = 1
}
local dataList = {
	{
		1,
		"智慧神柱",
		"bg_llzz_05",
		"board_llzz_13",
		"board_llzz_06"
	},
	{
		2,
		"生命神柱",
		"bg_llzz_06",
		"board_llzz_11",
		"board_llzz_04"
	},
	{
		3,
		"力量神柱",
		"bg_llzz_02",
		"board_llzz_10",
		"board_llzz_03"
	},
	{
		4,
		"是非神柱",
		"bg_llzz_04",
		"board_llzz_12",
		"board_llzz_05"
	},
	{
		5,
		"时间神柱",
		"bg_llzz_03",
		"board_llzz_14",
		"board_llzz_07"
	}
}
local t_family_battle_pillar_info = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_family_battle_pillar_info.dataList = dataList

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

return t_family_battle_pillar_info
