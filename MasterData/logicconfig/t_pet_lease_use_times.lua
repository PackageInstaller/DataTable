-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_lease_use_times.lua

module("logicconfig.config.t_pet_lease_use_times", package.seeall)

local title = {
	usageId = 1,
	maxUseTimes = 2
}
local dataList = {
	{
		1,
		1
	},
	{
		2,
		1
	},
	{
		3,
		1
	}
}
local t_pet_lease_use_times = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_pet_lease_use_times.dataList = dataList

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

return t_pet_lease_use_times
