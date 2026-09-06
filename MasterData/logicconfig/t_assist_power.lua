-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_assist_power.lua

module("logicconfig.config.t_assist_power", package.seeall)

local title = {
	propertyParam = 2,
	teamTotalLevel = 3,
	level = 1
}
local dataList = {
	{
		1,
		"速度+80",
		50
	},
	{
		2,
		"速度+200",
		100
	},
	{
		3,
		"速度+340",
		150
	},
	{
		4,
		"速度+500",
		200
	},
	{
		5,
		"速度+670",
		250
	},
	{
		6,
		"速度+850",
		300
	},
	{
		7,
		"速度+1040",
		350
	},
	{
		8,
		"速度+1230",
		400
	},
	{
		9,
		"速度+1440",
		450
	},
	{
		10,
		"速度+1650",
		500
	}
}
local t_assist_power = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10]
}

t_assist_power.dataList = dataList

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

return t_assist_power
