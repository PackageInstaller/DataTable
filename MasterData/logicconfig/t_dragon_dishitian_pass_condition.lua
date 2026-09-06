-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_dishitian_pass_condition.lua

module("logicconfig.config.t_dragon_dishitian_pass_condition", package.seeall)

local title = {
	conditionId = 1,
	desc = 3,
	winId = 2
}
local dataList = {
	{
		1,
		55,
		"我方精灵存活>=5"
	},
	{
		2,
		25,
		"我方精灵存活>=6"
	},
	{
		3,
		34,
		"我方水属性精灵存活>=5"
	},
	{
		4,
		38,
		"我方火属性精灵存活>=4"
	},
	{
		5,
		44,
		"我方草属性精灵存活>=5"
	},
	{
		6,
		49,
		"我方光属性精灵存活>=5"
	},
	{
		7,
		53,
		"我方暗属性精灵存活>=4"
	},
	{
		8,
		102,
		"我方空属性精灵存活>=5"
	},
	{
		9,
		75,
		"指定3个大回合内"
	},
	{
		10,
		74,
		"指定4个大回合内"
	},
	{
		11,
		163,
		"指定2个大回合内"
	},
	{
		12,
		164,
		"我方创属性精灵存活>=5"
	},
	{
		13,
		56,
		"我方精灵存活>=4"
	},
	{
		14,
		57,
		"我方精灵存活>=3"
	},
	{
		15,
		111,
		"我方草属性精灵存活>=3"
	},
	{
		16,
		115,
		"我方水属性精灵存活>=3"
	}
}
local t_dragon_dishitian_pass_condition = {
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
	dataList[15],
	dataList[16]
}

t_dragon_dishitian_pass_condition.dataList = dataList

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

return t_dragon_dishitian_pass_condition
