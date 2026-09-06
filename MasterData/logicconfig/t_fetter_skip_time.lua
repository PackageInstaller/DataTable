-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fetter_skip_time.lua

module("logicconfig.config.t_fetter_skip_time", package.seeall)

local title = {
	id = 1,
	skipTime = 3,
	fetter = 2
}
local dataList = {
	{
		1,
		0,
		5
	},
	{
		2,
		1800,
		3
	}
}
local t_fetter_skip_time = {
	dataList[1],
	dataList[2]
}

t_fetter_skip_time.dataList = dataList

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

return t_fetter_skip_time
