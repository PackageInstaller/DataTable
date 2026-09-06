-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_decoration_property_zdl.lua

module("logicconfig.config.t_decoration_property_zdl", package.seeall)

local title = {
	zdl = 3,
	property = 1,
	perValue = 2
}
local dataList = {
	{
		"生命",
		0.1,
		1
	},
	{
		"物攻",
		0.25,
		0.5
	},
	{
		"物防",
		0.33,
		1
	},
	{
		"魔攻",
		0.25,
		0.5
	},
	{
		"魔防",
		0.33,
		1
	},
	{
		"超攻",
		0.17,
		1
	},
	{
		"超防",
		0.25,
		1
	},
	{
		"速度",
		1,
		1
	}
}
local t_decoration_property_zdl = {
	生命 = dataList[1],
	物攻 = dataList[2],
	物防 = dataList[3],
	魔攻 = dataList[4],
	魔防 = dataList[5],
	超攻 = dataList[6],
	超防 = dataList[7],
	速度 = dataList[8]
}

t_decoration_property_zdl.dataList = dataList

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

return t_decoration_property_zdl
