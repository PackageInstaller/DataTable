-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wisdomaltar.lua

module("logicconfig.config.t_wisdomaltar", package.seeall)

local title = {
	tips = 3,
	name = 2,
	type = 1
}
local dataList = {
	{
		1,
		"一键觉醒",
		"一键觉醒：批量地对<color=#d56d08>幻兽</color>品质精灵进行觉醒至<color=#d56d08>觉醒3</color>"
	},
	{
		2,
		"智能觉醒",
		"智能觉醒：批量地对<color=#d56d08>超能</color>品质精灵进行觉醒至<color=#d56d08>觉醒5</color>"
	}
}
local t_wisdomaltar = {
	dataList[1],
	dataList[2]
}

t_wisdomaltar.dataList = dataList

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

return t_wisdomaltar
