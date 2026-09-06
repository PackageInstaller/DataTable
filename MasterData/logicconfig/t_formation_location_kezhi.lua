-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_formation_location_kezhi.lua

module("logicconfig.config.t_formation_location_kezhi", package.seeall)

local title = {
	de_location = 2,
	location = 1
}
local dataList = {
	{
		"物攻",
		"魔防"
	},
	{
		"魔攻",
		"物防"
	},
	{
		"物防",
		"物攻"
	},
	{
		"魔防",
		"魔攻"
	}
}
local t_formation_location_kezhi = {
	物攻 = dataList[1],
	魔攻 = dataList[2],
	物防 = dataList[3],
	魔防 = dataList[4]
}

t_formation_location_kezhi.dataList = dataList

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

return t_formation_location_kezhi
