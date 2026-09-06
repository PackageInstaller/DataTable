-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_rare_compose.lua

module("logicconfig.config.t_pet_rare_compose", package.seeall)

local title = {
	needNum = 2,
	needExtCost = 3,
	rareId = 1
}
local dataList = {
	{
		2,
		8,
		"105:149:300"
	},
	{
		3,
		8,
		"105:149:1500"
	}
}
local t_pet_rare_compose = {
	[2] = dataList[1],
	[3] = dataList[2]
}

t_pet_rare_compose.dataList = dataList

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

return t_pet_rare_compose
