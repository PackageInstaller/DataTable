-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dumpling_feast_intimacy.lua

module("logicconfig.config.t_dumpling_feast_intimacy", package.seeall)

local title = {
	name = 3,
	intimacy = 2,
	buffPlanId = 1,
	desc = 4
}
local dataList = {
	{
		1,
		100,
		"伤害提升",
		"伤害+10%"
	},
	{
		1,
		200,
		"伤害提升",
		"伤害+15%"
	},
	{
		1,
		300,
		"伤害提升",
		"伤害+20%"
	},
	{
		1,
		400,
		"伤害提升",
		"伤害+25%"
	},
	{
		1,
		500,
		"伤害提升",
		"伤害+30%"
	},
	{
		1,
		600,
		"伤害提升",
		"伤害+50%"
	},
	{
		2,
		100,
		"攻击",
		"攻击力+10%"
	},
	{
		2,
		200,
		"攻击",
		"攻击力+15%"
	},
	{
		2,
		300,
		"攻击",
		"攻击力+20%"
	},
	{
		2,
		400,
		"攻击",
		"攻击力+25%"
	},
	{
		2,
		500,
		"攻击",
		"攻击力+30%"
	},
	{
		2,
		600,
		"攻击",
		"攻击力+50%"
	},
	{
		3,
		100,
		"格挡",
		"格挡率+10%"
	},
	{
		3,
		200,
		"格挡",
		"格挡率+15%"
	},
	{
		3,
		300,
		"格挡",
		"格挡率+20%"
	},
	{
		3,
		400,
		"格挡",
		"格挡率+25%"
	},
	{
		3,
		500,
		"格挡",
		"格挡率+30%"
	},
	{
		3,
		600,
		"格挡",
		"格挡率+50%"
	},
	{
		4,
		100,
		"破击",
		"破击率+10%"
	},
	{
		4,
		200,
		"破击",
		"破击率+15%"
	},
	{
		4,
		300,
		"破击",
		"破击率+20%"
	},
	{
		4,
		400,
		"破击",
		"破击率+25%"
	},
	{
		4,
		500,
		"破击",
		"破击率+30%"
	},
	{
		4,
		600,
		"破击",
		"破击率+50%"
	},
	{
		5,
		100,
		"暴击",
		"暴击率+10%"
	},
	{
		5,
		200,
		"暴击",
		"暴击率+15%"
	},
	{
		5,
		300,
		"暴击",
		"暴击率+20%"
	},
	{
		5,
		400,
		"暴击",
		"暴击率+25%"
	},
	{
		5,
		500,
		"暴击",
		"暴击率+30%"
	},
	{
		5,
		600,
		"暴击",
		"暴击率+50%"
	},
	{
		6,
		100,
		"防御",
		"防御+10%"
	},
	{
		6,
		200,
		"防御",
		"防御+15%"
	},
	{
		6,
		300,
		"防御",
		"防御+20%"
	},
	{
		6,
		400,
		"防御",
		"防御+25%"
	},
	{
		6,
		500,
		"防御",
		"防御+30%"
	},
	{
		6,
		600,
		"防御",
		"防御+50%"
	},
	{
		7,
		100,
		"生命",
		"生命及生命上限+10%"
	},
	{
		7,
		200,
		"生命",
		"生命及生命上限+15%"
	},
	{
		7,
		300,
		"生命",
		"生命及生命上限+20%"
	},
	{
		7,
		400,
		"生命",
		"生命及生命上限+25%"
	},
	{
		7,
		500,
		"生命",
		"生命及生命上限+30%"
	},
	{
		7,
		600,
		"生命",
		"生命及生命上限+50%"
	}
}
local t_dumpling_feast_intimacy = {
	{
		[100] = dataList[1],
		[200] = dataList[2],
		[300] = dataList[3],
		[400] = dataList[4],
		[500] = dataList[5],
		[600] = dataList[6]
	},
	{
		[100] = dataList[7],
		[200] = dataList[8],
		[300] = dataList[9],
		[400] = dataList[10],
		[500] = dataList[11],
		[600] = dataList[12]
	},
	{
		[100] = dataList[13],
		[200] = dataList[14],
		[300] = dataList[15],
		[400] = dataList[16],
		[500] = dataList[17],
		[600] = dataList[18]
	},
	{
		[100] = dataList[19],
		[200] = dataList[20],
		[300] = dataList[21],
		[400] = dataList[22],
		[500] = dataList[23],
		[600] = dataList[24]
	},
	{
		[100] = dataList[25],
		[200] = dataList[26],
		[300] = dataList[27],
		[400] = dataList[28],
		[500] = dataList[29],
		[600] = dataList[30]
	},
	{
		[100] = dataList[31],
		[200] = dataList[32],
		[300] = dataList[33],
		[400] = dataList[34],
		[500] = dataList[35],
		[600] = dataList[36]
	},
	{
		[100] = dataList[37],
		[200] = dataList[38],
		[300] = dataList[39],
		[400] = dataList[40],
		[500] = dataList[41],
		[600] = dataList[42]
	}
}

t_dumpling_feast_intimacy.dataList = dataList

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

return t_dumpling_feast_intimacy
