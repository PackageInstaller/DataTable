-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_psychic_clg_universal_stage.lua

module("logicconfig.config.t_dragon_psychic_clg_universal_stage", package.seeall)

local title = {
	stageId = 2,
	name = 3,
	prize = 5,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		351001,
		1,
		"第一关",
		201,
		"4:230:5"
	},
	{
		351001,
		2,
		"第二关",
		202,
		"8:1:1000000"
	},
	{
		351001,
		3,
		"第三关",
		203,
		"4:30006:10"
	},
	{
		351001,
		4,
		"第四关",
		204,
		"4:230:5"
	},
	{
		351001,
		5,
		"第五关",
		205,
		"4:30006:10"
	},
	{
		351001,
		6,
		"第六关",
		206,
		"4:90316:1"
	},
	{
		351001,
		7,
		"第七关",
		207,
		"4:230:5"
	},
	{
		351001,
		8,
		"第八关",
		208,
		"4:30006:10"
	},
	{
		351001,
		9,
		"第九关",
		209,
		"4:30006:10"
	},
	{
		351001,
		10,
		"第十关",
		210,
		"4:230:5"
	},
	{
		351002,
		1,
		"第一关",
		201,
		"8:1:1"
	},
	{
		351002,
		2,
		"第二关",
		202,
		"8:1:1"
	},
	{
		351002,
		3,
		"第三关",
		203,
		"8:1:1"
	},
	{
		351002,
		4,
		"第四关",
		204,
		"8:1:1"
	},
	{
		351002,
		5,
		"第五关",
		205,
		"8:1:1"
	},
	{
		351002,
		6,
		"第六关",
		206,
		"8:1:1"
	},
	{
		351002,
		7,
		"第七关",
		207,
		"8:1:1"
	},
	{
		351002,
		8,
		"第八关",
		208,
		"8:1:1"
	},
	{
		351002,
		9,
		"第九关",
		209,
		"8:1:1"
	},
	{
		351002,
		10,
		"第十关",
		210,
		"8:1:1"
	}
}
local t_dragon_psychic_clg_universal_stage = {
	[351001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[351002] = {
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

t_dragon_psychic_clg_universal_stage.dataList = dataList

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

return t_dragon_psychic_clg_universal_stage
