-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_ji_clg_buff.lua

module("logicconfig.config.t_divine_king_ji_clg_buff", package.seeall)

local title = {
	buffDesc = 4,
	buffPlanId = 1,
	buffName = 3,
	startNum = 2,
	buffIcon = 5
}
local dataList = {
	{
		1,
		1,
		"属性削弱Ⅰ",
		"己阵全属性-5%",
		"icon_expedition_ydnzhufu"
	},
	{
		1,
		2,
		"属性削弱Ⅱ",
		"己阵全属性-10%",
		"icon_expedition_ydnzhufu"
	},
	{
		1,
		3,
		"属性削弱Ⅲ",
		"己阵全属性-20%",
		"icon_expedition_ydnzhufu"
	},
	{
		1,
		4,
		"属性削弱Ⅳ",
		"己阵全属性-40%",
		"icon_expedition_ydnzhufu"
	},
	{
		1,
		5,
		"属性削弱Ⅴ",
		"己阵全属性-60%",
		"icon_expedition_ydnzhufu"
	},
	{
		1,
		6,
		"属性削弱Ⅵ",
		"己阵全属性-80%",
		"icon_expedition_ydnzhufu"
	}
}
local t_divine_king_ji_clg_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_king_ji_clg_buff.dataList = dataList

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

return t_divine_king_ji_clg_buff
