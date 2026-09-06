-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_good_feeling_unlock_voice.lua

module("logicconfig.config.t_good_feeling_unlock_voice", package.seeall)

local title = {
	index = 1,
	lv = 2
}
local dataList = {
	{
		1,
		5
	},
	{
		2,
		10
	},
	{
		3,
		15
	},
	{
		4,
		18
	},
	{
		5,
		20
	},
	{
		6,
		25
	},
	{
		7,
		30
	}
}
local t_good_feeling_unlock_voice = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_good_feeling_unlock_voice.dataList = dataList

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

return t_good_feeling_unlock_voice
