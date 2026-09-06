-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_moon_shadow_king_challenge.lua

module("logicconfig.config.t_moon_shadow_king_challenge", package.seeall)

local title = {
	challengeId = 1,
	jumpTo2 = 7,
	rankSize = 2,
	skinId = 13,
	showPrize = 11,
	scorePrizePlanId = 4,
	tipsStr = 10,
	jumpTo3 = 8,
	daibiStr = 14,
	GOODS_ID = 5,
	scoreStr = 15,
	jumpTo1 = 6,
	viewName = 12,
	jumpTo4 = 9,
	modelScale = 16,
	challengePlanId = 3
}
local dataList = {
	{
		29,
		9999,
		1,
		1,
		4523,
		"",
		"",
		"",
		"",
		"",
		"",
		"月影王挑战",
		10101,
		"1004:1208",
		"1004:1208",
		0.34
	},
	{
		45,
		0,
		2,
		2,
		0,
		"ui#publicdragontabview#2#3",
		"func#618#12008",
		"",
		"",
		"",
		"",
		"圣骑炎神挑战",
		12008,
		"4:145",
		"10:17020",
		1
	},
	{
		98,
		0,
		3,
		3,
		0,
		"func#545#3",
		"func#618#16012",
		"mibao#nvshentehui2",
		"",
		"",
		"icon_16012_feiyin",
		"费因挑战",
		16012,
		"4:173",
		"4:173",
		1
	},
	{
		170,
		0,
		4,
		4,
		0,
		"func#856",
		"func#545#3",
		"mibao#yingsenzhuxiang3",
		"func#618#13016",
		"shenyaopanduolamain",
		"",
		"神曜潘多拉挑战",
		13016,
		"4:510299",
		"4:510299",
		1
	}
}
local t_moon_shadow_king_challenge = {
	[29] = dataList[1],
	[45] = dataList[2],
	[98] = dataList[3],
	[170] = dataList[4]
}

t_moon_shadow_king_challenge.dataList = dataList

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

return t_moon_shadow_king_challenge
