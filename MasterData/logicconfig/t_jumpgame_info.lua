-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jumpgame_info.lua

module("logicconfig.config.t_jumpgame_info", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"speedxFactor",
		20
	},
	{
		"gravity",
		-1500
	},
	{
		"touchTime",
		3
	},
	{
		"countTime",
		30
	},
	{
		"space",
		20
	}
}
local t_jumpgame_info = {
	speedxFactor = dataList[1],
	gravity = dataList[2],
	touchTime = dataList[3],
	countTime = dataList[4],
	space = dataList[5]
}

t_jumpgame_info.dataList = dataList

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

return t_jumpgame_info
