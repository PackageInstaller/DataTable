-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_clear_star_game_img_rules.lua

module("logicconfig.config.t_clear_star_game_img_rules", package.seeall)

local title = {
	sortId = 2,
	desc = 4,
	activityId = 1,
	imgPath = 3
}
local dataList = {
	{
		479001,
		1,
		"ui/bigbg/views/clearstargame/board_rule2.png",
		"如何消除：点击2个及以上相连的方块即可选中，再次点击即可直接消除。\r\n刷新道具：点击后将在维持当前方块分布的情况下，打乱方块颜色"
	},
	{
		479001,
		2,
		"ui/bigbg/views/clearstargame/board_rule3.png",
		"炸弹道具：点击炸弹后，选中其中某个方块，将消除掉被选中的方块周围一圈的方块"
	},
	{
		479001,
		3,
		"ui/bigbg/views/clearstargame/board_rule1.png",
		"改色笔：点击后，选中想改的颜色，再选中方块，即可将此方块直接改色\r\n奖励结算：将按照本局内获得的分数进行1:1结算，单局单个道具上限200"
	},
	{
		479003,
		1,
		"ui/bigbg/views/clearstargame/board_rule2.png",
		"如何消除：点击2个及以上相连的方块即可选中，再次点击即可直接消除。"
	}
}
local t_clear_star_game_img_rules = {
	[479001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[479003] = {
		dataList[4]
	}
}

t_clear_star_game_img_rules.dataList = dataList

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

return t_clear_star_game_img_rules
