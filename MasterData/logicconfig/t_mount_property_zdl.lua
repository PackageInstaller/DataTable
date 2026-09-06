-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mount_property_zdl.lua

module("logicconfig.config.t_mount_property_zdl", package.seeall)

local title = {
	zdl = 2,
	ratio = 3,
	attribute = 1
}
local dataList = {
	{
		"生命",
		0.0125,
		1
	},
	{
		"攻击",
		0.09375,
		1
	},
	{
		"物防",
		0.0625,
		1
	},
	{
		"魔防",
		0.0625,
		1
	},
	{
		"速度",
		0.375,
		1
	},
	{
		"命中率",
		10000,
		1
	},
	{
		"闪避率",
		10000,
		1
	},
	{
		"破击率",
		8000,
		1
	},
	{
		"格挡率",
		8000,
		1
	},
	{
		"暴击率",
		6000,
		1
	},
	{
		"防暴率",
		6000,
		1
	}
}
local t_mount_property_zdl = {
	生命 = dataList[1],
	攻击 = dataList[2],
	物防 = dataList[3],
	魔防 = dataList[4],
	速度 = dataList[5],
	命中率 = dataList[6],
	闪避率 = dataList[7],
	破击率 = dataList[8],
	格挡率 = dataList[9],
	暴击率 = dataList[10],
	防暴率 = dataList[11]
}

t_mount_property_zdl.dataList = dataList

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

return t_mount_property_zdl
