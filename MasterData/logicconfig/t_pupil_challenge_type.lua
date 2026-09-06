-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pupil_challenge_type.lua

module("logicconfig.config.t_pupil_challenge_type", package.seeall)

local title = {
	challengeType = 1,
	name = 2,
	stageCount = 3
}
local dataList = {
	{
		1,
		"不熄火种",
		4
	},
	{
		2,
		"复仇之焰",
		3
	},
	{
		3,
		"恶魔双生（普通模式）",
		2
	},
	{
		4,
		"恶魔双生（地狱模式）",
		2
	}
}
local t_pupil_challenge_type = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_pupil_challenge_type.dataList = dataList

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

return t_pupil_challenge_type
