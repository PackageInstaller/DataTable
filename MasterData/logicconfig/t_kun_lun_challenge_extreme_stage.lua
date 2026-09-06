-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kun_lun_challenge_extreme_stage.lua

module("logicconfig.config.t_kun_lun_challenge_extreme_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		304001,
		1,
		100001
	},
	{
		304001,
		2,
		100002
	},
	{
		304001,
		3,
		100003
	},
	{
		304001,
		4,
		100004
	},
	{
		304001,
		5,
		100005
	},
	{
		304001,
		6,
		100006
	},
	{
		304002,
		1,
		100001
	},
	{
		304002,
		2,
		100002
	},
	{
		304002,
		3,
		100003
	},
	{
		304002,
		4,
		100004
	},
	{
		304002,
		5,
		100005
	},
	{
		304002,
		6,
		100006
	}
}
local t_kun_lun_challenge_extreme_stage = {
	[304001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[304002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_kun_lun_challenge_extreme_stage.dataList = dataList

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

return t_kun_lun_challenge_extreme_stage
