-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_opening_effect_common.lua

module("logicconfig.config.t_opening_effect_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"battlestarttitle",
		"开场特效说明"
	},
	{
		"battlestartdesc",
		"开场特效为进入战斗中播放的特效动画，默认会看到对方使用中的特效；在界面中可勾选选择仅查看自己的动画效果"
	},
	{
		"playerinfotitle",
		"玩家信息说明"
	},
	{
		"playerinfodesc",
		"玩家个人信息展示页，点击其他玩家的头像时可以展示该玩家使用中的个性化个人信息展示页"
	},
	{
		"playermessagetitle",
		"个人信息说明"
	},
	{
		"playermessagedesc",
		"玛卡巴卡个人信息展示页，点击其他玩家的头像时可以展示该玩家使用中的个性化个人信息展示页"
	}
}
local t_opening_effect_common = {
	battlestarttitle = dataList[1],
	battlestartdesc = dataList[2],
	playerinfotitle = dataList[3],
	playerinfodesc = dataList[4],
	playermessagetitle = dataList[5],
	playermessagedesc = dataList[6]
}

t_opening_effect_common.dataList = dataList

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

return t_opening_effect_common
