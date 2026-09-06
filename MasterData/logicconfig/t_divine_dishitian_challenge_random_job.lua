-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dishitian_challenge_random_job.lua

module("logicconfig.config.t_divine_dishitian_challenge_random_job", package.seeall)

local title = {
	activityId = 1,
	jobId = 2
}
local dataList = {
	{
		363001,
		1
	},
	{
		363001,
		2
	},
	{
		363001,
		3
	},
	{
		363001,
		4
	},
	{
		363001,
		5
	},
	{
		363001,
		6
	},
	{
		363001,
		21
	},
	{
		363001,
		22
	},
	{
		363001,
		28
	},
	{
		363001,
		29
	},
	{
		363001,
		30
	}
}
local t_divine_dishitian_challenge_random_job = {
	[363001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		[21] = dataList[7],
		[22] = dataList[8],
		[28] = dataList[9],
		[29] = dataList[10],
		[30] = dataList[11]
	}
}

t_divine_dishitian_challenge_random_job.dataList = dataList

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

return t_divine_dishitian_challenge_random_job
