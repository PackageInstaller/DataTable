-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guess_lantern_activity.lua

module("logicconfig.config.t_guess_lantern_activity", package.seeall)

local title = {
	problemNum = 5,
	redPointId = 3,
	cd = 4,
	excludeFinishProblem = 6,
	problemPlanId = 2,
	actId = 1
}
local dataList = {
	{
		307001,
		1,
		516,
		3,
		5,
		false
	},
	{
		307002,
		1,
		516,
		3,
		5,
		false
	},
	{
		307003,
		3,
		610,
		3,
		3,
		true
	},
	{
		307004,
		4,
		611,
		3,
		3,
		true
	},
	{
		307005,
		5,
		610,
		3,
		3,
		true
	},
	{
		307006,
		6,
		611,
		3,
		3,
		true
	},
	{
		307007,
		7,
		610,
		3,
		3,
		true
	},
	{
		307008,
		8,
		611,
		3,
		3,
		true
	},
	{
		307009,
		9,
		611,
		3,
		3,
		true
	},
	{
		307010,
		10,
		610,
		3,
		3,
		true
	},
	{
		307011,
		11,
		516,
		3,
		3,
		true
	},
	{
		307012,
		12,
		611,
		3,
		3,
		true
	},
	{
		307013,
		13,
		610,
		3,
		3,
		true
	},
	{
		307014,
		14,
		516,
		3,
		3,
		true
	},
	{
		307015,
		15,
		610,
		3,
		3,
		true
	}
}
local t_guess_lantern_activity = {
	[307001] = dataList[1],
	[307002] = dataList[2],
	[307003] = dataList[3],
	[307004] = dataList[4],
	[307005] = dataList[5],
	[307006] = dataList[6],
	[307007] = dataList[7],
	[307008] = dataList[8],
	[307009] = dataList[9],
	[307010] = dataList[10],
	[307011] = dataList[11],
	[307012] = dataList[12],
	[307013] = dataList[13],
	[307014] = dataList[14],
	[307015] = dataList[15]
}

t_guess_lantern_activity.dataList = dataList

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

return t_guess_lantern_activity
