-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_stripe_filter_status.lua

module("logicconfig.config.t_holy_stripe_filter_status", package.seeall)

local title = {
	id = 1,
	filterStatusType = 2
}
local dataList = {
	{
		1,
		"弃置"
	}
}
local t_holy_stripe_filter_status = {
	dataList[1]
}

t_holy_stripe_filter_status.dataList = dataList

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

return t_holy_stripe_filter_status
