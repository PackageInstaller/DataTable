-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_defend_carrot_map_cell.lua

module("logicconfig.config.t_defend_carrot_map_cell", package.seeall)

local title = {
	params = 4,
	cellId = 1,
	resPath = 2,
	type = 3
}
local dataList = {
	{
		1,
		"",
		0,
		""
	},
	{
		2,
		"board_chuguaikou",
		1,
		""
	},
	{
		3,
		"board_xiaoaoqi",
		3,
		""
	},
	{
		4,
		"board_zhangaiwu_01",
		4,
		"100#100"
	},
	{
		5,
		"board_zhangaiwu_01",
		4,
		"200#150"
	},
	{
		6,
		"board_zhangaiwu_01",
		4,
		"300#200"
	},
	{
		7,
		"board_zhangaiwu_02",
		5,
		""
	},
	{
		8,
		"board_dikuai_01",
		2,
		""
	},
	{
		9,
		"board_dikuai_02",
		2,
		""
	},
	{
		10,
		"board_dikuai_03",
		2,
		""
	},
	{
		11,
		"board_dikuai_04",
		2,
		""
	},
	{
		12,
		"board_dikuai_05",
		2,
		""
	},
	{
		13,
		"board_dikuai_06",
		2,
		""
	},
	{
		14,
		"board_dikuai_07",
		2,
		""
	},
	{
		15,
		"board_dikuai_08",
		2,
		""
	},
	{
		16,
		"board_dikuai_09",
		2,
		""
	},
	{
		17,
		"board_dikuai_10",
		2,
		""
	}
}
local t_defend_carrot_map_cell = {
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
	dataList[17]
}

t_defend_carrot_map_cell.dataList = dataList

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

return t_defend_carrot_map_cell
