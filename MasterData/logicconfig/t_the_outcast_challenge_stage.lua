-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_the_outcast_challenge_stage.lua

module("logicconfig.config.t_the_outcast_challenge_stage", package.seeall)

local title = {
	creepsMasterId = 2,
	stageId = 1,
	stageName = 3
}
local dataList = {
	{
		1,
		1,
		"乾上"
	},
	{
		2,
		2,
		"乾中"
	},
	{
		3,
		3,
		"乾下"
	},
	{
		4,
		4,
		"巽上"
	},
	{
		5,
		5,
		"巽中"
	},
	{
		6,
		6,
		"巽下"
	},
	{
		7,
		7,
		"坎上"
	},
	{
		8,
		8,
		"坎中"
	},
	{
		9,
		9,
		"坎下"
	},
	{
		10,
		10,
		"艮上"
	},
	{
		11,
		11,
		"艮中"
	},
	{
		12,
		12,
		"艮下"
	},
	{
		13,
		13,
		"坤上"
	},
	{
		14,
		14,
		"坤中"
	},
	{
		15,
		15,
		"坤下"
	},
	{
		16,
		16,
		"震上"
	},
	{
		17,
		17,
		"震中"
	},
	{
		18,
		18,
		"震下"
	},
	{
		19,
		19,
		"離上"
	},
	{
		20,
		20,
		"離中"
	},
	{
		21,
		21,
		"離下"
	},
	{
		22,
		22,
		"兑上"
	},
	{
		23,
		23,
		"兑中"
	},
	{
		24,
		24,
		"兑下"
	}
}
local t_the_outcast_challenge_stage = {
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
	dataList[20],
	dataList[21],
	dataList[22],
	dataList[23],
	dataList[24]
}

t_the_outcast_challenge_stage.dataList = dataList

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

return t_the_outcast_challenge_stage
