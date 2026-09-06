-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_roleactions.lua

module("logicconfig.config.t_roleactions", package.seeall)

local title = {
	access = 2,
	name = 5,
	action = 4,
	id = 1,
	icon = 3
}
local dataList = {
	{
		1,
		1,
		"roleac_dance",
		"dance",
		"跳舞"
	},
	{
		2,
		1,
		"roleac_sit",
		"sit",
		"坐"
	},
	{
		3,
		1,
		"roleac_bow",
		"salute",
		"敬礼"
	},
	{
		4,
		0,
		"roleac_hello",
		"greet",
		"打招呼"
	}
}
local t_roleactions = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_roleactions.dataList = dataList

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

return t_roleactions
