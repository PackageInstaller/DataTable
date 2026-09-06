-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_chen_clg_normal_stage.lua

module("logicconfig.config.t_divine_chen_clg_normal_stage", package.seeall)

local title = {
	supportPetPoolId = 5,
	buffId = 4,
	creepsMasterId = 3,
	activityId = 1,
	day = 2
}
local dataList = {
	{
		457001,
		1,
		{
			2001,
			2002,
			2003
		},
		1,
		1
	},
	{
		457001,
		2,
		{
			2004,
			2005,
			2006
		},
		2,
		1
	},
	{
		457001,
		3,
		{
			2007,
			2008,
			2009
		},
		3,
		1
	},
	{
		457002,
		1,
		{
			2001,
			2002,
			2003
		},
		1,
		1
	},
	{
		457002,
		2,
		{
			2004,
			2005,
			2006
		},
		2,
		1
	},
	{
		457002,
		3,
		{
			2007,
			2008,
			2009
		},
		3,
		1
	}
}
local t_divine_chen_clg_normal_stage = {
	[457001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[457002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_chen_clg_normal_stage.dataList = dataList

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

return t_divine_chen_clg_normal_stage
