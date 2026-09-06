-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_idiom_chain_difficult.lua

module("logicconfig.config.t_idiom_chain_difficult", package.seeall)

local title = {
	gamePlanId = 4,
	name = 3,
	activityId = 1,
	difficultId = 2
}
local dataList = {
	{
		543001,
		1,
		"简单",
		1
	},
	{
		543001,
		2,
		"困难",
		2
	},
	{
		543002,
		1,
		"简单",
		1
	}
}
local t_idiom_chain_difficult = {
	[543001] = {
		dataList[1],
		dataList[2]
	},
	[543002] = {
		dataList[3]
	}
}

t_idiom_chain_difficult.dataList = dataList

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

return t_idiom_chain_difficult
