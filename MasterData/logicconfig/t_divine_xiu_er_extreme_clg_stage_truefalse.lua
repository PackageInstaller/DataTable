-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xiu_er_extreme_clg_stage_truefalse.lua

module("logicconfig.config.t_divine_xiu_er_extreme_clg_stage_truefalse", package.seeall)

local title = {
	desc = 2,
	pos = 4,
	iconPath = 3,
	tureFalseStageId = 1
}
local dataList = {
	{
		1,
		"是之力：%s",
		"ui/icon/character/icon_15016_shenyaoanheimengmeng",
		{
			-170,
			165
		}
	},
	{
		2,
		"是之力：%s",
		"ui/icon/character/icon_13013_kunlun",
		{
			-386,
			-35
		}
	},
	{
		3,
		"是之力：%s",
		"ui/icon/character/icon_11014_tuntian",
		{
			-170,
			-235
		}
	},
	{
		4,
		"非之力：%s",
		"ui/icon/character/icon_14017_wudi",
		{
			57,
			165
		}
	},
	{
		5,
		"非之力：%s",
		"ui/icon/character/icon_12014_fuyao",
		{
			260,
			-35
		}
	},
	{
		6,
		"非之力：%s",
		"ui/icon/character/icon_17008_zhuzaimiya",
		{
			57,
			-235
		}
	}
}
local t_divine_xiu_er_extreme_clg_stage_truefalse = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_divine_xiu_er_extreme_clg_stage_truefalse.dataList = dataList

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

return t_divine_xiu_er_extreme_clg_stage_truefalse
