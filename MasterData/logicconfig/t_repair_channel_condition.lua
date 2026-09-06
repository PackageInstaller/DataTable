-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_repair_channel_condition.lua

module("logicconfig.config.t_repair_channel_condition", package.seeall)

local title = {
	conditionId = 1,
	petValidator = 2,
	requireDesc = 4,
	requirement = 3
}
local dataList = {
	{
		1,
		"Job$魔法",
		1,
		"派遣%s只%s职业精灵"
	},
	{
		2,
		"RaceType$光",
		2,
		"派遣%s只%s属性精灵"
	},
	{
		3,
		"AwakenLevel$大于等于,2",
		1,
		"派遣%s只觉醒≥%s的精灵"
	},
	{
		4,
		"Race$12046",
		1,
		"派遣%s只[%s]"
	},
	{
		5,
		"Job$肉盾",
		3,
		"派遣%s只%s职业精灵"
	},
	{
		6,
		"Job$疾速",
		2,
		"派遣%s只%s职业精灵"
	},
	{
		7,
		"RaceType$光",
		1,
		"派遣%s只%s属性精灵"
	},
	{
		8,
		"Job$肉盾",
		1,
		"派遣%s只%s职业精灵"
	},
	{
		9,
		"AwakenLevel$大于等于,1",
		2,
		"派遣%s只觉醒≥%s的精灵"
	},
	{
		10,
		"Job$疾速",
		1,
		"派遣%s只%s职业精灵"
	},
	{
		11,
		"RaceType$水",
		1,
		"派遣%s只%s属性精灵"
	},
	{
		12,
		"RaceType$火",
		1,
		"派遣%s只%s属性精灵"
	},
	{
		13,
		"RaceType$草",
		1,
		"派遣%s只%s属性精灵"
	},
	{
		14,
		"Job$平衡",
		2,
		"派遣%s只%s职业精灵"
	},
	{
		15,
		"Job$平衡",
		1,
		"派遣%s只%s职业精灵"
	}
}
local t_repair_channel_condition = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15]
}

t_repair_channel_condition.dataList = dataList

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

return t_repair_channel_condition
