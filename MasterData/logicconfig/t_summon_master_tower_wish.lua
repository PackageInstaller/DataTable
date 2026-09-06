-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_tower_wish.lua

module("logicconfig.config.t_summon_master_tower_wish", package.seeall)

local title = {
	option = 1
}
local dataList = {
	{
		1
	},
	{
		2
	}
}
local t_summon_master_tower_wish = {
	dataList[1],
	dataList[2]
}

t_summon_master_tower_wish.dataList = dataList

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

return t_summon_master_tower_wish
