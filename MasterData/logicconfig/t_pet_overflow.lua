-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_overflow.lua

module("logicconfig.config.t_pet_overflow", package.seeall)

local title = {
	rare = 1,
	scoreNum = 2
}
local dataList = {
	{
		4,
		100
	}
}
local t_pet_overflow = {
	[4] = dataList[1]
}

t_pet_overflow.dataList = dataList

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

return t_pet_overflow
