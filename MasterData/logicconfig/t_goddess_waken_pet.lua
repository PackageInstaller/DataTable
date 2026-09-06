-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_waken_pet.lua

module("logicconfig.config.t_goddess_waken_pet", package.seeall)

local title = {
	qualityPlanId = 5,
	goddessId = 2,
	pos = 6,
	skinId = 3,
	scale = 7,
	jumpTo = 8,
	planId = 1,
	startDay = 4
}
local dataList = {
	{
		1,
		1,
		16006,
		0,
		1,
		{
			-40,
			-680
		},
		{
			1.5,
			1.5
		},
		""
	},
	{
		1,
		2,
		10097,
		14,
		2,
		{
			-40,
			-680
		},
		{
			1.5,
			1.5
		},
		""
	}
}
local t_goddess_waken_pet = {
	{
		dataList[1],
		dataList[2]
	}
}

t_goddess_waken_pet.dataList = dataList

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

return t_goddess_waken_pet
