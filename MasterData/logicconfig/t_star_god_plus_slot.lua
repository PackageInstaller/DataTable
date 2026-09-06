-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_god_plus_slot.lua

module("logicconfig.config.t_star_god_plus_slot", package.seeall)

local title = {
	slotLvPlan = 2,
	slot = 1,
	unlockPetLv = 3
}
local dataList = {
	{
		1,
		1,
		1
	},
	{
		2,
		1,
		1
	},
	{
		3,
		1,
		1
	},
	{
		4,
		1,
		1
	}
}
local t_star_god_plus_slot = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_star_god_plus_slot.dataList = dataList

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

return t_star_god_plus_slot
