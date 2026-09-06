-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_wei_lei_ta_clg_normal_desc.lua

module("logicconfig.config.t_divine_wei_lei_ta_clg_normal_desc", package.seeall)

local title = {
	id = 2,
	creepsMasterId = 1,
	raceId = 3,
	desc = 4
}
local dataList = {
	{
		101,
		1,
		12018,
		"提升全阵50%攻击力"
	},
	{
		101,
		2,
		10143,
		"提升全阵30%闪避"
	},
	{
		101,
		3,
		12002,
		"提升全阵30%伤害"
	},
	{
		102,
		1,
		12018,
		"提升全阵30%伤害"
	},
	{
		102,
		2,
		10143,
		"提升全阵40%暴击伤害"
	},
	{
		102,
		3,
		12002,
		"提升全阵30%免伤"
	},
	{
		103,
		1,
		12018,
		"提升全阵50%双抗"
	},
	{
		103,
		2,
		10143,
		"提升全阵30%暴击率"
	},
	{
		103,
		3,
		12002,
		"提升全阵50%攻击力"
	}
}
local t_divine_wei_lei_ta_clg_normal_desc = {
	[101] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[102] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[103] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_divine_wei_lei_ta_clg_normal_desc.dataList = dataList

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

return t_divine_wei_lei_ta_clg_normal_desc
