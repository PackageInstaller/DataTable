-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dragon_arya_clg_rule.lua

module("logicconfig.config.t_divine_dragon_arya_clg_rule", package.seeall)

local title = {
	tagType = 2,
	name = 3,
	activityId = 1,
	res = 4
}
local dataList = {
	{
		337001,
		1,
		"超神时空（空）印记",
		"board_shenyaolongzun_bq01"
	},
	{
		337001,
		2,
		"无烬时空（火）印记",
		"board_shenyaolongzun_bq02"
	},
	{
		337001,
		3,
		"秩序时空（水）印记",
		"board_shenyaolongzun_bq04"
	},
	{
		337001,
		4,
		"王者时空（创）印记",
		"board_shenyaolongzun_bq03"
	},
	{
		337001,
		5,
		"次元时空（光）印记",
		"board_shenyaolongzun_bq05"
	},
	{
		337001,
		6,
		"永恒时空（草）印记",
		"board_shenyaolongzun_bq06"
	}
}
local t_divine_dragon_arya_clg_rule = {
	[337001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_dragon_arya_clg_rule.dataList = dataList

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

return t_divine_dragon_arya_clg_rule
