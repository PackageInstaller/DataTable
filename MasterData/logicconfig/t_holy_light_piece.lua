-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_light_piece.lua

module("logicconfig.config.t_holy_light_piece", package.seeall)

local title = {
	pictureUrl = 3,
	pieceId = 1,
	name = 2
}
local dataList = {
	{
		1,
		"翻倍",
		"icon/game/holylight/board_dafuweng_wenben_02"
	},
	{
		2,
		"挑战",
		"icon/game/powerpilla/icon_09"
	},
	{
		3,
		"终点",
		"icon/game/holylight/board_dafuweng_01"
	},
	{
		4,
		"普通骰子",
		"icon/items/icon_dfw_putong"
	},
	{
		5,
		"万能骰子",
		"icon/items/icon_dfw_wanneng"
	},
	{
		6,
		"功能牌",
		"icon/items/icon_dfw_gongnengpai"
	},
	{
		11,
		"金币",
		"icon/items/icon_jinbi"
	},
	{
		12,
		"纯净晶钻",
		"icon/game/holylight/icon_dafuwengdaibi"
	},
	{
		13,
		"淬源晶石",
		"icon/items/icon_cuiyuanjingshi"
	},
	{
		14,
		"初级强化石",
		"icon/items/icon_qianghua2"
	},
	{
		15,
		"中级强化石",
		"icon/items/icon_qianghua3"
	},
	{
		16,
		"大星元",
		"icon/items/icon_xingyun_02"
	},
	{
		17,
		"超级星元",
		"icon/items/icon_xingyun_01"
	},
	{
		21,
		"冰灵羽粹-攻",
		"icon/game/holylight/icon_yumao_01"
	},
	{
		22,
		"冰灵羽粹-防",
		"icon/game/holylight/icon_yumao_02"
	},
	{
		23,
		"冰灵羽粹-血",
		"icon/game/holylight/icon_yumao_03"
	},
	{
		24,
		"冰灵羽粹-怒",
		"icon/game/holylight/icon_yumao_04"
	}
}
local t_holy_light_piece = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	[11] = dataList[7],
	[12] = dataList[8],
	[13] = dataList[9],
	[14] = dataList[10],
	[15] = dataList[11],
	[16] = dataList[12],
	[17] = dataList[13],
	[21] = dataList[14],
	[22] = dataList[15],
	[23] = dataList[16],
	[24] = dataList[17]
}

t_holy_light_piece.dataList = dataList

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

return t_holy_light_piece
