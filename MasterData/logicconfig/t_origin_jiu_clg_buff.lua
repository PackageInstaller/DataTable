-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_jiu_clg_buff.lua

module("logicconfig.config.t_origin_jiu_clg_buff", package.seeall)

local title = {
	sourceDesc = 5,
	name = 3,
	buffId = 2,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		577001,
		1,
		"序列之环1",
		"在受到非克制伤害时，将此次伤害降低20%",
		"通关生死之轴"
	},
	{
		577001,
		2,
		"序列之环2",
		"首次受到致命伤害时，复活并获得30%血量",
		"通关轮回之轴"
	},
	{
		577001,
		3,
		"序列之环3",
		"进入战斗时，获得40点通灵点",
		"通关冥王之轴"
	}
}
local t_origin_jiu_clg_buff = {
	[577001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_jiu_clg_buff.dataList = dataList

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

return t_origin_jiu_clg_buff
