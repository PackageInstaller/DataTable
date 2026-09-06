-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pickLevel.lua

module("logicconfig.config.t_pickLevel", package.seeall)

local title = {
	startId = 2,
	levelNum = 3,
	id = 1
}
local dataList = {
	{
		1,
		1,
		15
	},
	{
		2,
		16,
		20
	},
	{
		3,
		36,
		5
	},
	{
		4,
		41,
		60
	}
}
local t_pickLevel = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_pickLevel.dataList = dataList

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

return t_pickLevel
