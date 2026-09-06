-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_glory_params.lua

module("logicconfig.config.t_goddess_glory_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"GODDESS_GLORY_NAME",
		"炽火挑战"
	},
	{
		"PUSH_ITEM",
		"100:12017:1:1"
	},
	{
		"PUSH_ITEM_TIPS",
		"可兑换神曜炽火·热血梦梦"
	},
	{
		"MAIN_IMAGE",
		"12017_shenyaorexuemengmeng_beibao_lihui"
	},
	{
		"MAIN_IMAGE_POSE",
		"12,-470,1.2"
	},
	{
		"STORY_ID",
		""
	},
	{
		"ITEM_MAT_TYPE",
		"4:203"
	},
	{
		"CHALLENGE_ID",
		"119"
	},
	{
		"RED_POINT_ID",
		"219"
	},
	{
		"JUMP_TO_SHOP",
		"func#191#131#131004"
	},
	{
		"ELF_RANKING",
		"func#618#12017"
	},
	{
		"JUMP_TO_ACTIVITY_SHOP",
		"mibao#shenyaolibao"
	}
}
local t_goddess_glory_params = {
	GODDESS_GLORY_NAME = dataList[1],
	PUSH_ITEM = dataList[2],
	PUSH_ITEM_TIPS = dataList[3],
	MAIN_IMAGE = dataList[4],
	MAIN_IMAGE_POSE = dataList[5],
	STORY_ID = dataList[6],
	ITEM_MAT_TYPE = dataList[7],
	CHALLENGE_ID = dataList[8],
	RED_POINT_ID = dataList[9],
	JUMP_TO_SHOP = dataList[10],
	ELF_RANKING = dataList[11],
	JUMP_TO_ACTIVITY_SHOP = dataList[12]
}

t_goddess_glory_params.dataList = dataList

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

return t_goddess_glory_params
