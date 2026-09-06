-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_crazy_partner.lua

module("logicconfig.config.t_crazy_partner", package.seeall)

local title = {
	activityId = 1,
	redPointId = 2
}
local dataList = {
	{
		153001,
		248
	}
}
local t_crazy_partner = {
	[153001] = dataList[1]
}

t_crazy_partner.dataList = dataList

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

return t_crazy_partner
