-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_survival_king_buff_mode.lua

module("logicconfig.config.t_survival_king_buff_mode", package.seeall)

local title = {
	modeName = 2,
	buffMode = 1
}
local dataList = {
	{
		1,
		"INVENTORY"
	},
	{
		2,
		"LEVEL"
	}
}
local t_survival_king_buff_mode = {
	dataList[1],
	dataList[2]
}

t_survival_king_buff_mode.dataList = dataList

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

return t_survival_king_buff_mode
