-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_expirable_item_consts.lua

module("logicconfig.config.t_expirable_item_consts", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"BONUS_TIME",
		"04:55:00"
	},
	{
		"WARNING_DAYS",
		"3"
	}
}
local t_expirable_item_consts = {
	BONUS_TIME = dataList[1],
	WARNING_DAYS = dataList[2]
}

t_expirable_item_consts.dataList = dataList

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

return t_expirable_item_consts
