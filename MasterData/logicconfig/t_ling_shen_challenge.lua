-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ling_shen_challenge.lua

module("logicconfig.config.t_ling_shen_challenge", package.seeall)

local title = {
	preFormRow = 5,
	preFormPetCount = 4,
	playerCount = 2,
	jumpTo = 6,
	formCountDown = 3,
	activityId = 1
}
local dataList = {
	{
		377001,
		2,
		15,
		3,
		2,
		"func#191#377#377001"
	},
	{
		377002,
		2,
		15,
		3,
		2,
		"func#191#377#377002"
	},
	{
		377003,
		2,
		15,
		3,
		2,
		"func#191#377#377003"
	},
	{
		377004,
		2,
		15,
		3,
		2,
		"func#191#377#377004"
	}
}
local t_ling_shen_challenge = {
	[377001] = dataList[1],
	[377002] = dataList[2],
	[377003] = dataList[3],
	[377004] = dataList[4]
}

t_ling_shen_challenge.dataList = dataList

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

return t_ling_shen_challenge
