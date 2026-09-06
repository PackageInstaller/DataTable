-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_card.lua

module("logicconfig.config.t_beast_rich_man_card", package.seeall)

local title = {
	cardId = 2,
	cardParam = 4,
	cardName = 7,
	matStr = 5,
	canDirectUse = 8,
	name = 3,
	activityId = 1,
	cardDesc = 6
}
local dataList = {
	{
		558001,
		1,
		"神仙卡-狐仙",
		"2,10_3,10_4,20_5,30_6,30",
		"1004:1604:1",
		"使用后，落脚卡片格时，概率额外多获得一张卡片，通过狐仙卡额外获得的卡片不包含神仙卡，在交互完格子事件/固定建筑事件后才能使用",
		"神仙卡-狐仙",
		true
	},
	{
		558001,
		2,
		"神仙卡-句芒",
		"2,20",
		"1004:1605:1",
		"使用后，后续2次经过己方建筑时，收获的杂货铺收益增加20%，在交互完格子事件/固定建筑事件后才能使用",
		"神仙卡-句芒",
		true
	},
	{
		558001,
		3,
		"神仙卡-金乌",
		"",
		"1004:1606:1",
		"使用后，免疫后续1次税局征税，手动勾选使用",
		"神仙卡-金乌",
		false
	},
	{
		558001,
		4,
		"升级卡",
		"",
		"1004:1607:1",
		"无需费用，建筑直接升1级，在建筑升级时需选择使用，手动勾选使用",
		"升级卡",
		false
	},
	{
		558001,
		5,
		"停留卡",
		"",
		"1004:1608:1",
		"下一次投骰子时投出0步，可再次触发本格子的效果&对应建筑的效果，在交互完格子事件/固定建筑事件后才能使用",
		"停留卡",
		true
	},
	{
		558001,
		6,
		"乌龟卡",
		"2",
		"1004:1609:1",
		"使移动步数固定为1，持续2回合，在交互完格子事件/固定建筑事件后才能使用",
		"乌龟卡",
		true
	}
}
local t_beast_rich_man_card = {
	[558001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_beast_rich_man_card.dataList = dataList

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

return t_beast_rich_man_card
