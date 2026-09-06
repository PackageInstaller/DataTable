-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xiu_er_normal_clg.lua

module("logicconfig.config.t_divine_xiu_er_normal_clg", package.seeall)

local title = {
	activityId = 1,
	clgTips = 2
}
local dataList = {
	{
		329001,
		"是非之力已达标"
	}
}
local t_divine_xiu_er_normal_clg = {
	[329001] = dataList[1]
}

t_divine_xiu_er_normal_clg.dataList = dataList

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

return t_divine_xiu_er_normal_clg
