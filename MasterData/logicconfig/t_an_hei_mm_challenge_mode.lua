-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_an_hei_mm_challenge_mode.lua

module("logicconfig.config.t_an_hei_mm_challenge_mode", package.seeall)

local title = {
	relativeOpenDays = 3,
	showCoefficient = 5,
	fightMin = 4,
	modeId = 1,
	floorCoefficient = 6,
	normalPassPrize = 7,
	perfectPassPrize = 8,
	desc = 2
}
local dataList = {
	{
		1,
		"简单",
		0,
		12000,
		4000,
		1000,
		"4:94:50",
		"4:94:60"
	},
	{
		2,
		"适中",
		1,
		15000,
		5000,
		1000,
		"4:94:65",
		"4:94:80"
	},
	{
		3,
		"困难",
		2,
		18000,
		6000,
		1000,
		"4:94:80",
		"4:94:100"
	},
	{
		4,
		"深渊",
		3,
		24000,
		8000,
		1000,
		"4:94:95",
		"4:94:120"
	},
	{
		5,
		"地狱",
		4,
		30000,
		10000,
		1000,
		"4:94:120",
		"4:94:150"
	}
}
local t_an_hei_mm_challenge_mode = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_an_hei_mm_challenge_mode.dataList = dataList

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

return t_an_hei_mm_challenge_mode
