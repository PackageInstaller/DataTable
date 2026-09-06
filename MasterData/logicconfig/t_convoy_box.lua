-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_convoy_box.lua

module("logicconfig.config.t_convoy_box", package.seeall)

local title = {
	eachRobNum = 6,
	boxName = 2,
	convoyNum = 4,
	boxId = 1,
	eachLossNum = 5,
	rewardPreview = 3
}
local dataList = {
	{
		1,
		"陈年木箱",
		"8:5:0#8:27:0#4:901:0",
		100,
		20,
		50
	},
	{
		2,
		"厚重铜箱",
		"8:5:0#8:27:0#4:901:0",
		200,
		40,
		100
	},
	{
		3,
		"精致银箱",
		"8:5:0#8:27:0#4:901:0#8:41:0",
		400,
		80,
		200
	},
	{
		4,
		"华丽金箱",
		"8:5:0#8:27:0#4:901:0#8:41:0",
		600,
		120,
		300
	},
	{
		5,
		"璀璨水晶箱",
		"8:5:0#8:27:0#4:901:0#8:41:0",
		1000,
		200,
		500
	}
}
local t_convoy_box = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_convoy_box.dataList = dataList

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

return t_convoy_box
