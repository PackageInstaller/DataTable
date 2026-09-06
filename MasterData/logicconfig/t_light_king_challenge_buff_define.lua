-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_light_king_challenge_buff_define.lua

module("logicconfig.config.t_light_king_challenge_buff_define", package.seeall)

local title = {
	challengeType = 2,
	des = 4,
	selfBuff = 3,
	level = 1
}
local dataList = {
	{
		1,
		{
			1,
			3
		},
		"50042:99#50072:99",
		"己阵全属性+<color=#%s>10%</color>"
	},
	{
		2,
		{
			1,
			3
		},
		"50043:99#50073:99",
		"己阵全属性+<color=#%s>20%</color>"
	},
	{
		3,
		{
			1,
			3
		},
		"50044:99#50074:99",
		"己阵全属性+<color=#%s>30%</color>"
	},
	{
		4,
		{
			1,
			3
		},
		"50045:99#50075:99",
		"己阵全属性+<color=#%s>40%</color>"
	},
	{
		5,
		{
			1,
			3
		},
		"50046:99#50076:99",
		"己阵全属性+<color=#%s>50%</color>"
	},
	{
		6,
		{
			1,
			3
		},
		"50047:99#50077:99",
		"己阵全属性+<color=#%s>60%</color>"
	},
	{
		7,
		{
			1,
			3
		},
		"50048:99#50078:99",
		"己阵全属性+<color=#%s>70%</color>"
	},
	{
		8,
		{
			1,
			3
		},
		"50049:99#50079:99",
		"己阵全属性+<color=#%s>80%</color>"
	},
	{
		9,
		{
			1,
			3
		},
		"50050:99#50080:99",
		"己阵全属性+<color=#%s>90%</color>"
	},
	{
		10,
		{
			1,
			3
		},
		"50051:99#50081:99",
		"己阵全属性+<color=#%s>100%</color>"
	},
	{
		11,
		{
			1,
			3
		},
		"50052:99#50082:99",
		"己阵全属性+<color=#%s>110%</color>"
	},
	{
		12,
		{
			1,
			3
		},
		"50053:99#50083:99",
		"己阵全属性+<color=#%s>120%</color>"
	},
	{
		13,
		{
			1,
			3
		},
		"50054:99#50084:99",
		"己阵全属性+<color=#%s>130%</color>"
	},
	{
		14,
		{
			1,
			3
		},
		"50055:99#50085:99",
		"己阵全属性+<color=#%s>140%</color>"
	},
	{
		15,
		{
			1,
			3
		},
		"50056:99#50086:99",
		"己阵全属性+<color=#%s>150%</color>"
	},
	{
		16,
		{
			1,
			3
		},
		"50057:99#50087:99",
		"己阵全属性+<color=#%s>160%</color>"
	},
	{
		17,
		{
			1,
			3
		},
		"50058:99#50088:99",
		"己阵全属性+<color=#%s>170%</color>"
	},
	{
		18,
		{
			1,
			3
		},
		"50059:99#50089:99",
		"己阵全属性+<color=#%s>180%</color>"
	},
	{
		19,
		{
			1,
			3
		},
		"50060:99#50090:99",
		"己阵全属性+<color=#%s>190%</color>"
	},
	{
		20,
		{
			1,
			3
		},
		"50061:99#50091:99",
		"己阵全属性+<color=#%s>200%</color>"
	}
}
local t_light_king_challenge_buff_define = {
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

t_light_king_challenge_buff_define.dataList = dataList

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

return t_light_king_challenge_buff_define
