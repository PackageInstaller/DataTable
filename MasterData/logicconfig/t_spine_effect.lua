-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_spine_effect.lua

module("logicconfig.config.t_spine_effect", package.seeall)

local title = {
	offset = 5,
	bone = 4,
	id = 1,
	modelId = 2,
	effectPath = 3
}
local dataList = {
	{
		1001,
		10060,
		"common/buff/fx_buff_miehuo",
		"bone11",
		"0,0,0"
	}
}
local t_spine_effect = {
	[1001] = dataList[1]
}

t_spine_effect.dataList = dataList

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

return t_spine_effect
