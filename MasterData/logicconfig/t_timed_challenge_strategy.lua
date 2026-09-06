-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_strategy.lua

module("logicconfig.config.t_timed_challenge_strategy", package.seeall)

local title = {
	id = 1,
	topTips = 2,
	relations = 5,
	raceId = 4,
	bomTips = 3
}
local dataList = {
	{
		1,
		"1.尽量上阵<color=#eb4642>火</color>属性精灵，触发属性克制效果。",
		"2.上阵<color=#eb4642>龙炎</color>和2只火属性精灵，触发龙炎英雄技能",
		0,
		"火=>草"
	},
	{
		2,
		"1.尽量上阵<color=#eb4642>水</color>属性精灵，触发属性克制效果。",
		"2.双方精灵每次出手都会提升<color=#eb4642>相邻</color>精灵<color=#eb4642>25点气势</color>，尽量上阵<color=#eb4642>战力更高</color>的精灵。",
		0,
		"水=>火"
	},
	{
		3,
		"1.尽量上阵<color=#eb4642>光</color>属性精灵，触发属性克制效果。",
		"2.插入验证精灵<color=#eb4642>光明王</color>，全属性可<color=#eb4642>增加20%</color>",
		10100,
		"光<=>暗"
	},
	{
		4,
		"1.尽量上阵<color=#eb4642>草</color>属性精灵，触发属性克制效果。",
		"2.插入验证精灵<color=#eb4642>潘多拉</color>，全属性可<color=#eb4642>增加20%</color>",
		10167,
		"草=>水"
	},
	{
		22,
		"1.尽量上阵<color=#eb4642>光</color>、<color=#eb4642>暗</color>属性精灵，避免被属性克制或触发对敌方的属性克制效果。",
		"2.上阵带有英雄技的精灵，触发英雄技能",
		0,
		"光<=>暗"
	}
}
local t_timed_challenge_strategy = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	[22] = dataList[5]
}

t_timed_challenge_strategy.dataList = dataList

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

return t_timed_challenge_strategy
