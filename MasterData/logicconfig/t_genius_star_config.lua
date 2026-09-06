-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_genius_star_config.lua

module("logicconfig.config.t_genius_star_config", package.seeall)

local title = {
	geniusMinValue = 2,
	geniusMaxValue = 3,
	strengthenMinValue = 4,
	strengthenMaxValue = 5,
	star = 1
}
local dataList = {}
local t_genius_star_config = {}

t_genius_star_config.dataList = dataList

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

return t_genius_star_config
