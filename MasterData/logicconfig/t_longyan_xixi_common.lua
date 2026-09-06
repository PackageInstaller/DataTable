-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_longyan_xixi_common.lua

module("logicconfig.config.t_longyan_xixi_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"PET_SKIN_RULES_KEY",
		"hd_xiuer_skin"
	}
}
local t_longyan_xixi_common = {
	PET_SKIN_RULES_KEY = dataList[1]
}

t_longyan_xixi_common.dataList = dataList

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

return t_longyan_xixi_common
