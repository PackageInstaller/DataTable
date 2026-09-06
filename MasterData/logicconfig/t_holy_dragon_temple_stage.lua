-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dragon_temple_stage.lua

module("logicconfig.config.t_holy_dragon_temple_stage", package.seeall)

local title = {
	stageId = 3,
	ruleDesc = 9,
	floorId = 2,
	skinId = 4,
	targetDesc = 8,
	prize = 10,
	comboTimes = 6,
	circleNum = 7,
	creepsMasterId = 5,
	activityId = 1
}
local dataList = {
	{
		609001,
		1,
		1,
		16033,
		2001,
		0,
		4,
		82057648,
		82057649,
		"10:605001:200"
	},
	{
		609001,
		1,
		2,
		14026,
		2002,
		0,
		4,
		82057648,
		82057649,
		"10:605001:200"
	},
	{
		609001,
		1,
		3,
		16035,
		2003,
		0,
		4,
		82057648,
		82057649,
		"10:605001:200"
	},
	{
		609001,
		1,
		4,
		12028,
		2004,
		0,
		4,
		82057648,
		82057649,
		"10:605001:200"
	},
	{
		609001,
		1,
		5,
		11030,
		2005,
		0,
		4,
		82057648,
		82057649,
		"10:605001:200"
	},
	{
		609001,
		1,
		6,
		12031,
		2006,
		0,
		4,
		82057648,
		82057649,
		"10:605001:200"
	},
	{
		609001,
		1,
		7,
		12036,
		2007,
		0,
		4,
		82057648,
		82057649,
		"10:605001:200"
	},
	{
		609001,
		1,
		8,
		14032,
		2008,
		0,
		4,
		82057648,
		82057649,
		"10:605001:200"
	},
	{
		609001,
		2,
		1,
		17020,
		1001,
		6,
		0,
		82057650,
		82057651,
		"10:605001:200"
	},
	{
		609001,
		2,
		2,
		14013,
		1002,
		6,
		0,
		82057650,
		82057651,
		"10:605001:200"
	},
	{
		609001,
		2,
		3,
		13014,
		1003,
		7,
		0,
		82057652,
		82057651,
		"10:605001:200"
	},
	{
		609001,
		2,
		4,
		16028,
		1004,
		8,
		0,
		82057653,
		82057651,
		"10:605001:200"
	},
	{
		609001,
		2,
		5,
		14026,
		1005,
		9,
		0,
		82057654,
		82057651,
		"10:605001:200"
	},
	{
		609001,
		2,
		6,
		11020,
		1006,
		10,
		0,
		82057655,
		82057651,
		"10:605001:200"
	},
	{
		609001,
		2,
		7,
		15027,
		1007,
		10,
		0,
		82057655,
		82057651,
		"10:605001:200"
	},
	{
		609001,
		2,
		8,
		14029,
		1008,
		10,
		0,
		82057655,
		82057651,
		"10:605001:200"
	},
	{
		609001,
		3,
		1,
		14022,
		3001,
		0,
		0,
		82057656,
		82057657,
		"10:605001:200"
	},
	{
		609001,
		3,
		2,
		14023,
		3002,
		0,
		0,
		82057656,
		82057657,
		"10:605001:200"
	},
	{
		609001,
		3,
		3,
		14031,
		3003,
		0,
		0,
		82057656,
		82057657,
		"10:605001:200"
	},
	{
		609001,
		3,
		4,
		14013,
		3004,
		0,
		0,
		82057656,
		82057657,
		"10:605001:200"
	},
	{
		609001,
		3,
		5,
		14016,
		3005,
		0,
		0,
		82057656,
		82057657,
		"10:605001:200"
	},
	{
		609001,
		3,
		6,
		14046,
		3006,
		0,
		0,
		82057656,
		82057657,
		"10:605001:200"
	},
	{
		609001,
		3,
		7,
		14049,
		3007,
		0,
		0,
		82057656,
		82057657,
		"10:605001:200"
	},
	{
		609001,
		3,
		8,
		14045,
		3008,
		0,
		0,
		82057656,
		82057657,
		"10:605001:200"
	}
}
local t_holy_dragon_temple_stage = {
	[609001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8]
		},
		{
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16]
		},
		{
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
}

t_holy_dragon_temple_stage.dataList = dataList

local multiLanguageCells = {
	targetDesc = true,
	ruleDesc = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_holy_dragon_temple_stage
