-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_kun_lun_clg_extreme_stage.lua

module("logicconfig.config.t_divine_kun_lun_clg_extreme_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1,
	psychicSysPetId = 4
}
local dataList = {
	{
		464001,
		1,
		2001,
		10000001
	},
	{
		464001,
		2,
		2002,
		10000001
	},
	{
		464001,
		3,
		2003,
		10000001
	},
	{
		464001,
		4,
		2004,
		10000001
	},
	{
		464001,
		5,
		2005,
		10000001
	},
	{
		464001,
		6,
		2006,
		10000001
	}
}
local t_divine_kun_lun_clg_extreme_stage = {
	[464001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_kun_lun_clg_extreme_stage.dataList = dataList

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

return t_divine_kun_lun_clg_extreme_stage
