-- chunkname: @modules/logic/sodache/model/SodacheCardSelectMo.lua

module("modules.logic.sodache.model.SodacheCardSelectMo", package.seeall)

local SodacheCardSelectMo = class("SodacheCardSelectMo")

function SodacheCardSelectMo:ctor()
	self.canSelectCards = {}
	self.selectCount = 0
	self.totalSelectCount = 0
	self.isMultSelect = false
	self.selectCallback = nil
	self.selectCallobj = nil
	self.selectCards = {}
	self.recommendList = nil
	self.choiceCo = nil
end

function SodacheCardSelectMo:clearSelect()
	self.selectCount = 0

	tabletool.clear(self.selectCards)
end

function SodacheCardSelectMo:addItemCount(itemId, count)
	if not self.isMultSelect then
		tabletool.clear(self.selectCards)

		if count > 0 then
			self.selectCards[itemId] = count
		end

		self.selectCount = count
	else
		if count + self.selectCount > self.totalSelectCount then
			GameFacade.showToast(ToastEnum.SodacheToastId373017)

			return false
		end

		local newCount = count + (self.selectCards[itemId] or 0)

		if newCount < 0 then
			return false
		end

		self.selectCards[itemId] = newCount > 0 and newCount or nil
		self.selectCount = self.selectCount + count
	end

	return true
end

function SodacheCardSelectMo:getItemSelectCount(itemId)
	return self.selectCards[itemId] or 0
end

function SodacheCardSelectMo:setCanSelectCards(cardType, bagType)
	local bagMo = SodacheModel.instance:getOutsideMo():getBag(bagType or SodacheEnum.BagType.Outside)

	self:setCards(bagMo:getItemsByCardType(cardType))
end

function SodacheCardSelectMo:setCards(source)
	local cards = {}
	local itemDict = {}

	for i, v in ipairs(source) do
		if not itemDict[v.configId] then
			itemDict[v.configId] = SodacheCardMo.Create(v.configId, v.count)

			table.insert(cards, itemDict[v.configId])
		else
			itemDict[v.configId].serverMo.count = itemDict[v.configId].serverMo.count + v.count
		end
	end

	self.canSelectCards = cards
end

return SodacheCardSelectMo
