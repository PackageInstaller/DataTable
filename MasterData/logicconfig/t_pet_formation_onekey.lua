-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_formation_onekey.lua

module("logicconfig.config.t_pet_formation_onekey", package.seeall)

local title = {
	p7 = 9,
	p6 = 8,
	p3 = 5,
	pos = 2,
	p2 = 4,
	p8 = 10,
	p5 = 7,
	p4 = 6,
	p1 = 3,
	attr = 1
}
local dataList = {
	{
		"水",
		"前排",
		1.2,
		0.77,
		1.05,
		0,
		0,
		1.3,
		0.7,
		0
	},
	{
		"火",
		"前排",
		1.2,
		0.7,
		1.05,
		0,
		0,
		1.3,
		0.7,
		0
	},
	{
		"草",
		"前排",
		1.3,
		0.77,
		1.05,
		0,
		0,
		1.3,
		0.7,
		0
	},
	{
		"光",
		"前排",
		1,
		1,
		1.05,
		0,
		0,
		1.3,
		0.7,
		0
	},
	{
		"暗",
		"前排",
		1,
		1,
		1.05,
		0,
		0,
		1.3,
		0.7,
		0
	},
	{
		"空",
		"前排",
		1.3,
		0.7,
		1.05,
		0,
		0,
		1.3,
		0.7,
		0
	},
	{
		"创",
		"前排",
		1.3,
		0.7,
		1.05,
		0,
		0,
		1.3,
		0.7,
		0
	},
	{
		"源",
		"前排",
		1.3,
		0.7,
		1.05,
		0,
		0,
		1.3,
		0.7,
		0
	},
	{
		"水",
		"后排",
		1.4,
		0.7,
		1,
		1.3,
		1.25,
		1.3,
		0.7,
		1
	},
	{
		"火",
		"后排",
		1.2,
		0.9,
		1,
		1.3,
		1.25,
		1.3,
		0.7,
		1
	},
	{
		"草",
		"后排",
		1.2,
		0.9,
		1,
		1.3,
		1.25,
		1.3,
		0.7,
		1
	},
	{
		"光",
		"后排",
		1.1,
		1.1,
		1.05,
		1.3,
		1.25,
		1.3,
		0.7,
		1
	},
	{
		"暗",
		"后排",
		1.1,
		1.1,
		1.05,
		1.3,
		1.25,
		1.3,
		0.7,
		1
	},
	{
		"空",
		"后排",
		1.1,
		1.1,
		1.05,
		1.3,
		1.25,
		1.3,
		0.7,
		1
	},
	{
		"创",
		"后排",
		1.1,
		1.1,
		1.05,
		1.3,
		1.25,
		1.3,
		0.7,
		1
	},
	{
		"源",
		"后排",
		1.1,
		1.1,
		1.05,
		1.3,
		1.25,
		1.3,
		0.7,
		1
	}
}
local t_pet_formation_onekey = {
	水 = {
		前排 = dataList[1],
		后排 = dataList[9]
	},
	火 = {
		前排 = dataList[2],
		后排 = dataList[10]
	},
	草 = {
		前排 = dataList[3],
		后排 = dataList[11]
	},
	光 = {
		前排 = dataList[4],
		后排 = dataList[12]
	},
	暗 = {
		前排 = dataList[5],
		后排 = dataList[13]
	},
	空 = {
		前排 = dataList[6],
		后排 = dataList[14]
	},
	创 = {
		前排 = dataList[7],
		后排 = dataList[15]
	},
	源 = {
		前排 = dataList[8],
		后排 = dataList[16]
	}
}

t_pet_formation_onekey.dataList = dataList

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

return t_pet_formation_onekey
