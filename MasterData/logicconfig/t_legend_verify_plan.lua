-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_legend_verify_plan.lua

module("logicconfig.config.t_legend_verify_plan", package.seeall)

local title = {
	validator = 2,
	buffPlanId = 4,
	planId = 1,
	type = 3
}
local dataList = {
	{
		1,
		"10177,10337,10082",
		"星级",
		1
	},
	{
		2,
		"10175,10335,10084",
		"星级",
		2
	},
	{
		3,
		"10347,10159,10083",
		"星级",
		3
	},
	{
		4,
		"10319,10086,10348",
		"星级",
		4
	},
	{
		5,
		"10172,10085,10349",
		"星级",
		5
	},
	{
		6,
		"10005,10031,10036",
		"星级",
		6
	},
	{
		7,
		"10006,10030,10034",
		"星级",
		7
	},
	{
		8,
		"10004,10032,10033",
		"星级",
		8
	},
	{
		9,
		"10037,10348,10035",
		"星级",
		9
	},
	{
		10,
		"10346,10349,10048",
		"星级",
		10
	},
	{
		11,
		"10319,10086,10348,10205",
		"星级",
		11
	},
	{
		15,
		"10143,10309,10082,10204",
		"星级",
		15
	},
	{
		19,
		"10172,10085,10349,10206",
		"星级",
		19
	},
	{
		25,
		"10005,10031,10036",
		"星级",
		25
	},
	{
		26,
		"10004,10032,10033",
		"星级",
		26
	},
	{
		32,
		"10005,10031,10036",
		"星级",
		32
	},
	{
		33,
		"10177,10337,10082,10204",
		"星级",
		33
	},
	{
		37,
		"10006,10030,10034",
		"星级",
		37
	},
	{
		38,
		"10006,10030,10034",
		"星级",
		38
	},
	{
		39,
		"10347,10159,10083,10202",
		"星级",
		39
	},
	{
		43,
		"10004,10032,10033",
		"星级",
		43
	},
	{
		44,
		"10175,10335,10084,10203",
		"星级",
		44
	},
	{
		48,
		"10346,10349,10048",
		"星级",
		48
	},
	{
		52,
		"10037,10348,10035",
		"星级",
		52
	},
	{
		53,
		"10143,10309,10082,10204",
		"星级",
		53
	}
}
local t_legend_verify_plan = {
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
	[19] = dataList[13],
	[25] = dataList[14],
	[26] = dataList[15],
	[32] = dataList[16],
	[33] = dataList[17],
	[37] = dataList[18],
	[38] = dataList[19],
	[39] = dataList[20],
	[43] = dataList[21],
	[44] = dataList[22],
	[48] = dataList[23],
	[52] = dataList[24],
	[53] = dataList[25]
}

t_legend_verify_plan.dataList = dataList

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

return t_legend_verify_plan
