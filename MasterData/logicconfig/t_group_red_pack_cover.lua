-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_group_red_pack_cover.lua

module("logicconfig.config.t_group_red_pack_cover", package.seeall)

local title = {
	adImgPath = 4,
	coverPlanId = 1,
	coverIds = 3,
	groupId = 2,
	coverImgPath = 5
}
local dataList = {
	{
		1,
		1,
		"13006;1100202;1032401;1031401;1600401;1014702",
		"img_10028_shengguangfeilong01;img_10097_moyan;img_10309_xixi;img_10313_ciyuanshenglong01;img_10324_huangjinshenglong01;img_10326_chiyanlonghuang01",
		"img_10028_shengguangfeilong01;img_10097_moyan;img_10309_xixi;img_10313_ciyuanshenglong01;img_10324_huangjinshenglong01;img_10326_chiyanlonghuang01"
	},
	{
		1,
		2,
		"1600601;1601001;1601101;16008;1401101;1002701",
		"img_10028_shengguangfeilong01;img_10097_moyan;img_10309_xixi;img_10313_ciyuanshenglong01;img_10324_huangjinshenglong01;img_10326_chiyanlonghuang01",
		"img_10028_shengguangfeilong01;img_10097_moyan;img_10309_xixi;img_10313_ciyuanshenglong01;img_10324_huangjinshenglong01;img_10326_chiyanlonghuang01"
	},
	{
		1,
		3,
		"14001;1009702;1600102;1200401;1032601;1033001",
		"img_10028_shengguangfeilong01;img_10097_moyan;img_10309_xixi;img_10313_ciyuanshenglong01;img_10324_huangjinshenglong01;img_10326_chiyanlonghuang01",
		"img_10028_shengguangfeilong01;img_10097_moyan;img_10309_xixi;img_10313_ciyuanshenglong01;img_10324_huangjinshenglong01;img_10326_chiyanlonghuang01"
	},
	{
		1,
		4,
		"15013;1200501;1031301;1700201;1600501;1700301",
		"img_10028_shengguangfeilong01;img_10097_moyan;img_10309_xixi;img_10313_ciyuanshenglong01;img_10324_huangjinshenglong01;img_10326_chiyanlonghuang01",
		"img_10028_shengguangfeilong01;img_10097_moyan;img_10309_xixi;img_10313_ciyuanshenglong01;img_10324_huangjinshenglong01;img_10326_chiyanlonghuang01"
	},
	{
		2,
		1,
		"1401602;1602202;12009;12005;16014;1031402",
		"img_10028_shengguangfeilong01;img_10097_moyan;img_10309_xixi;img_10313_ciyuanshenglong01;img_10324_huangjinshenglong01;img_10326_chiyanlonghuang01",
		"img_10028_shengguangfeilong01;img_10097_moyan;img_10309_xixi;img_10313_ciyuanshenglong01;img_10324_huangjinshenglong01;img_10326_chiyanlonghuang01"
	},
	{
		2,
		2,
		"1101103;16019;13006;1402201;15013;1300801",
		"img_10028_shengguangfeilong01;img_10097_moyan;img_10309_xixi;img_10313_ciyuanshenglong01;img_10324_huangjinshenglong01;img_10326_chiyanlonghuang01",
		"img_10028_shengguangfeilong01;img_10097_moyan;img_10309_xixi;img_10313_ciyuanshenglong01;img_10324_huangjinshenglong01;img_10326_chiyanlonghuang01"
	},
	{
		2,
		3,
		"1402301;1201602;1601602;1401302;1701502;10147",
		"img_10028_shengguangfeilong01;img_10097_moyan;img_10309_xixi;img_10313_ciyuanshenglong01;img_10324_huangjinshenglong01;img_10326_chiyanlonghuang01",
		"img_10028_shengguangfeilong01;img_10097_moyan;img_10309_xixi;img_10313_ciyuanshenglong01;img_10324_huangjinshenglong01;img_10326_chiyanlonghuang01"
	},
	{
		2,
		4,
		"1800101;14020;16006;1502001;1401402;1701402",
		"img_10028_shengguangfeilong01;img_10097_moyan;img_10309_xixi;img_10313_ciyuanshenglong01;img_10324_huangjinshenglong01;img_10326_chiyanlonghuang01",
		"img_10028_shengguangfeilong01;img_10097_moyan;img_10309_xixi;img_10313_ciyuanshenglong01;img_10324_huangjinshenglong01;img_10326_chiyanlonghuang01"
	}
}
local t_group_red_pack_cover = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_group_red_pack_cover.dataList = dataList

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

return t_group_red_pack_cover
