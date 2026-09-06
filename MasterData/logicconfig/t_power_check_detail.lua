-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_power_check_detail.lua

module("logicconfig.config.t_power_check_detail", package.seeall)

local title = {
	tag = 3,
	id = 1,
	maxDesc = 7,
	value = 2,
	group = 4,
	keyName = 5,
	minDesc = 6
}
local dataList = {
	{
		1,
		"",
		1,
		1,
		"精灵养成",
		"",
		""
	},
	{
		2,
		"baseAttr",
		2,
		1,
		"等级：",
		"1级",
		"100级"
	},
	{
		3,
		"talentAttr",
		2,
		1,
		"天赋：",
		"一无是处",
		"最强王者"
	},
	{
		4,
		"equipAttr",
		2,
		1,
		"装备：",
		"白装",
		"橙装"
	},
	{
		5,
		"starGodPlusAttr",
		2,
		1,
		"星神：",
		"",
		""
	},
	{
		6,
		"petHolyStripesAttr",
		2,
		1,
		"灵纹：",
		"",
		""
	},
	{
		7,
		"petSourceTraceAttr",
		2,
		1,
		"源核：",
		"",
		""
	},
	{
		8,
		"",
		1,
		2,
		"公共养成",
		"",
		""
	},
	{
		9,
		"formStrengthAttr",
		2,
		2,
		"阵法：",
		"0级",
		"160级"
	},
	{
		10,
		"mountAttr",
		2,
		2,
		"坐骑：",
		"1级",
		"10级"
	},
	{
		11,
		"petThroneAttr",
		2,
		2,
		"收藏品：",
		"0个",
		"满数量"
	},
	{
		12,
		"petGoodfellingAttr",
		2,
		2,
		"好感度：",
		"1级",
		"30级"
	},
	{
		13,
		"assistAttr",
		2,
		2,
		"守护:",
		"1级",
		"100级"
	},
	{
		14,
		"",
		1,
		3,
		"其他养成",
		"",
		""
	},
	{
		15,
		"OTHER_ATTR",
		2,
		3,
		"其他：",
		"",
		""
	},
	{
		16,
		"petCutePetAttr",
		2,
		1,
		"宠物：",
		"",
		""
	}
}
local t_power_check_detail = {
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
	dataList[16]
}

t_power_check_detail.dataList = dataList

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

return t_power_check_detail
