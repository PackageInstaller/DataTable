-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddishitian_stage_type.lua

module("logicconfig.config.t_goddishitian_stage_type", package.seeall)

local title = {
	bgPath = 6,
	bShowScore = 7,
	desc = 3,
	viewTitle = 5,
	stageType = 1,
	titleDesc = 4,
	passLine = 2
}
local dataList = {
	{
		1,
		8,
		"根据克制攻击次数评分",
		"克制攻击",
		"星之挑战",
		"challenge/board_dst_bg01",
		false
	},
	{
		2,
		8,
		"根据通关回合数评分",
		"回合数",
		"月之挑战",
		"challenge/board_dst_bg01",
		false
	},
	{
		3,
		8,
		"根据伤害量评分",
		"伤害量/W",
		"夜之挑战",
		"challenge/board_dst_bg01",
		true
	},
	{
		4,
		48,
		"根据存活精灵数评分",
		"存活个数",
		"神启挑战",
		"challenge/board_dst_bg02",
		false
	}
}
local t_goddishitian_stage_type = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_goddishitian_stage_type.dataList = dataList

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

return t_goddishitian_stage_type
