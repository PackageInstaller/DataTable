-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_user_close.lua

module("logicconfig.config.t_user_close", package.seeall)

local title = {
	platformId = 1,
	coolingOffDays = 2
}
local dataList = {
	{
		5,
		15
	}
}
local t_user_close = {
	[5] = dataList[1]
}

t_user_close.dataList = dataList

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

return t_user_close
