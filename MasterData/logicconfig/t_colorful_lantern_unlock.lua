-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_colorful_lantern_unlock.lua

module("logicconfig.config.t_colorful_lantern_unlock", package.seeall)

local title = {
	btnId = 1,
	unlockCount = 2
}
local dataList = {
	{
		1,
		1
	},
	{
		2,
		3
	},
	{
		3,
		5
	}
}
local t_colorful_lantern_unlock = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_colorful_lantern_unlock.dataList = dataList

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

return t_colorful_lantern_unlock
