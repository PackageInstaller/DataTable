-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lucky_draw_skin_pos_scale.lua

module("logicconfig.config.t_lucky_draw_skin_pos_scale", package.seeall)

local title = {
	scale = 3,
	pos = 2,
	skinId = 1
}
local dataList = {}
local t_lucky_draw_skin_pos_scale = {}

t_lucky_draw_skin_pos_scale.dataList = dataList

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

return t_lucky_draw_skin_pos_scale
