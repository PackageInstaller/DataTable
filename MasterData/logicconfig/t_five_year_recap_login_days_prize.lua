-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_five_year_recap_login_days_prize.lua

module("logicconfig.config.t_five_year_recap_login_days_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	actName = 6,
	skinId = 5,
	activityId = 1,
	loginDays = 3
}
local dataList = {
	{
		586001,
		1,
		1,
		"104:2:68#4:31:10#8:1:680000",
		10145,
		"开服·启程"
	},
	{
		586001,
		2,
		50,
		"4:400004:10#104:2:88#4:36:10#8:1:880000",
		10343,
		"梦之队归来"
	},
	{
		586001,
		3,
		100,
		"4:400004:10#104:2:188#4:90312:1#8:1:1880000",
		0,
		""
	},
	{
		586001,
		4,
		300,
		"4:400004:10#4:109:1#104:2:365#4:90312:1#8:1:3650000",
		16009,
		"一周年庆典"
	},
	{
		586001,
		5,
		500,
		"4:400004:15#8:25:600#4:109:1#104:2:488#4:90145:1#8:1:4880000",
		0,
		""
	},
	{
		586001,
		6,
		700,
		"4:90037:1#4:400004:20#8:25:600#4:147:1#104:2:730#8:1:7300000",
		14013,
		"二周年庆典"
	},
	{
		586001,
		7,
		1000,
		"2:302:1#4:400004:25#4:7008:100#4:12101:5#4:147:1#104:2:888#8:1:8880000",
		12020,
		"三周年庆典"
	},
	{
		586001,
		8,
		1300,
		"2:303:1#4:400004:50#8:25:1200#4:510718:1#4:147:1#4:510243:5#104:2:1460#8:1:14600000",
		15032,
		"四周年庆典"
	},
	{
		586001,
		9,
		1500,
		"2:304:1#4:410002:1#4:438:1#4:30006:200#104:2:1825#8:1:18250000",
		17027,
		"五周年庆典"
	}
}
local t_five_year_recap_login_days_prize = {
	[586001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_five_year_recap_login_days_prize.dataList = dataList

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

return t_five_year_recap_login_days_prize
