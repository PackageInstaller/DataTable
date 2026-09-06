-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dark_king_dragon_clg_stage.lua

module("logicconfig.config.t_divine_dark_king_dragon_clg_stage", package.seeall)

local title = {
	stageId = 3,
	activityId = 1,
	phaseId = 2,
	creepsMasterId = 5,
	baseAngle = 4
}
local dataList = {
	{
		526001,
		1,
		1,
		60,
		1001
	},
	{
		526001,
		1,
		2,
		120,
		1002
	},
	{
		526001,
		1,
		3,
		180,
		1003
	},
	{
		526001,
		1,
		4,
		240,
		1004
	},
	{
		526001,
		1,
		5,
		300,
		1005
	},
	{
		526001,
		2,
		1,
		60,
		1006
	},
	{
		526001,
		2,
		2,
		120,
		1007
	},
	{
		526001,
		2,
		3,
		180,
		1008
	},
	{
		526001,
		2,
		4,
		240,
		1009
	},
	{
		526001,
		2,
		5,
		300,
		1010
	},
	{
		526001,
		3,
		1,
		60,
		1011
	},
	{
		526001,
		3,
		2,
		120,
		1012
	},
	{
		526001,
		3,
		3,
		180,
		1013
	},
	{
		526001,
		3,
		4,
		240,
		1014
	},
	{
		526001,
		3,
		5,
		300,
		1015
	},
	{
		526001,
		4,
		1,
		0,
		1016
	}
}
local t_divine_dark_king_dragon_clg_stage = {
	[526001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5]
		},
		{
			dataList[6],
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10]
		},
		{
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15]
		},
		{
			dataList[16]
		}
	}
}

t_divine_dark_king_dragon_clg_stage.dataList = dataList

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

return t_divine_dark_king_dragon_clg_stage
