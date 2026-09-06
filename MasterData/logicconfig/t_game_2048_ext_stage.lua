-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_game_2048_ext_stage.lua

module("logicconfig.config.t_game_2048_ext_stage", package.seeall)

local title = {
	activityId = 1,
	mapId = 2
}
local dataList = {
	{
		320001,
		0
	},
	{
		320002,
		0
	},
	{
		320003,
		0
	},
	{
		320004,
		0
	},
	{
		320005,
		0
	}
}
local t_game_2048_ext_stage = {
	[320001] = dataList[1],
	[320002] = dataList[2],
	[320003] = dataList[3],
	[320004] = dataList[4],
	[320005] = dataList[5]
}

t_game_2048_ext_stage.dataList = dataList

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

return t_game_2048_ext_stage
