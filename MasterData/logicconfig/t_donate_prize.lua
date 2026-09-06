-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_donate_prize.lua

module("logicconfig.config.t_donate_prize", package.seeall)

local title = {
	poolFullTimes = 2,
	familyLevel = 1,
	prize = 3
}
local dataList = {
	{
		1,
		1,
		"4:602:1"
	},
	{
		1,
		2,
		"8:8:1000"
	},
	{
		1,
		3,
		"9:3000:5"
	},
	{
		1,
		4,
		"4:601:2"
	},
	{
		1,
		5,
		"4:41002:1"
	},
	{
		1,
		6,
		"104:2:50"
	},
	{
		2,
		1,
		"4:602:1"
	},
	{
		2,
		2,
		"8:8:1000"
	},
	{
		2,
		3,
		"9:3000:5"
	},
	{
		2,
		4,
		"4:601:2"
	},
	{
		2,
		5,
		"4:41002:1"
	},
	{
		2,
		6,
		"104:2:50"
	},
	{
		3,
		1,
		"4:602:1"
	},
	{
		3,
		2,
		"8:8:1000"
	},
	{
		3,
		3,
		"9:3000:5"
	},
	{
		3,
		4,
		"4:601:2"
	},
	{
		3,
		5,
		"4:41002:1"
	},
	{
		3,
		6,
		"104:2:50"
	},
	{
		4,
		1,
		"4:602:1"
	},
	{
		4,
		2,
		"8:8:1000"
	},
	{
		4,
		3,
		"9:3000:5"
	},
	{
		4,
		4,
		"4:601:2"
	},
	{
		4,
		5,
		"4:41002:1"
	},
	{
		4,
		6,
		"104:2:50"
	},
	{
		5,
		1,
		"4:602:1"
	},
	{
		5,
		2,
		"8:8:1000"
	},
	{
		5,
		3,
		"9:3000:5"
	},
	{
		5,
		4,
		"4:601:2"
	},
	{
		5,
		5,
		"4:41002:1"
	},
	{
		5,
		6,
		"104:2:50"
	}
}
local t_donate_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	},
	{
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24]
	},
	{
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30]
	}
}

t_donate_prize.dataList = dataList

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

return t_donate_prize
