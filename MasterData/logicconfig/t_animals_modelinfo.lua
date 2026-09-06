-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_animals_modelinfo.lua

module("logicconfig.config.t_animals_modelinfo", package.seeall)

local title = {
	name = 4,
	partId = 5,
	type = 2,
	petId = 1,
	resId = 3
}
local dataList = {
	{
		1,
		1,
		1,
		"草莓",
		1035801
	},
	{
		1,
		1,
		2,
		"抹茶",
		1035802
	},
	{
		1,
		1,
		3,
		"巧克力",
		1035803
	},
	{
		1,
		2,
		1,
		"石头",
		1035811
	},
	{
		1,
		2,
		2,
		"剪刀",
		1035812
	},
	{
		1,
		2,
		3,
		"布",
		1035813
	}
}
local t_animals_modelinfo = {
	{
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		}
	}
}

t_animals_modelinfo.dataList = dataList

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

return t_animals_modelinfo
