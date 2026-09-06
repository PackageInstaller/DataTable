-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jiu_clg_common.lua

module("logicconfig.config.t_jiu_clg_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"参数名",
		"值"
	},
	{
		"ACTIVITY_ID",
		"386001"
	}
}
local t_jiu_clg_common = {
	参数名 = dataList[1],
	ACTIVITY_ID = dataList[2]
}

t_jiu_clg_common.dataList = dataList

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

return t_jiu_clg_common
