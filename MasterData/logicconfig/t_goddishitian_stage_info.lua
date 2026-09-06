-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddishitian_stage_info.lua

module("logicconfig.config.t_goddishitian_stage_info", package.seeall)

local title = {
	description = 13,
	name = 3,
	scorePlanId = 6,
	skipTime = 8,
	heroSkillId = 11,
	formCondition = 7,
	selfBuffProviderId = 15,
	winId = 16,
	btlBg = 10,
	redPoint = 14,
	background = 9,
	btlType = 4,
	creepsMasterId = 2,
	stageType = 1,
	recommendZdl = 12,
	passLine = 5
}
local dataList = {
	{
		1,
		101,
		"星之挑战-1",
		1,
		1,
		3,
		0,
		15,
		"bg_shenqilongyan_03",
		"",
		"",
		1,
		"",
		1,
		0,
		0
	},
	{
		1,
		102,
		"星之挑战-2",
		1,
		1,
		3,
		0,
		15,
		"bg_shenqilongyan_03",
		"",
		"",
		1,
		"",
		1,
		0,
		0
	},
	{
		1,
		103,
		"星之挑战-3",
		1,
		1,
		3,
		0,
		15,
		"bg_shenqilongyan_03",
		"",
		"",
		1,
		"",
		1,
		0,
		0
	},
	{
		1,
		104,
		"星之挑战-4",
		1,
		1,
		3,
		0,
		15,
		"bg_shenqilongyan_03",
		"",
		"",
		1,
		"",
		1,
		0,
		0
	},
	{
		2,
		201,
		"月之挑战-1",
		1,
		1,
		1,
		0,
		15,
		"bg_shenqilongyan_03",
		"",
		"",
		1,
		"",
		1,
		28,
		0
	},
	{
		2,
		202,
		"月之挑战-2",
		1,
		1,
		1,
		0,
		15,
		"bg_shenqilongyan_03_1",
		"",
		"",
		1,
		"",
		1,
		28,
		0
	},
	{
		2,
		203,
		"月之挑战-3",
		1,
		1,
		1,
		0,
		15,
		"bg_shenqilongyan_03_1",
		"",
		"",
		1,
		"",
		1,
		28,
		0
	},
	{
		2,
		204,
		"月之挑战-4",
		1,
		1,
		1,
		0,
		15,
		"bg_shenqilongyan_03_1",
		"",
		"",
		1,
		"",
		1,
		28,
		0
	},
	{
		3,
		301,
		"夜之挑战-1",
		1,
		1,
		2,
		0,
		15,
		"bg_shenqilongyan_03_1",
		"",
		"",
		1,
		"",
		1,
		29,
		110
	},
	{
		3,
		302,
		"夜之挑战-2",
		1,
		1,
		2,
		0,
		15,
		"bg_shenqilongyan_03_1",
		"",
		"",
		1,
		"",
		1,
		29,
		110
	},
	{
		3,
		303,
		"夜之挑战-3",
		1,
		1,
		2,
		0,
		15,
		"bg_shenqilongyan_03_2",
		"",
		"",
		1,
		"",
		1,
		29,
		110
	},
	{
		3,
		304,
		"夜之挑战-4",
		1,
		1,
		2,
		0,
		15,
		"bg_shenqilongyan_03_2",
		"",
		"",
		1,
		"",
		1,
		29,
		110
	},
	{
		4,
		401,
		"神战-1",
		2,
		1,
		4,
		0,
		15,
		"bg_shenqilongyan_03_2",
		"",
		"",
		1,
		"",
		1,
		0,
		0
	},
	{
		4,
		402,
		"神战-2",
		2,
		1,
		4,
		0,
		15,
		"bg_shenqilongyan_03_2",
		"",
		"",
		1,
		"",
		1,
		0,
		0
	},
	{
		4,
		403,
		"神战-3",
		2,
		1,
		4,
		0,
		15,
		"bg_shenqilongyan_03_2",
		"",
		"",
		1,
		"",
		1,
		0,
		0
	},
	{
		4,
		404,
		"神战-4",
		2,
		1,
		4,
		0,
		15,
		"bg_shenqilongyan_03_2",
		"",
		"",
		1,
		"",
		1,
		0,
		0
	}
}
local t_goddishitian_stage_info = {
	{
		[101] = dataList[1],
		[102] = dataList[2],
		[103] = dataList[3],
		[104] = dataList[4]
	},
	{
		[201] = dataList[5],
		[202] = dataList[6],
		[203] = dataList[7],
		[204] = dataList[8]
	},
	{
		[301] = dataList[9],
		[302] = dataList[10],
		[303] = dataList[11],
		[304] = dataList[12]
	},
	{
		[401] = dataList[13],
		[402] = dataList[14],
		[403] = dataList[15],
		[404] = dataList[16]
	}
}

t_goddishitian_stage_info.dataList = dataList

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

return t_goddishitian_stage_info
