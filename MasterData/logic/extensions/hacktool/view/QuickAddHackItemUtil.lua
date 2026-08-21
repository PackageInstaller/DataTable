-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/QuickAddHackItemUtil.lua

module("logic.extensions.hacktool.view.QuickAddHackItemUtil", package.seeall)

local QuickAddHackItemUtil = class("QuickAddHackItemUtil")
local hackType = {
	GameEnum.ItemTypeEnum.PropItemType,
	GameEnum.ItemTypeEnum.EquipItemType,
	GameEnum.ItemTypeEnum.CurrencyItemType,
	GameEnum.ItemTypeEnum.EchoItemType,
	GameEnum.ItemTypeEnum.HeroItemType,
	GameEnum.ItemTypeEnum.HouseItemType,
	GameEnum.ItemTypeEnum.ProtomerItemType,
	GameEnum.ItemTypeEnum.FurnitureItemType,
	GameEnum.ItemTypeEnum.RoguelikeEquipType,
	GameEnum.ItemTypeEnum.Portrait,
	GameEnum.ItemTypeEnum.DisplayCard,
	GameEnum.ItemTypeEnum.RoguelikeClueType,
	GameEnum.ItemTypeEnum.HeroSkin,
	GameEnum.ItemTypeEnum.TreasureBox,
	GameEnum.ItemTypeEnum.DiceItem,
	GameEnum.ItemTypeEnum.PuzzlePiecesItem
}

function QuickAddHackItemUtil:ctor()
	self._itemDict = {}
end

function QuickAddHackItemUtil:init()
	for _, type in ipairs(hackType) do
		local conf = BackpackConfig.instance:getItemsInfoByType(type)

		for _, item in pairs(conf) do
			table.insert(self._itemDict, item)
		end
	end

	local info = PastInfoConfig.instance:getCharacterInfoList()

	for _, item in pairs(info) do
		table.insert(self._itemDict, item)
	end

	return self._itemDict
end

function QuickAddHackItemUtil:filter(text)
	local res = {}

	if #self._itemDict == 0 then
		self:init()
	end

	for _, item in pairs(self._itemDict) do
		if string.find(item.name, text) or string.find(item.id, text) then
			table.insert(res, {
				name = item.name,
				id = item.id
			})
		end
	end

	return res
end

QuickAddHackItemUtil.instance = QuickAddHackItemUtil.New()

return QuickAddHackItemUtil
