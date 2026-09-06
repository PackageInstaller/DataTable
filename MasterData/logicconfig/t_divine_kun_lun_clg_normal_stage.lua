-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_kun_lun_clg_normal_stage.lua

module("logicconfig.config.t_divine_kun_lun_clg_normal_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		464001,
		1,
		1001
	},
	{
		464001,
		2,
		1002
	},
	{
		464001,
		3,
		1003
	},
	{
		464001,
		4,
		1004
	},
	{
		464001,
		5,
		1005
	},
	{
		464001,
		6,
		1006
	},
	{
		464001,
		7,
		1007
	},
	{
		464001,
		8,
		1008
	},
	{
		464001,
		9,
		1009
	}
}
local t_divine_kun_lun_clg_normal_stage = {
	[464001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_divine_kun_lun_clg_normal_stage.dataList = dataList

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

return t_divine_kun_lun_clg_normal_stage
