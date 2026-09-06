-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_master_form_fmt_collect.lua

module("logicconfig.config.t_master_form_fmt_collect", package.seeall)

local title = {
	summonMasterId = 4,
	petList = 2,
	fmtId = 1,
	posList = 3,
	fmtName = 6,
	collectPrize = 7,
	summonPetRaceId = 5,
	fmtDesc = 8
}
local dataList = {
	{
		1,
		{
			15050,
			11041,
			11042,
			13031,
			12046,
			14044
		},
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		0,
		0,
		"草",
		"8:1:100",
		"新人必备PVE阵容，可以通过至尊召唤获得王者梦梦，梦之力为梦之队提供不错的持续作战能力。"
	},
	{
		2,
		{
			17025,
			17026,
			17027,
			17028,
			15044,
			15045
		},
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		0,
		0,
		"空",
		"8:1:100",
		"圣骑队神曜归来，圣骑神曜技均可为敌方添加标记，标记有不同效果，在标记达到对应层数时均可被神曜圣骑队的精灵消除并触发额外效果"
	},
	{
		3,
		{
			12007,
			12008,
			14008,
			11007,
			15011,
			13001
		},
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		0,
		0,
		"究",
		"8:1:100",
		"年费阵容，凡尔维斯与斐希司选择光属性，利用凡尔维斯的被动和斐希司的超杀，可以使其频繁出手打出巨额伤害。神曜龙尊圣主及神曜双生龙需要性转皮肤。"
	},
	{
		4,
		{
			11041,
			11042,
			13031,
			12046,
			14044,
			15050
		},
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		0,
		0,
		"梦",
		"8:1:100",
		"神曜昆仑阵，使用神曜王者极英雄技，神曜龙主契约神曜双生龙，配合至高天理·创世圣龙出手使得神曜昆仑快速通灵"
	},
	{
		5,
		{
			15045,
			15046,
			15047,
			15048,
			15049,
			15050
		},
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		0,
		0,
		"尘",
		"8:1:100",
		"以连击为特性组建的昆仑阵，王极+艾希+昆仑达到快速通灵爆发的效果"
	}
}
local t_master_form_fmt_collect = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_master_form_fmt_collect.dataList = dataList

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

return t_master_form_fmt_collect
