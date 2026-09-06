-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mahjong_battle_teach.lua

module("logicconfig.config.t_mahjong_battle_teach", package.seeall)

local title = {
	teachCreepsIds = 2,
	activityId = 1,
	teachCreepsMasterId = 3
}
local dataList = {
	{
		571001,
		{
			1,
			2,
			3,
			4,
			5,
			7
		},
		1001
	}
}
local t_mahjong_battle_teach = {
	[571001] = dataList[1]
}

t_mahjong_battle_teach.dataList = dataList

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

return t_mahjong_battle_teach
