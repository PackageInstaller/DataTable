-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_expedition_grid_type.lua

module("logicconfig.config.t_expedition_grid_type", package.seeall)

local title = {
	gridId = 1,
	eventPic = 2,
	name = 3,
	eventId = 4
}
local dataList = {
	{
		1,
		"btn_sj_ptzd",
		"普通战斗",
		1
	},
	{
		2,
		"btn_sj_jy",
		"交易",
		6
	},
	{
		3,
		"btn_sj_yj",
		"援军",
		2
	},
	{
		4,
		"btn_sj_jyzd",
		"精英战斗",
		1
	},
	{
		5,
		"btn_sj_mwz",
		"魔王战",
		1
	},
	{
		6,
		"btn_sj_jy",
		"交易",
		6
	},
	{
		7,
		"btn_sj_yj",
		"援军",
		2
	},
	{
		8,
		"btn_sj_ptzd",
		"普通战斗",
		1
	},
	{
		9,
		"btn_sj_ptzd",
		"普通战斗",
		1
	},
	{
		10,
		"btn_sj_jyzd",
		"精英战斗",
		1
	},
	{
		11,
		"btn_sj_jy",
		"交易",
		6
	},
	{
		13,
		"btn_sj_yj",
		"援军",
		2
	},
	{
		14,
		"btn_sj_ptzd",
		"普通战斗",
		1
	},
	{
		15,
		"btn_sj_ptzd",
		"普通战斗",
		1
	},
	{
		16,
		"btn_sj_jy",
		"交易",
		6
	},
	{
		18,
		"btn_sj_yj",
		"援军",
		2
	},
	{
		19,
		"btn_sj_jy",
		"交易",
		6
	},
	{
		21,
		"btn_sj_yj",
		"援军",
		2
	},
	{
		22,
		"btn_sj_sgqs",
		"曙光泉水",
		5
	},
	{
		23,
		"btn_sj_sgqs",
		"曙光泉水",
		5
	},
	{
		24,
		"btn_sj_mwz",
		"魔王战",
		1
	}
}
local t_expedition_grid_type = {
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
	[13] = dataList[12],
	[14] = dataList[13],
	[15] = dataList[14],
	[16] = dataList[15],
	[18] = dataList[16],
	[19] = dataList[17],
	[21] = dataList[18],
	[22] = dataList[19],
	[23] = dataList[20],
	[24] = dataList[21]
}

t_expedition_grid_type.dataList = dataList

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

return t_expedition_grid_type
