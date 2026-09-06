-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ice_qibu_game_stage.lua

module("logicconfig.config.t_ice_qibu_game_stage", package.seeall)

local title = {
	stageId = 2,
	mapId = 3,
	activityId = 1
}
local dataList = {
	{
		507001,
		1,
		1
	},
	{
		507001,
		2,
		2
	},
	{
		507001,
		3,
		3
	},
	{
		507001,
		4,
		4
	},
	{
		507001,
		5,
		5
	},
	{
		507001,
		6,
		6
	},
	{
		507001,
		7,
		7
	},
	{
		507001,
		8,
		8
	},
	{
		507001,
		9,
		9
	},
	{
		507001,
		10,
		10
	},
	{
		507001,
		11,
		11
	},
	{
		507001,
		12,
		12
	},
	{
		507001,
		13,
		13
	},
	{
		507001,
		14,
		14
	},
	{
		507001,
		15,
		15
	}
}
local t_ice_qibu_game_stage = {
	[507001] = {
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

t_ice_qibu_game_stage.dataList = dataList

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

return t_ice_qibu_game_stage
