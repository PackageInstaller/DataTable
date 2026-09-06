-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fight_creeps_time.lua

module("logicconfig.config.t_fight_creeps_time", package.seeall)

local title = {
	startTime = 2,
	skinId = 1
}
local dataList = {}
local t_fight_creeps_time = {}

t_fight_creeps_time.dataList = dataList

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

return t_fight_creeps_time
