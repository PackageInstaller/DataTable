-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_show_off_rank_common.lua

module("logicconfig.config.t_show_off_rank_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"SHOW_OFF_TAB_NAME",
		"精灵皮肤榜"
	}
}
local t_show_off_rank_common = {
	SHOW_OFF_TAB_NAME = dataList[1]
}

t_show_off_rank_common.dataList = dataList

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

return t_show_off_rank_common
