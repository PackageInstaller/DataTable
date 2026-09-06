-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_seek_pet_cycle.lua

module("logicconfig.config.t_seek_pet_cycle", package.seeall)

local title = {
	startTime = 2,
	cycleId = 1
}
local dataList = {
	{
		1,
		"2000-01-01T05:00:00"
	},
	{
		2,
		"2037-05-01T05:00:00"
	}
}
local t_seek_pet_cycle = {
	dataList[1],
	dataList[2]
}

t_seek_pet_cycle.dataList = dataList

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

return t_seek_pet_cycle
