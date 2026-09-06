-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_boccaccio_chapter3_stage.lua

module("logicconfig.config.t_boccaccio_chapter3_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		580001,
		1,
		3001
	},
	{
		580001,
		2,
		3002
	},
	{
		580001,
		3,
		3003
	},
	{
		580001,
		4,
		3004
	},
	{
		580001,
		5,
		3005
	},
	{
		580001,
		6,
		3006
	},
	{
		580001,
		7,
		3007
	},
	{
		580001,
		8,
		3008
	},
	{
		580001,
		9,
		3009
	},
	{
		580001,
		10,
		3010
	},
	{
		580001,
		11,
		3011
	},
	{
		580001,
		12,
		3012
	},
	{
		580001,
		13,
		3013
	},
	{
		580001,
		14,
		3014
	},
	{
		580001,
		15,
		3015
	}
}
local t_boccaccio_chapter3_stage = {
	[580001] = {
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
}

t_boccaccio_chapter3_stage.dataList = dataList

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

return t_boccaccio_chapter3_stage
