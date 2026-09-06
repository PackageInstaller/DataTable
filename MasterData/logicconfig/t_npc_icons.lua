-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_npc_icons.lua

module("logicconfig.config.t_npc_icons", package.seeall)

local title = {
	func = 3,
	id = 1,
	icon = 2,
	scale = 5,
	funcIds = 4
}
local dataList = {
	{
		1,
		0,
		{
			1,
			7,
			11,
			12,
			13
		},
		nil,
		0
	},
	{
		2,
		1,
		nil,
		{
			1026,
			1027
		},
		0
	}
}
local t_npc_icons = {
	dataList[1],
	dataList[2]
}

t_npc_icons.dataList = dataList

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

return t_npc_icons
