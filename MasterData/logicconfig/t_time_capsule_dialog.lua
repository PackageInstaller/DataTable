-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_capsule_dialog.lua

module("logicconfig.config.t_time_capsule_dialog", package.seeall)

local title = {
	id = 1,
	speed = 3,
	content = 2
}
local dataList = {
	{
		1,
		"小奥奇，还记得当年你埋在奥奇世界的时间胶囊吗？",
		20
	},
	{
		2,
		"埋在哪里了呢？",
		20
	},
	{
		3,
		"哈？你也不记得了呀？那就一起去找找吧",
		20
	}
}
local t_time_capsule_dialog = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_time_capsule_dialog.dataList = dataList

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

return t_time_capsule_dialog
