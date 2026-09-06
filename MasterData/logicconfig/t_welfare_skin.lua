-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_welfare_skin.lua

module("logicconfig.config.t_welfare_skin", package.seeall)

local title = {
	id = 1,
	viewName = 3,
	behaviorId = 4,
	skinId = 2
}
local dataList = {
	{
		10323,
		1032301,
		"cakesignview",
		200319
	}
}
local t_welfare_skin = {
	[10323] = dataList[1]
}

t_welfare_skin.dataList = dataList

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

return t_welfare_skin
