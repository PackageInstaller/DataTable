-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fuli_wushenshou_config.lua

module("logicconfig.config.t_fuli_wushenshou_config", package.seeall)

local title = {
	rewardDesc = 3,
	name = 5,
	rewardType = 7,
	rewardDesc2 = 4,
	id = 1,
	raceId = 6,
	rewardParams = 8,
	level = 2
}
local dataList = {
	{
		6,
		6,
		"绯樱\n升至80级",
		"等级升至<color=#ffd200><size=50>80级</size></color>",
		"绯樱",
		{
			10169
		},
		1,
		"80"
	}
}
local t_fuli_wushenshou_config = {
	[6] = dataList[1]
}

t_fuli_wushenshou_config.dataList = dataList

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

return t_fuli_wushenshou_config
