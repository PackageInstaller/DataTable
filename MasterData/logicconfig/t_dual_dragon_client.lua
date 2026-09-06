-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dual_dragon_client.lua

module("logicconfig.config.t_dual_dragon_client", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"goldBarStr",
		"4:179"
	},
	{
		"universalChallengeDesc",
		"可获得双生之冠"
	},
	{
		"extremeChallengeDesc",
		"必定获得双生圣龙"
	},
	{
		"extremeLeftPre",
		"神判之剑"
	},
	{
		"extremeRightPre",
		"裁决之剑"
	}
}
local t_dual_dragon_client = {
	goldBarStr = dataList[1],
	universalChallengeDesc = dataList[2],
	extremeChallengeDesc = dataList[3],
	extremeLeftPre = dataList[4],
	extremeRightPre = dataList[5]
}

t_dual_dragon_client.dataList = dataList

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

return t_dual_dragon_client
