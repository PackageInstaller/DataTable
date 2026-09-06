-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pin_dao_dao_reduce.lua

module("logicconfig.config.t_pin_dao_dao_reduce", package.seeall)

local title = {
	dailyReduceLimit = 4,
	firstReducePrize = 3,
	playerType = 2,
	reduceRange = 5,
	activityId = 1
}
local dataList = {
	{
		565001,
		1,
		135,
		99,
		{
			120,
			150
		}
	},
	{
		565001,
		2,
		250,
		99,
		{
			200,
			300
		}
	},
	{
		565001,
		3,
		95,
		99,
		{
			80,
			110
		}
	}
}
local t_pin_dao_dao_reduce = {
	[565001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_pin_dao_dao_reduce.dataList = dataList

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

return t_pin_dao_dao_reduce
