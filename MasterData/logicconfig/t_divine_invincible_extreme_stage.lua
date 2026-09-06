-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_invincible_extreme_stage.lua

module("logicconfig.config.t_divine_invincible_extreme_stage", package.seeall)

local title = {
	stageId = 2,
	skinId = 4,
	extremePlanId = 1,
	creepsMasterId = 3,
	pos = 5
}
local dataList = {
	{
		1,
		1,
		1001,
		13023,
		{
			-577,
			120
		}
	},
	{
		1,
		2,
		1002,
		16027,
		{
			-530,
			-80
		}
	},
	{
		1,
		3,
		1003,
		14026,
		{
			-367,
			-184
		}
	},
	{
		1,
		4,
		1004,
		12024,
		{
			-150,
			-184
		}
	},
	{
		1,
		5,
		1005,
		12028,
		{
			11,
			-80
		}
	},
	{
		1,
		6,
		1006,
		16031,
		{
			70,
			120
		}
	},
	{
		2,
		1,
		1001,
		13023,
		{
			-577,
			120
		}
	},
	{
		2,
		2,
		1002,
		16027,
		{
			-530,
			-80
		}
	},
	{
		2,
		3,
		1003,
		14026,
		{
			-367,
			-184
		}
	},
	{
		2,
		4,
		1004,
		12024,
		{
			-150,
			-184
		}
	},
	{
		2,
		5,
		1005,
		12028,
		{
			11,
			-80
		}
	},
	{
		2,
		6,
		1006,
		16031,
		{
			70,
			120
		}
	}
}
local t_divine_invincible_extreme_stage = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_divine_invincible_extreme_stage.dataList = dataList

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

return t_divine_invincible_extreme_stage
