-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_verify_plan.lua

module("logicconfig.config.t_verify_plan", package.seeall)

local title = {
	buffPlanId = 4,
	type = 3,
	validator = 2,
	planId = 1,
	typeShow = 5
}
local dataList = {
	{
		1,
		"10177,10337,10082",
		"星级",
		1,
		"觉醒等级"
	},
	{
		2,
		"10175,10335,10084",
		"星级",
		2,
		"觉醒等级"
	},
	{
		3,
		"10347,10159,10083",
		"星级",
		3,
		"觉醒等级"
	},
	{
		4,
		"10319,10086,10348",
		"星级",
		4,
		"觉醒等级"
	},
	{
		5,
		"10172,10085,10349",
		"星级",
		5,
		"觉醒等级"
	},
	{
		6,
		"10005,10031,10036",
		"星级",
		6,
		"觉醒等级"
	},
	{
		7,
		"10006,10030,10034",
		"星级",
		7,
		"觉醒等级"
	},
	{
		8,
		"10004,10032,10033",
		"星级",
		8,
		"觉醒等级"
	},
	{
		9,
		"10037,10348,10035",
		"星级",
		9,
		"觉醒等级"
	},
	{
		10,
		"10346,10349,10048",
		"星级",
		10,
		"觉醒等级"
	},
	{
		11,
		"10319,10086,10348,10205",
		"星级",
		11,
		"觉醒等级"
	},
	{
		15,
		"10309",
		"星级",
		15,
		"觉醒等级"
	},
	{
		16,
		"10147",
		"星级",
		16,
		"觉醒等级"
	},
	{
		17,
		"10100",
		"星级",
		17,
		"觉醒等级"
	},
	{
		18,
		"10167",
		"星级",
		18,
		"觉醒等级"
	},
	{
		19,
		"10172,10085,10349,10206",
		"星级",
		19,
		"觉醒等级"
	},
	{
		22,
		"10145",
		"星级",
		22,
		"觉醒等级"
	},
	{
		25,
		"10005,10031,10036",
		"星级",
		25,
		"觉醒等级"
	},
	{
		26,
		"10004,10032,10033",
		"星级",
		26,
		"觉醒等级"
	},
	{
		32,
		"10005,10031,10036",
		"星级",
		32,
		"觉醒等级"
	},
	{
		33,
		"10177,10337,10082,10204",
		"星级",
		33,
		"觉醒等级"
	},
	{
		37,
		"10006,10030,10034",
		"星级",
		37,
		"觉醒等级"
	},
	{
		38,
		"10006,10030,10034",
		"星级",
		38,
		"觉醒等级"
	},
	{
		39,
		"10347,10159,10083,10202",
		"星级",
		39,
		"觉醒等级"
	},
	{
		43,
		"10004,10032,10033",
		"星级",
		43,
		"觉醒等级"
	},
	{
		44,
		"10175,10335,10084,10203",
		"星级",
		44,
		"觉醒等级"
	},
	{
		48,
		"10346,10349,10048",
		"星级",
		48,
		"觉醒等级"
	},
	{
		52,
		"10037,10348,10035",
		"星级",
		52,
		"觉醒等级"
	},
	{
		53,
		"10143,10309,10082,10204",
		"星级",
		53,
		"觉醒等级"
	},
	{
		54,
		"13009",
		"星级",
		54,
		"觉醒等级"
	},
	{
		55,
		"14014",
		"星级",
		55,
		"觉醒等级"
	}
}
local t_verify_plan = {
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
	[15] = dataList[12],
	[16] = dataList[13],
	[17] = dataList[14],
	[18] = dataList[15],
	[19] = dataList[16],
	[22] = dataList[17],
	[25] = dataList[18],
	[26] = dataList[19],
	[32] = dataList[20],
	[33] = dataList[21],
	[37] = dataList[22],
	[38] = dataList[23],
	[39] = dataList[24],
	[43] = dataList[25],
	[44] = dataList[26],
	[48] = dataList[27],
	[52] = dataList[28],
	[53] = dataList[29],
	[54] = dataList[30],
	[55] = dataList[31]
}

t_verify_plan.dataList = dataList

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

return t_verify_plan
