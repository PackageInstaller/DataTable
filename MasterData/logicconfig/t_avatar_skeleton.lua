-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_avatar_skeleton.lua

module("logicconfig.config.t_avatar_skeleton", package.seeall)

local title = {
	id = 1,
	asset = 2,
	dressDefault = 5,
	type = 4,
	role_scale = 3
}
local dataList = {
	{
		1,
		"70003_aoqinv_luomo",
		1,
		1,
		"100902#999901#999902#999903"
	},
	{
		2,
		"70000_aoqinan_luomo",
		1,
		1,
		"1000001#1000002#1000003#1000004"
	},
	{
		3,
		"10358_zhuzhuxia",
		1,
		2,
		"1035801#1035802"
	},
	{
		4,
		"10450_cj_xiaonuo",
		1,
		2,
		""
	},
	{
		5,
		"10451_cj_arui",
		1,
		2,
		""
	},
	{
		6,
		"10452_cj_axiu",
		1,
		2,
		""
	},
	{
		7,
		"10453_cj_xiaotian",
		1,
		2,
		""
	},
	{
		8,
		"10454_cj_xiaoyan",
		1,
		2,
		""
	},
	{
		9,
		"10323_pet_lsq",
		1,
		2,
		""
	},
	{
		10,
		"2000_pet_llc",
		1,
		2,
		""
	},
	{
		11,
		"10327_pet_pdl",
		1,
		2,
		""
	},
	{
		12,
		"10328_pet_my",
		1,
		2,
		""
	},
	{
		13,
		"10329_pet_ny",
		1,
		2,
		""
	},
	{
		14,
		"10332_pet_fbb",
		1,
		2,
		""
	},
	{
		15,
		"10333_pet_xyl",
		1,
		2,
		""
	},
	{
		16,
		"10334_pet_xx",
		1,
		2,
		""
	},
	{
		17,
		"10326_pet_ylsb",
		1,
		2,
		""
	},
	{
		18,
		"10324_pet_xe",
		1,
		2,
		""
	},
	{
		19,
		"10325_pet_blw",
		1,
		2,
		""
	},
	{
		20,
		"10335_cdxn",
		1,
		2,
		""
	},
	{
		21,
		"10336_pet_ar",
		1,
		2,
		""
	},
	{
		101,
		"xn_luomo",
		1,
		3,
		"20010101#20010105#20010106#20010108"
	},
	{
		102,
		"xy_luomo",
		1,
		3,
		"20020101#20020106"
	},
	{
		201,
		"20001_cute_baobaolong",
		3.2,
		4,
		""
	},
	{
		202,
		"20002_cute_haibulan",
		3.2,
		4,
		""
	},
	{
		203,
		"20003_cute_sanyeshou",
		2.8,
		4,
		""
	},
	{
		204,
		"20004_cute_xl",
		2.5,
		4,
		""
	},
	{
		205,
		"20005_cute_xiaofuyao",
		2.8,
		4,
		""
	},
	{
		206,
		"20006_cute_xiaochiyao",
		2.8,
		4,
		""
	},
	{
		207,
		"20007_cute_xiaonuo",
		2.7,
		4,
		""
	},
	{
		208,
		"20008_cute_xiaonuo",
		2.7,
		4,
		""
	},
	{
		209,
		"20009_cute_xiaonuo",
		2.7,
		4,
		""
	},
	{
		210,
		"20010_cute_xiaoyan",
		2.7,
		4,
		""
	},
	{
		211,
		"20011_cute_xiaoyan",
		2.7,
		4,
		""
	},
	{
		212,
		"20012_cute_xiaoyan",
		2.7,
		4,
		""
	},
	{
		213,
		"20013_cute_anheimm",
		2.7,
		4,
		""
	},
	{
		214,
		"20014_cute_duolamm",
		3.2,
		4,
		""
	},
	{
		215,
		"20015_cute_wangzhemm",
		3.4,
		4,
		""
	},
	{
		216,
		"20016_cute_aixinmm",
		3.2,
		4,
		""
	},
	{
		217,
		"20017_cute_lianjinmm",
		3.2,
		4,
		""
	},
	{
		218,
		"20018_cute_rexuemm",
		3.4,
		4,
		""
	}
}
local t_avatar_skeleton = {
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
	[101] = dataList[22],
	[102] = dataList[23],
	[201] = dataList[24],
	[202] = dataList[25],
	[203] = dataList[26],
	[204] = dataList[27],
	[205] = dataList[28],
	[206] = dataList[29],
	[207] = dataList[30],
	[208] = dataList[31],
	[209] = dataList[32],
	[210] = dataList[33],
	[211] = dataList[34],
	[212] = dataList[35],
	[213] = dataList[36],
	[214] = dataList[37],
	[215] = dataList[38],
	[216] = dataList[39],
	[217] = dataList[40],
	[218] = dataList[41]
}

t_avatar_skeleton.dataList = dataList

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

return t_avatar_skeleton
