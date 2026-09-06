-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_idiom_chain_word.lua

module("logicconfig.config.t_idiom_chain_word", package.seeall)

local title = {
	wordId = 1,
	content = 2
}
local dataList = {
	{
		1,
		"马到成功"
	},
	{
		2,
		"一马当先"
	},
	{
		3,
		"龙马精神"
	},
	{
		4,
		"万马奔腾"
	},
	{
		5,
		"策马扬鞭"
	},
	{
		6,
		"天马行空"
	},
	{
		7,
		"财运亨通"
	},
	{
		8,
		"财源广进"
	},
	{
		9,
		"富贵双全"
	},
	{
		10,
		"金玉满堂"
	},
	{
		11,
		"日进斗金"
	},
	{
		12,
		"紫气东来"
	},
	{
		13,
		"富贵吉祥"
	},
	{
		14,
		"阖家安康"
	},
	{
		15,
		"五福临门"
	},
	{
		16,
		"吉星高照"
	},
	{
		17,
		"福寿安康"
	},
	{
		18,
		"岁岁平安"
	},
	{
		19,
		"春风得意"
	},
	{
		20,
		"喜乐长安"
	},
	{
		21,
		"鹏程万里"
	},
	{
		22,
		"步步高升"
	},
	{
		23,
		"大展鸿图"
	},
	{
		24,
		"前程似锦"
	},
	{
		25,
		"蒸蒸日上"
	},
	{
		26,
		"功成名就"
	},
	{
		27,
		"万象更新"
	},
	{
		28,
		"喜气洋洋"
	},
	{
		29,
		"大吉大利"
	},
	{
		30,
		"如意吉祥"
	},
	{
		31,
		"国泰民安"
	},
	{
		32,
		"盛世华章"
	},
	{
		33,
		"金榜题名"
	},
	{
		34,
		"学业有成"
	},
	{
		35,
		"才思敏捷"
	},
	{
		36,
		"学有所成"
	},
	{
		37,
		"博学多才"
	},
	{
		38,
		"出类拔萃"
	},
	{
		39,
		"旗开得胜"
	}
}
local t_idiom_chain_word = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20],
	dataList[21],
	dataList[22],
	dataList[23],
	dataList[24],
	dataList[25],
	dataList[26],
	dataList[27],
	dataList[28],
	dataList[29],
	dataList[30],
	dataList[31],
	dataList[32],
	dataList[33],
	dataList[34],
	dataList[35],
	dataList[36],
	dataList[37],
	dataList[38],
	dataList[39]
}

t_idiom_chain_word.dataList = dataList

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

return t_idiom_chain_word
