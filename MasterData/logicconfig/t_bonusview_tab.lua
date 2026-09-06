-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bonusview_tab.lua

module("logicconfig.config.t_bonusview_tab", package.seeall)

local title = {
	tabName = 2,
	tagName = 3,
	tagColor = 4,
	tabId = 1
}
local dataList = {
	{
		1,
		"基础福利",
		"",
		0
	},
	{
		2,
		"战令",
		"",
		0
	},
	{
		3,
		"送满觉醒精灵",
		"",
		0
	},
	{
		4,
		"回归好礼",
		"",
		0
	},
	{
		5,
		"资源找回",
		"",
		0
	},
	{
		6,
		"兑换码",
		"",
		0
	},
	{
		7,
		"完善信息",
		"",
		0
	},
	{
		8,
		"明星战队计划",
		"",
		0
	},
	{
		9,
		"版本福利",
		"",
		0
	},
	{
		10,
		"版本前瞻",
		"",
		0
	},
	{
		11,
		"暑假狂欢",
		"",
		0
	},
	{
		12,
		"版本特权",
		"送金钻",
		2
	},
	{
		13,
		"常驻福利",
		"",
		0
	},
	{
		14,
		"战令",
		"",
		0
	},
	{
		15,
		"送满觉",
		"",
		0
	},
	{
		16,
		"乱涂一下",
		"",
		0
	},
	{
		17,
		"兑换码",
		"",
		0
	}
}
local t_bonusview_tab = {
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

t_bonusview_tab.dataList = dataList

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

return t_bonusview_tab
