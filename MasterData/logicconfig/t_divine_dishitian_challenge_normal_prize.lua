-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dishitian_challenge_normal_prize.lua

module("logicconfig.config.t_divine_dishitian_challenge_normal_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	number = 3
}
local dataList = {
	{
		363001,
		1,
		21,
		"4:233:100"
	}
}
local t_divine_dishitian_challenge_normal_prize = {
	[363001] = {
		dataList[1]
	}
}

t_divine_dishitian_challenge_normal_prize.dataList = dataList

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

return t_divine_dishitian_challenge_normal_prize
