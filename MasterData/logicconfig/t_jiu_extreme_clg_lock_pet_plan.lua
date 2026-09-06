-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jiu_extreme_clg_lock_pet_plan.lua

module("logicconfig.config.t_jiu_extreme_clg_lock_pet_plan", package.seeall)

local title = {
	planId = 1,
	range = 3,
	distId = 2,
	lockCount = 4
}
local dataList = {
	{
		1,
		1,
		{
			1,
			1
		},
		1
	},
	{
		1,
		2,
		{
			2,
			2
		},
		2
	},
	{
		1,
		3,
		{
			3,
			3
		},
		3
	},
	{
		1,
		4,
		{
			4,
			4
		},
		4
	},
	{
		1,
		5,
		{
			5,
			5
		},
		5
	},
	{
		1,
		6,
		{
			6,
			99999
		},
		6
	},
	{
		2,
		1,
		{
			0,
			2
		},
		6
	},
	{
		2,
		2,
		{
			3,
			4
		},
		5
	},
	{
		2,
		3,
		{
			5,
			6
		},
		4
	},
	{
		2,
		4,
		{
			7,
			8
		},
		3
	},
	{
		2,
		5,
		{
			9,
			10
		},
		2
	},
	{
		2,
		6,
		{
			11,
			99999
		},
		1
	}
}
local t_jiu_extreme_clg_lock_pet_plan = {
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

t_jiu_extreme_clg_lock_pet_plan.dataList = dataList

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

return t_jiu_extreme_clg_lock_pet_plan
