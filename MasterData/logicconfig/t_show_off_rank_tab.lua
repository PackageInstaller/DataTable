-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_show_off_rank_tab.lua

module("logicconfig.config.t_show_off_rank_tab", package.seeall)

local title = {
	rankId = 2,
	tabName = 4,
	tabId = 1,
	memberId = 3,
	desc = 5
}
local dataList = {
	{
		1,
		1,
		0,
		"总榜",
		"提示：按拥有的精灵皮肤总数量排名，数量相同，则按上榜时间进行排名"
	},
	{
		9,
		3,
		10,
		"神话",
		"提示：按拥有的精灵神话皮肤数量排名，数量相同，则按上榜时间进行排名"
	},
	{
		2,
		3,
		8,
		"圣品",
		"提示：按拥有的精灵圣品皮肤数量排名，数量相同，则按上榜时间进行排名"
	},
	{
		4,
		3,
		6,
		"性转",
		"提示：按拥有的精灵性转皮肤数量排名，数量相同，则按上榜时间进行排名"
	},
	{
		8,
		3,
		9,
		"绝品",
		"提示：按拥有的精灵绝品皮肤数量排名，数量相同，则按上榜时间进行排名"
	},
	{
		3,
		3,
		7,
		"臻品",
		"提示：按拥有的精灵臻品皮肤数量排名，数量相同，则按上榜时间进行排名"
	},
	{
		5,
		3,
		5,
		"精品",
		"提示：按拥有的精灵精品皮肤数量排名，数量相同，则按上榜时间进行排名"
	},
	{
		6,
		3,
		3,
		"良品",
		"提示：按拥有的精灵良品皮肤数量排名，数量相同，则按上榜时间进行排名"
	},
	{
		7,
		2,
		0,
		"多人海报",
		"提示：按拥有的精灵多人海报数量排名，数量相同，则按上榜时间进行排名"
	}
}
local t_show_off_rank_tab = {
	dataList[1],
	[9] = dataList[2],
	dataList[3],
	[4] = dataList[4],
	[8] = dataList[5],
	dataList[6],
	[5] = dataList[7],
	[6] = dataList[8],
	[7] = dataList[9]
}

t_show_off_rank_tab.dataList = dataList

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

return t_show_off_rank_tab
