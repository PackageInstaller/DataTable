-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cynthia_challenge_buff_define.lua

module("logicconfig.config.t_cynthia_challenge_buff_define", package.seeall)

local title = {
	challengeId = 1,
	des = 4,
	selfBuff = 3,
	level = 2
}
local dataList = {
	{
		17,
		1,
		"50042:99#50072:99",
		"己阵全属性+<color=#20b376>10%</color>"
	},
	{
		17,
		2,
		"50043:99#50073:99",
		"己阵全属性+<color=#20b376>20%</color>"
	},
	{
		17,
		3,
		"50044:99#50074:99",
		"己阵全属性+<color=#20b376>30%</color>"
	},
	{
		17,
		4,
		"50045:99#50075:99",
		"己阵全属性+<color=#20b376>40%</color>"
	},
	{
		17,
		5,
		"50046:99#50076:99",
		"己阵全属性+<color=#20b376>50%</color>"
	},
	{
		17,
		6,
		"50047:99#50077:99",
		"己阵全属性+<color=#20b376>60%</color>"
	},
	{
		17,
		7,
		"50048:99#50078:99",
		"己阵全属性+<color=#20b376>70%</color>"
	},
	{
		17,
		8,
		"50049:99#50079:99",
		"己阵全属性+<color=#20b376>80%</color>"
	},
	{
		17,
		9,
		"50050:99#50080:99",
		"己阵全属性+<color=#20b376>90%</color>"
	},
	{
		17,
		10,
		"50051:99#50081:99",
		"己阵全属性+<color=#20b376>100%</color>"
	},
	{
		17,
		11,
		"50052:99#50082:99",
		"己阵全属性+<color=#20b376>110%</color>"
	},
	{
		17,
		12,
		"50053:99#50083:99",
		"己阵全属性+<color=#20b376>120%</color>"
	},
	{
		17,
		13,
		"50054:99#50084:99",
		"己阵全属性+<color=#20b376>130%</color>"
	},
	{
		17,
		14,
		"50055:99#50085:99",
		"己阵全属性+<color=#20b376>140%</color>"
	},
	{
		177,
		1,
		"5218:99#5219:99",
		"全属性\n+10%"
	},
	{
		177,
		2,
		"5220:99#5221:99",
		"全属性\n+20%"
	},
	{
		177,
		3,
		"5222:99#5223:99",
		"全属性\n+40%"
	},
	{
		177,
		4,
		"5224:99#5225:99",
		"全属性\n+80%"
	},
	{
		177,
		5,
		"5236:99#5237:99",
		"全属性\n+120%"
	},
	{
		177,
		6,
		"20034231:99#20034232:99",
		"全属性\n+200%"
	},
	{
		177,
		7,
		"20046817:99#20046818:99",
		"全属性\n+300%"
	},
	{
		177,
		8,
		"20046819:99#20046820:99",
		"全属性\n+400%"
	},
	{
		177,
		9,
		"20054107:99#20054114:99",
		"全属性\n+600%"
	},
	{
		177,
		10,
		"20054115:99#20054116:99",
		"全属性\n+800%"
	}
}
local t_cynthia_challenge_buff_define = {
	[17] = {
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
		dataList[14]
	},
	[177] = {
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24]
	}
}

t_cynthia_challenge_buff_define.dataList = dataList

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

return t_cynthia_challenge_buff_define
