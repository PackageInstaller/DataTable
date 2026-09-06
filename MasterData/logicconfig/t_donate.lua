-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_donate.lua

module("logicconfig.config.t_donate", package.seeall)

local title = {
	donateResource = 2,
	donateValue = 3,
	contributeMp = 6,
	moneyValue = 7,
	contribution = 5,
	scoreValue = 4,
	times = 1
}
local dataList = {
	{
		1,
		"8:1:2000",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		50
	},
	{
		2,
		"8:1:2000",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		50
	},
	{
		3,
		"8:1:2000",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		50
	},
	{
		4,
		"8:1:2000",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		50
	},
	{
		5,
		"8:1:2000",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		50
	},
	{
		6,
		"105:136:20",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		100
	},
	{
		7,
		"105:136:20",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		100
	},
	{
		8,
		"105:136:20",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		100
	},
	{
		9,
		"105:136:40",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		100
	},
	{
		10,
		"105:136:40",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		100
	},
	{
		11,
		"105:136:40",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		200
	},
	{
		12,
		"105:136:60",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		200
	},
	{
		13,
		"105:136:60",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		200
	},
	{
		14,
		"105:136:60",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		200
	},
	{
		15,
		"105:136:80",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		200
	},
	{
		16,
		"105:136:80",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		500
	},
	{
		17,
		"105:136:80",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		500
	},
	{
		18,
		"105:136:100",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		500
	},
	{
		19,
		"105:136:100",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		500
	},
	{
		20,
		"105:136:100",
		100,
		100,
		50,
		"8:5:50#8:27:5",
		500
	}
}
local t_donate = {
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
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20]
}

t_donate.dataList = dataList

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

return t_donate
