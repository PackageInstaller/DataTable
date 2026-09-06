-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_space_dragon_stage.lua

module("logicconfig.config.t_divine_king_space_dragon_stage", package.seeall)

local title = {
	stageId = 2,
	stagePlanId = 1,
	creepsMasterId = 3
}
local dataList = {
	{
		1,
		1,
		1011
	},
	{
		1,
		2,
		1010
	},
	{
		2,
		1,
		1009
	},
	{
		2,
		2,
		1012
	},
	{
		3,
		1,
		1003
	},
	{
		3,
		2,
		1006
	},
	{
		4,
		1,
		1004
	},
	{
		4,
		2,
		1002
	},
	{
		5,
		1,
		1005
	},
	{
		5,
		2,
		1007
	},
	{
		6,
		1,
		1008
	},
	{
		6,
		2,
		1001
	}
}
local t_divine_king_space_dragon_stage = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12]
	}
}

t_divine_king_space_dragon_stage.dataList = dataList

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

return t_divine_king_space_dragon_stage
