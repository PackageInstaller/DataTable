-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dark_mm_challenge_master.lua

module("logicconfig.config.t_origin_dark_mm_challenge_master", package.seeall)

local title = {
	skipTime = 3,
	heavenAwakenMasterId = 8,
	heavenAwakenSummonPetId = 9,
	formCondition = 6,
	name = 2,
	selfBuffProviderId = 5,
	winId = 4,
	creepsMasterId = 1,
	heroSkillId = 7
}
local dataList = {
	{
		1001,
		"源起暗黑梦梦-1",
		5,
		0,
		612,
		0,
		"",
		"",
		""
	},
	{
		1002,
		"源起暗黑梦梦-2",
		5,
		0,
		612,
		0,
		"",
		"",
		""
	},
	{
		1003,
		"源起暗黑梦梦-3",
		5,
		0,
		612,
		0,
		"",
		"",
		""
	},
	{
		1004,
		"源起暗黑梦梦-4",
		5,
		0,
		612,
		0,
		"",
		"",
		""
	},
	{
		1005,
		"源起暗黑梦梦-5",
		5,
		0,
		612,
		0,
		"",
		"",
		""
	},
	{
		1006,
		"源起暗黑梦梦-6",
		5,
		0,
		612,
		0,
		"",
		"",
		""
	}
}
local t_origin_dark_mm_challenge_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6]
}

t_origin_dark_mm_challenge_master.dataList = dataList

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

return t_origin_dark_mm_challenge_master
