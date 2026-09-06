-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_assistance_box_prize.lua

module("logicconfig.config.t_assistance_box_prize", package.seeall)

local title = {
	prizeId = 1,
	seniorBoxId = 4,
	boxId = 3,
	level = 2
}
local dataList = {
	{
		1,
		1,
		25,
		26
	},
	{
		2,
		2,
		23,
		24
	},
	{
		3,
		3,
		21,
		22
	},
	{
		4,
		4,
		19,
		20
	},
	{
		5,
		5,
		17,
		18
	},
	{
		6,
		6,
		15,
		16
	},
	{
		7,
		7,
		13,
		14
	},
	{
		8,
		8,
		11,
		12
	},
	{
		9,
		9,
		9,
		10
	},
	{
		10,
		10,
		7,
		8
	},
	{
		11,
		11,
		5,
		6
	},
	{
		12,
		12,
		3,
		4
	},
	{
		13,
		13,
		1,
		2
	}
}
local t_assistance_box_prize = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13]
}

t_assistance_box_prize.dataList = dataList

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

return t_assistance_box_prize
