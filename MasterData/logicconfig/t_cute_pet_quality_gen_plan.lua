-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cute_pet_quality_gen_plan.lua

module("logicconfig.config.t_cute_pet_quality_gen_plan", package.seeall)

local title = {
	weight = 3,
	quality = 2,
	planId = 1
}
local dataList = {
	{
		1,
		1,
		1
	},
	{
		1,
		2,
		0
	},
	{
		1,
		3,
		0
	},
	{
		1,
		4,
		0
	},
	{
		1,
		5,
		0
	},
	{
		2,
		1,
		1
	},
	{
		2,
		2,
		0
	},
	{
		2,
		3,
		0
	},
	{
		2,
		4,
		0
	},
	{
		2,
		5,
		0
	}
}
local t_cute_pet_quality_gen_plan = {
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

t_cute_pet_quality_gen_plan.dataList = dataList

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

return t_cute_pet_quality_gen_plan
