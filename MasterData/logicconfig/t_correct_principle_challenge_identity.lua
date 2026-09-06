-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_correct_principle_challenge_identity.lua

module("logicconfig.config.t_correct_principle_challenge_identity", package.seeall)

local title = {
	openTime = 3,
	identityId = 2,
	identityPlanId = 1,
	prize = 4,
	desc = 5
}
local dataList = {
	{
		1,
		1,
		"2023-01-27T05:00:00",
		"4:162:20",
		"与召唤师们携手前进！"
	},
	{
		1,
		2,
		"2023-01-28T05:00:00",
		"4:162:30",
		"考验技巧的时候到啦！"
	},
	{
		1,
		3,
		"2023-01-29T05:00:00",
		"4:162:70",
		"轮回复活之战！"
	}
}
local t_correct_principle_challenge_identity = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_correct_principle_challenge_identity.dataList = dataList

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

return t_correct_principle_challenge_identity
