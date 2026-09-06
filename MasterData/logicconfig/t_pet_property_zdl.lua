-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_property_zdl.lua

module("logicconfig.config.t_pet_property_zdl", package.seeall)

local title = {
	zdlUnit = 2,
	attribute = 1
}
local dataList = {
	{
		"生命",
		0.05
	},
	{
		"攻击",
		0.375
	},
	{
		"物防",
		0.25
	},
	{
		"魔防",
		0.25
	},
	{
		"速度",
		1.5
	},
	{
		"命中率",
		10000
	},
	{
		"闪避率",
		10000
	},
	{
		"破击率",
		8000
	},
	{
		"格挡率",
		8000
	},
	{
		"暴击率",
		6000
	},
	{
		"防暴率",
		6000
	},
	{
		"起始气势",
		50
	}
}
local t_pet_property_zdl = {
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
	防暴率 = dataList[11],
	起始气势 = dataList[12]
}

t_pet_property_zdl.dataList = dataList

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

return t_pet_property_zdl
