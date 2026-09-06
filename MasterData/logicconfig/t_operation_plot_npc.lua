-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_operation_plot_npc.lua

module("logicconfig.config.t_operation_plot_npc", package.seeall)

local title = {
	npcId = 2,
	chapterId = 1
}
local dataList = {}
local t_operation_plot_npc = {}

t_operation_plot_npc.dataList = dataList

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

return t_operation_plot_npc
