-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_jing_road_stage_ext.lua

module("logicconfig.config.t_chuang_jing_road_stage_ext", package.seeall)

local title = {
	pos = 5,
	name = 3,
	zoneId = 2,
	skinId = 4,
	activityId = 1,
	desc = 6
}
local dataList = {
	{
		396001,
		1,
		"光-Boss",
		"14018",
		{
			0,
			0
		},
		"击败BOSS即可获胜"
	},
	{
		396001,
		2,
		"水-Boss",
		"11021",
		{
			0,
			0
		},
		"对每个BOSS造成最低三千万伤害且伤害差值不高于100万时获胜"
	},
	{
		396001,
		3,
		"火-Boss",
		"12018",
		{
			0,
			0
		},
		"击败两阵时存活精灵相同即可获胜"
	},
	{
		396001,
		4,
		"草-Boss",
		"13009",
		{
			0,
			0
		},
		"击败所有敌阵即可获胜"
	},
	{
		396001,
		5,
		"暗-Boss",
		"15018",
		{
			0,
			0
		},
		"击败所有敌阵即可获胜"
	}
}
local t_chuang_jing_road_stage_ext = {
	[396001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_chuang_jing_road_stage_ext.dataList = dataList

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

return t_chuang_jing_road_stage_ext
