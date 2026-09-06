-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_year_pray_step.lua

module("logicconfig.config.t_new_year_pray_step", package.seeall)

local title = {
	stepId = 2,
	activityId = 1,
	choiceId = 3
}
local dataList = {
	{
		326001,
		1,
		1
	},
	{
		326001,
		1,
		2
	},
	{
		326001,
		1,
		3
	},
	{
		326001,
		2,
		1
	},
	{
		326001,
		2,
		2
	},
	{
		326001,
		2,
		3
	},
	{
		326001,
		3,
		1
	}
}
local t_new_year_pray_step = {
	[326001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7]
		}
	}
}

t_new_year_pray_step.dataList = dataList

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

return t_new_year_pray_step
