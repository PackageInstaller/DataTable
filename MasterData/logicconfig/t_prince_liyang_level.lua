-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_prince_liyang_level.lua

module("logicconfig.config.t_prince_liyang_level", package.seeall)

local title = {
	efficiency = 4,
	need = 3,
	prize = 5,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		509001,
		1,
		0,
		0,
		"10:509004:500#10:509001:10000"
	},
	{
		509001,
		2,
		3,
		0,
		"10:509004:1500"
	},
	{
		509001,
		3,
		6,
		0,
		"10:509004:1500"
	},
	{
		509001,
		4,
		9,
		0,
		"10:509004:2000"
	},
	{
		509001,
		5,
		12,
		0,
		"10:509004:2000"
	},
	{
		509001,
		6,
		15,
		0,
		"10:509004:3000"
	},
	{
		509001,
		7,
		18,
		0,
		"10:509004:3000"
	},
	{
		509001,
		8,
		21,
		0,
		"10:509004:3500"
	},
	{
		509001,
		9,
		24,
		0,
		"10:509004:4000"
	},
	{
		509001,
		10,
		27,
		0,
		"10:509004:4000"
	}
}
local t_prince_liyang_level = {
	[509001] = {
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
}

t_prince_liyang_level.dataList = dataList

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

return t_prince_liyang_level
