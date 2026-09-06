-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_badge_common.lua

module("logicconfig.config.t_badge_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"BADGE_DESC",
		"<size=30>奥奇徽章</size>   是实力的证明!"
	},
	{
		"GET_BADGE",
		"每一位奥奇从初级阶段开始，学习知识，磨砺技能，与精灵伙伴一同冒险，即可点亮八大徽章，成长为具备八大品质的高级训练师\n通关精灵挑战、限时挑战、九宫八阵和圣光飞龙挑战等时，可获得对应精灵徽章。"
	},
	{
		"URL_ICON",
		"ui/icon/items/"
	}
}
local t_badge_common = {
	BADGE_DESC = dataList[1],
	GET_BADGE = dataList[2],
	URL_ICON = dataList[3]
}

t_badge_common.dataList = dataList

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

return t_badge_common
