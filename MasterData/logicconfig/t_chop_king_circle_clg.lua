-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chop_king_circle_clg.lua

module("logicconfig.config.t_chop_king_circle_clg", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1,
	circleScorePlanId = 4
}
local dataList = {
	{
		470001,
		1,
		3001,
		3
	},
	{
		470001,
		2,
		3002,
		3
	},
	{
		470001,
		3,
		3003,
		3
	},
	{
		470001,
		4,
		3004,
		3
	},
	{
		470001,
		5,
		3005,
		3
	},
	{
		470001,
		6,
		3006,
		3
	},
	{
		470001,
		7,
		3007,
		3
	},
	{
		470001,
		8,
		3008,
		3
	},
	{
		470001,
		9,
		3009,
		3
	},
	{
		470001,
		10,
		3010,
		3
	}
}
local t_chop_king_circle_clg = {
	[470001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_chop_king_circle_clg.dataList = dataList

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

return t_chop_king_circle_clg
