-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mixixi_challenge_buff.lua

module("logicconfig.config.t_mixixi_challenge_buff", package.seeall)

local title = {
	desc = 3,
	buffPlanId = 1,
	level = 2
}
local dataList = {
	{
		1,
		1,
		"生命+<color=#20b376>10%</color>\n全属性+<color=#20b376>10%</color>"
	},
	{
		1,
		2,
		"生命+<color=#20b376>20%</color>\n全属性+<color=#20b376>20%</color>"
	},
	{
		1,
		3,
		"生命+<color=#20b376>30%</color>\n全属性+<color=#20b376>30%</color>"
	},
	{
		1,
		4,
		"生命+<color=#20b376>40%</color>\n全属性+<color=#20b376>40%</color>"
	},
	{
		1,
		5,
		"生命+<color=#20b376>50%</color>\n全属性+<color=#20b376>50%</color>"
	},
	{
		1,
		6,
		"生命+<color=#20b376>60%</color>\n全属性+<color=#20b376>60%</color>"
	},
	{
		1,
		7,
		"生命+<color=#20b376>70%</color>\n全属性+<color=#20b376>70%</color>"
	},
	{
		1,
		8,
		"生命+<color=#20b376>100%</color>\n全属性+<color=#20b376>100%</color>"
	},
	{
		1,
		9,
		"生命+<color=#20b376>150%</color>\n全属性+<color=#20b376>150%</color>"
	},
	{
		1,
		10,
		"生命+<color=#20b376>200%</color>\n全属性+<color=#20b376>200%</color>"
	},
	{
		1,
		11,
		"生命+<color=#20b376>250%</color>\n全属性+<color=#20b376>250%</color>"
	},
	{
		1,
		12,
		"生命+<color=#20b376>300%</color>\n全属性+<color=#20b376>300%</color>"
	},
	{
		1,
		13,
		"生命+<color=#20b376>350%</color>\n全属性+<color=#20b376>350%</color>"
	},
	{
		1,
		14,
		"生命+<color=#20b376>400%</color>\n全属性+<color=#20b376>400%</color>"
	},
	{
		2,
		1,
		"生命+<color=#20b376>10%</color>\n全属性+<color=#20b376>10%</color>"
	},
	{
		2,
		2,
		"生命+<color=#20b376>20%</color>\n全属性+<color=#20b376>20%</color>"
	},
	{
		2,
		3,
		"生命+<color=#20b376>30%</color>\n全属性+<color=#20b376>30%</color>"
	},
	{
		2,
		4,
		"生命+<color=#20b376>50%</color>\n全属性+<color=#20b376>50%</color>"
	},
	{
		2,
		5,
		"生命+<color=#20b376>100%</color>\n全属性+<color=#20b376>100%</color>"
	},
	{
		2,
		6,
		"生命+<color=#20b376>150%</color>\n全属性+<color=#20b376>150%</color>"
	},
	{
		2,
		7,
		"生命+<color=#20b376>200%</color>\n全属性+<color=#20b376>200%</color>"
	},
	{
		2,
		8,
		"生命+<color=#20b376>250%</color>\n全属性+<color=#20b376>250%</color>"
	},
	{
		2,
		9,
		"生命+<color=#20b376>300%</color>\n全属性+<color=#20b376>300%</color>"
	},
	{
		2,
		10,
		"生命+<color=#20b376>400%</color>\n全属性+<color=#20b376>400%</color>"
	},
	{
		3,
		1,
		"生命+<color=#10b376>10%</color>\n全属性+<color=#10b376>10%</color>"
	},
	{
		3,
		2,
		"生命+<color=#50b376>30%</color>\n全属性+<color=#50b376>30%</color>"
	},
	{
		3,
		3,
		"生命+<color=#50b376>50%</color>\n全属性+<color=#50b376>50%</color>"
	},
	{
		3,
		4,
		"生命+<color=#20b376>100%</color>\n全属性+<color=#20b376>100%</color>"
	},
	{
		3,
		5,
		"生命+<color=#20b376>200%</color>\n全属性+<color=#20b376>200%</color>"
	},
	{
		3,
		6,
		"生命+<color=#20b376>400%</color>\n全属性+<color=#20b376>400%</color>"
	},
	{
		3,
		7,
		"生命+<color=#20b376>600%</color>\n全属性+<color=#20b376>600%</color>"
	},
	{
		3,
		8,
		"生命+<color=#20b376>800%</color>\n全属性+<color=#20b376>800%</color>"
	}
}
local t_mixixi_challenge_buff = {
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
		dataList[14]
	},
	{
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
	},
	{
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30],
		dataList[31],
		dataList[32]
	}
}

t_mixixi_challenge_buff.dataList = dataList

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

return t_mixixi_challenge_buff
