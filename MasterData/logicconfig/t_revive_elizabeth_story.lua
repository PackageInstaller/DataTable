-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_revive_elizabeth_story.lua

module("logicconfig.config.t_revive_elizabeth_story", package.seeall)

local title = {
	content = 2,
	storyId = 1
}
local dataList = {
	{
		4720002,
		"希望的种子被细心呵护，但却久久没有抽芽散叶的迹象，在永恒圣龙授意下，神使兰德斯前来视察......"
	},
	{
		4720003,
		"灵魂复苏有着诸多禁忌，于灵界中被视为不可饶恕之罪，但并非没有先例，只要付出对等的代价便可......"
	},
	{
		4720004,
		"修尔终于得到了苦苦追寻的答案：伊丽莎白之花究竟为何盛放——唯爱无望，唯爱永恒。"
	}
}
local t_revive_elizabeth_story = {
	[4720002] = dataList[1],
	[4720003] = dataList[2],
	[4720004] = dataList[3]
}

t_revive_elizabeth_story.dataList = dataList

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

return t_revive_elizabeth_story
