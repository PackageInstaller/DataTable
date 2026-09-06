-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_brother_hood_physical.lua

module("logicconfig.config.t_brother_hood_physical", package.seeall)

local title = {
	physicalCost = 2,
	physicalPlan = 1
}
local dataList = {
	{
		1,
		"66:8:1"
	}
}
local t_brother_hood_physical = {
	dataList[1]
}

t_brother_hood_physical.dataList = dataList

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

return t_brother_hood_physical
