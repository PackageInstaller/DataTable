-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_infinite_fight_common.lua

module("logicconfig.config.t_infinite_fight_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"OPEN_SWEEP_STAGE_ID",
		"10"
	},
	{
		"OPEN_ONE_KEY_PASS_STAGE_ID",
		"10"
	}
}
local t_infinite_fight_common = {
	OPEN_SWEEP_STAGE_ID = dataList[1],
	OPEN_ONE_KEY_PASS_STAGE_ID = dataList[2]
}

t_infinite_fight_common.dataList = dataList

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

return t_infinite_fight_common
