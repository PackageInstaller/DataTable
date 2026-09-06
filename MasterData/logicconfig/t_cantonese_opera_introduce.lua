-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cantonese_opera_introduce.lua

module("logicconfig.config.t_cantonese_opera_introduce", package.seeall)

local title = {
	redPointId = 3,
	activityId = 1,
	time = 2,
	ruleId = 5,
	planId = 4
}
local dataList = {
	{
		188001,
		1,
		325,
		1,
		"cantoneseopera_rule"
	}
}
local t_cantonese_opera_introduce = {
	[188001] = dataList[1]
}

t_cantonese_opera_introduce.dataList = dataList

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

return t_cantonese_opera_introduce
