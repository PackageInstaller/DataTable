-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_restore_ganmerule.lua

module("logicconfig.config.t_restore_ganmerule", package.seeall)

local title = {
	ImgpathL = 3,
	descL = 5,
	descR = 6,
	ImgpathR = 4,
	activityId = 1,
	gameId = 2
}
local dataList = {
	{
		248001,
		1,
		"board_sd_01",
		"board_sd_01",
		"盾牌左规则",
		"盾牌右规则"
	},
	{
		248001,
		2,
		"board_sj_01",
		"board_sj_01",
		"圣剑左规则",
		"圣剑左规则"
	}
}
local t_restore_ganmerule = {
	[248001] = {
		dataList[1],
		dataList[2]
	}
}

t_restore_ganmerule.dataList = dataList

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

return t_restore_ganmerule
