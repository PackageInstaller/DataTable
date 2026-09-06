-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_making_moon_cake_material.lua

module("logicconfig.config.t_making_moon_cake_material", package.seeall)

local title = {
	id = 1,
	icon = 2,
	wordIcon = 3
}
local dataList = {
	{
		1,
		"icon_zq_jidan",
		""
	},
	{
		2,
		"icon_zq_niunaiguan",
		""
	},
	{
		3,
		"icon_zq_baitang",
		""
	},
	{
		4,
		"icon_zq_huasheng",
		""
	},
	{
		5,
		"icon_zq_lianzi",
		""
	},
	{
		6,
		"icon_zq_jianguo",
		""
	},
	{
		7,
		"icon_zq_nuomifen",
		""
	},
	{
		8,
		"icon_zq_zhishi",
		""
	},
	{
		9,
		"icon_shicai_zhima",
		""
	},
	{
		10,
		"icon_shicai_dousha",
		""
	},
	{
		11,
		"icon_shicai_yangrou",
		""
	},
	{
		12,
		"icon_nssw_yan",
		""
	}
}
local t_making_moon_cake_material = {
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

t_making_moon_cake_material.dataList = dataList

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

return t_making_moon_cake_material
