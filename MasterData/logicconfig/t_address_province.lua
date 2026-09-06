-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_address_province.lua

module("logicconfig.config.t_address_province", package.seeall)

local title = {
	provinceCode = 1,
	province = 2
}
local dataList = {
	{
		11,
		"北京市"
	},
	{
		12,
		"天津市"
	},
	{
		13,
		"河北省"
	},
	{
		14,
		"山西省"
	},
	{
		15,
		"内蒙古自治区"
	},
	{
		21,
		"辽宁省"
	},
	{
		22,
		"吉林省"
	},
	{
		23,
		"黑龙江省"
	},
	{
		31,
		"上海市"
	},
	{
		32,
		"江苏省"
	},
	{
		33,
		"浙江省"
	},
	{
		34,
		"安徽省"
	},
	{
		35,
		"福建省"
	},
	{
		36,
		"江西省"
	},
	{
		37,
		"山东省"
	},
	{
		41,
		"河南省"
	},
	{
		42,
		"湖北省"
	},
	{
		43,
		"湖南省"
	},
	{
		44,
		"广东省"
	},
	{
		45,
		"广西壮族自治区"
	},
	{
		46,
		"海南省"
	},
	{
		50,
		"重庆市"
	},
	{
		51,
		"四川省"
	},
	{
		52,
		"贵州省"
	},
	{
		53,
		"云南省"
	},
	{
		54,
		"西藏自治区"
	},
	{
		61,
		"陕西省"
	},
	{
		62,
		"甘肃省"
	},
	{
		63,
		"青海省"
	},
	{
		64,
		"宁夏回族自治区"
	},
	{
		65,
		"新疆维吾尔自治区"
	},
	{
		0,
		"其他"
	}
}
local t_address_province = {
	[11] = dataList[1],
	[12] = dataList[2],
	[13] = dataList[3],
	[14] = dataList[4],
	[15] = dataList[5],
	[21] = dataList[6],
	[22] = dataList[7],
	[23] = dataList[8],
	[31] = dataList[9],
	[32] = dataList[10],
	[33] = dataList[11],
	[34] = dataList[12],
	[35] = dataList[13],
	[36] = dataList[14],
	[37] = dataList[15],
	[41] = dataList[16],
	[42] = dataList[17],
	[43] = dataList[18],
	[44] = dataList[19],
	[45] = dataList[20],
	[46] = dataList[21],
	[50] = dataList[22],
	[51] = dataList[23],
	[52] = dataList[24],
	[53] = dataList[25],
	[54] = dataList[26],
	[61] = dataList[27],
	[62] = dataList[28],
	[63] = dataList[29],
	[64] = dataList[30],
	[65] = dataList[31],
	[0] = dataList[32]
}

t_address_province.dataList = dataList

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

return t_address_province
