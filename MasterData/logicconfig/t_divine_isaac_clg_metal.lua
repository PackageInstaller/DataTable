-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_isaac_clg_metal.lua

module("logicconfig.config.t_divine_isaac_clg_metal", package.seeall)

local title = {
	clientMatStr = 3,
	metalId = 1,
	formula = 2
}
local dataList = {
	{
		1,
		"草:1#水:1#火:1",
		"1004:1490"
	},
	{
		2,
		"光:1#暗:1",
		"1004:1491"
	},
	{
		3,
		"空:1#创:1",
		"1004:1492"
	}
}
local t_divine_isaac_clg_metal = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_divine_isaac_clg_metal.dataList = dataList

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

return t_divine_isaac_clg_metal
