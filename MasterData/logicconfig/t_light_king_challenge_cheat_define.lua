-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_light_king_challenge_cheat_define.lua

module("logicconfig.config.t_light_king_challenge_cheat_define", package.seeall)

local title = {
	challengeType = 1,
	stage = 2,
	name = 3,
	consume = 4
}
local dataList = {
	{
		1,
		1,
		"圣光第1关",
		"105:172:30"
	},
	{
		1,
		2,
		"圣光第2关",
		"105:172:30"
	},
	{
		1,
		3,
		"圣光第3关",
		"105:172:30"
	},
	{
		1,
		4,
		"圣光第4关",
		"105:172:30"
	},
	{
		1,
		5,
		"圣光第5关",
		"105:172:30"
	},
	{
		1,
		6,
		"圣光第6关",
		"105:172:30"
	},
	{
		1,
		7,
		"圣光第7关",
		"105:172:30"
	},
	{
		1,
		8,
		"圣光第8关",
		"105:172:30"
	},
	{
		1,
		9,
		"圣光第9关",
		"105:172:30"
	},
	{
		1,
		10,
		"圣光第10关",
		"105:172:30"
	},
	{
		1,
		11,
		"圣光第11关",
		"105:172:30"
	},
	{
		1,
		12,
		"圣光第12关",
		"105:172:30"
	},
	{
		1,
		13,
		"圣光第13关",
		"105:172:30"
	},
	{
		1,
		14,
		"圣光第14关",
		"105:172:30"
	},
	{
		1,
		15,
		"圣光第15关",
		"105:172:30"
	},
	{
		1,
		16,
		"圣光第16关",
		"105:172:30"
	},
	{
		1,
		17,
		"圣光第17关",
		"105:172:30"
	},
	{
		1,
		18,
		"圣光第18关",
		"105:172:30"
	},
	{
		1,
		19,
		"圣光第19关",
		"105:172:30"
	},
	{
		1,
		20,
		"圣光第20关",
		"105:172:30"
	}
}
local t_light_king_challenge_cheat_define = {
	{
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
}

t_light_king_challenge_cheat_define.dataList = dataList

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

return t_light_king_challenge_cheat_define
