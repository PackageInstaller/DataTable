-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xing_jiang_clg_mat.lua

module("logicconfig.config.t_divine_xing_jiang_clg_mat", package.seeall)

local title = {
	id = 1,
	normalProp = 2,
	specialProp = 3
}
local dataList = {
	{
		1,
		"水瓶座黑洞",
		"水瓶座碎片"
	},
	{
		2,
		"水瓶座黑洞",
		"水瓶座碎片"
	},
	{
		3,
		"水瓶座黑洞",
		"水瓶座碎片"
	},
	{
		4,
		"水瓶座黑洞",
		"水瓶座碎片"
	},
	{
		5,
		"水瓶座黑洞",
		"水瓶座碎片"
	},
	{
		6,
		"水瓶座黑洞",
		"水瓶座碎片"
	},
	{
		7,
		"水瓶座黑洞",
		"水瓶座碎片"
	},
	{
		8,
		"水瓶座黑洞",
		"水瓶座碎片"
	},
	{
		9,
		"水瓶座黑洞",
		"水瓶座碎片"
	},
	{
		10,
		"水瓶座黑洞",
		"水瓶座碎片"
	},
	{
		11,
		"水瓶座黑洞",
		"水瓶座碎片"
	},
	{
		12,
		"水瓶座黑洞",
		"水瓶座碎片"
	}
}
local t_divine_xing_jiang_clg_mat = {
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
	dataList[12]
}

t_divine_xing_jiang_clg_mat.dataList = dataList

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

return t_divine_xing_jiang_clg_mat
