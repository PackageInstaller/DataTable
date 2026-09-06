-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ji_clg_normal_stage.lua

module("logicconfig.config.t_ji_clg_normal_stage", package.seeall)

local title = {
	stageId = 2,
	unlockSupportCreepsId = 5,
	unlockBuffId = 4,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		420001,
		1,
		1001,
		1,
		100000001
	},
	{
		420001,
		2,
		1002,
		2,
		100000002
	},
	{
		420001,
		3,
		1003,
		3,
		100000003
	},
	{
		420001,
		4,
		1004,
		4,
		100000004
	},
	{
		420001,
		5,
		1005,
		5,
		100000005
	}
}
local t_ji_clg_normal_stage = {
	[420001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_ji_clg_normal_stage.dataList = dataList

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

return t_ji_clg_normal_stage
