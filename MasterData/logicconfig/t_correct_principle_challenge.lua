-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_correct_principle_challenge.lua

module("logicconfig.config.t_correct_principle_challenge", package.seeall)

local title = {
	challengeId = 1,
	identityPlanId = 2
}
local dataList = {
	{
		62,
		1
	}
}
local t_correct_principle_challenge = {
	[62] = dataList[1]
}

t_correct_principle_challenge.dataList = dataList

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

return t_correct_principle_challenge
