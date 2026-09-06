-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_growth_path_strengthen.lua

module("logicconfig.config.t_pet_growth_path_strengthen", package.seeall)

local title = {
	id = 2,
	needScore = 5,
	strengthenType = 3,
	prize = 4,
	strengthenPlanId = 1
}
local dataList = {
	{
		1,
		1,
		1,
		"",
		20
	},
	{
		1,
		2,
		2,
		"",
		40
	},
	{
		1,
		3,
		3,
		"7:121084:5:14003:1#7:122084:5:14003:1#7:123084:5:14003:1#7:124084:5:14003:1",
		60
	},
	{
		1,
		4,
		4,
		"",
		80
	},
	{
		1,
		5,
		5,
		"",
		100
	},
	{
		2,
		1,
		1,
		"",
		20
	},
	{
		2,
		2,
		2,
		"",
		40
	},
	{
		2,
		3,
		3,
		"",
		60
	},
	{
		2,
		4,
		4,
		"",
		80
	},
	{
		2,
		5,
		5,
		"",
		100
	}
}
local t_pet_growth_path_strengthen = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_pet_growth_path_strengthen.dataList = dataList

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

return t_pet_growth_path_strengthen
