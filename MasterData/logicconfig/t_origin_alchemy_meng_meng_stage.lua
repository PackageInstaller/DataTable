-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_alchemy_meng_meng_stage.lua

module("logicconfig.config.t_origin_alchemy_meng_meng_stage", package.seeall)

local title = {
	stageId = 2,
	name = 5,
	markPosition = 3,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		601001,
		1,
		{
			3,
			1,
			0,
			0,
			3,
			0,
			0,
			0,
			0
		},
		1001,
		82056661
	},
	{
		601001,
		2,
		{
			1,
			0,
			0,
			0,
			3,
			0,
			0,
			0,
			0
		},
		1002,
		82056662
	},
	{
		601001,
		3,
		{
			3,
			0,
			0,
			0,
			0,
			1,
			0,
			0,
			0
		},
		1003,
		82056663
	},
	{
		601001,
		4,
		{
			2,
			3,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		1004,
		82056664
	},
	{
		601001,
		5,
		{
			0,
			1,
			0,
			2,
			0,
			0,
			0,
			0,
			0
		},
		1005,
		82056665
	},
	{
		601001,
		6,
		{
			0,
			0,
			1,
			0,
			0,
			2,
			0,
			0,
			0
		},
		1006,
		82056666
	},
	{
		601001,
		7,
		{
			1,
			3,
			0,
			0,
			3,
			0,
			0,
			0,
			0
		},
		1007,
		82056667
	},
	{
		601001,
		8,
		{
			2,
			0,
			0,
			0,
			1,
			0,
			0,
			0,
			0
		},
		1008,
		82056668
	}
}
local t_origin_alchemy_meng_meng_stage = {
	[601001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_origin_alchemy_meng_meng_stage.dataList = dataList

local multiLanguageCells = {
	name = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_origin_alchemy_meng_meng_stage
