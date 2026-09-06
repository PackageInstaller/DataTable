-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_friend_bargain.lua

module("logicconfig.config.t_friend_bargain", package.seeall)

local title = {
	timeLimit = 5,
	chatCD = 4,
	goodsPlanId = 2,
	reducePlanId = 3,
	activityId = 1
}
local dataList = {
	{
		255001,
		1,
		1,
		180,
		3
	}
}
local t_friend_bargain = {
	[255001] = dataList[1]
}

t_friend_bargain.dataList = dataList

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

return t_friend_bargain
