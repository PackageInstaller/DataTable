-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_xingjiang_stage.lua

module("logicconfig.config.t_origin_xingjiang_stage", package.seeall)

local title = {
	canUseTransmogId = 4,
	stageId = 2,
	creepsMasterId = 3,
	topDesc = 5,
	activityId = 1
}
local dataList = {
	{
		570001,
		1,
		1001,
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		"普攻+1进度，超杀+2进度，进度达到5后变身为幻化精灵继续战斗"
	},
	{
		570001,
		2,
		1002,
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		"普攻+1进度，超杀+2进度，进度达到5后变身为幻化精灵继续战斗"
	},
	{
		570001,
		3,
		1003,
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		"普攻+1进度，超杀+2进度，进度达到5后变身为幻化精灵继续战斗"
	},
	{
		570001,
		4,
		1004,
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		"普攻+1进度，超杀+2进度，进度达到5后变身为幻化精灵继续战斗"
	},
	{
		570001,
		5,
		1005,
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		"普攻+1进度，超杀+2进度，进度达到5后变身为幻化精灵继续战斗"
	},
	{
		570001,
		6,
		1006,
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		"普攻+1进度，超杀+2进度，进度达到5后变身为幻化精灵继续战斗"
	}
}
local t_origin_xingjiang_stage = {
	[570001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_origin_xingjiang_stage.dataList = dataList

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

return t_origin_xingjiang_stage
