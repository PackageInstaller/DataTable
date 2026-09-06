-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tab_frame_work_common.lua

module("logicconfig.config.t_tab_frame_work_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {}
local t_tab_frame_work_common = {}

t_tab_frame_work_common.dataList = dataList

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

return t_tab_frame_work_common
