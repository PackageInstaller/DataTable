-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_integration_challenge_type.lua

module("logicconfig.config.t_integration_challenge_type", package.seeall)

local title = {
	challengeType = 1,
	name = 2
}
local dataList = {
	{
		1,
		"合体前精灵挑战"
	},
	{
		2,
		"双生龙挑战"
	}
}
local t_integration_challenge_type = {
	dataList[1],
	dataList[2]
}

t_integration_challenge_type.dataList = dataList

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

return t_integration_challenge_type
