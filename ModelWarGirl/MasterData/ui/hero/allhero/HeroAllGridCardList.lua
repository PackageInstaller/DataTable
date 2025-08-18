-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\AllHero\\HeroAllGridCardList.lua

local AllHeroGridCard = Class("AllHeroGridCard", UIControls.HeroCardLoop)

function AllHeroGridCard:setData(hero, idx)
	if self.idx then
		self.mWindow.heroGridCardList.cards[self.idx] = nil
	end

	self.idx = idx

	self:setHero(hero)
	self:setSelected(self.mWindow.selectedHero ~= nil and self.hero.id == self.mWindow.selectedHero.id)
end

function AllHeroGridCard:setSelected(isSelected)
	self.beSelected = isSelected

	self.btnSelf:setEnable(self.beSelected == false)
	self.imgSel:setVisible(self.beSelected == true)

	if self.beSelected == true then
		self.mWindow:setSelectHero(self.hero, self.idx)
	end
end

local strClassName = "HeroAllGridCardList"
local HeroAllGridCardList = Class(strClassName, UIControls.Panel)
local HeroGridCardPrefab = "System/Hero/GridHeroCard"

function HeroAllGridCardList:ctor()
	self:_initUI()
end

function HeroAllGridCardList:_initUI()
	self.view = UIControls.ScrollViewLoopV(self, self.mPath, 0, self._initItem)
	self.cards = {}
	self.idMapCards = {}

	if CurAvatar then
		self.currentEntity = CurAvatar
	end
end

function HeroAllGridCardList:_initItem(sender, targetCell, newIdx)
	targetCell = targetCell or AllHeroGridCard(sender, HeroGridCardPrefab, 0, 0, newIdx)

	if not self.cardItemList or #self.cardItemList == 0 then
		return
	end

	if self.cardItemList[newIdx] ~= nil then
		targetCell:setData(self.cardItemList[newIdx], newIdx)
		targetCell:setSelectCallback(Slot(self.heroCardBeSelect, self))
	end

	self.cards[newIdx] = targetCell
	self.idMapCards[self.cardItemList[newIdx].id] = newIdx
end

function HeroAllGridCardList:heroCardBeSelect(card)
	for i, v in pairs(self.cards) do
		self.cards[i]:setSelected(self.cards[i].idx == card.idx)
	end
end

function HeroAllGridCardList:setClickCardByIdx(idx, id)
	if idx and self.cards[idx] then
		self.cards[idx]:onBtnSelect(self.cards[idx])
	elseif #self.cardItemList > 0 then
		self:setData(self.cardItemList, id, idx)

		if idx then
			self.cards[idx]:onBtnSelect(self.cards[idx])
		else
			local gidIdx = self.idMapCards[id] or 1

			self.cards[gidIdx]:onBtnSelect(self.cards[gidIdx])
		end
	end
end

function HeroAllGridCardList:setClickCardByGid(id)
	local idx = self.idMapCards[id]

	self:setClickCardByIdx(idx, id)
end

function HeroAllGridCardList:setClickCardByResId(heroId)
	for idx, card in ipairs(self.cards) do
		if card.hero.id == heroId then
			self:setClickCardByIdx(idx)
		end
	end
end

local HERO_CARD_COLUMN_COUNT = 3
local HERO_CARD_ROW_COUNT = 3

function HeroAllGridCardList:setData(data, selectId, selectIndex)
	self.idMapCards = {}
	self.cardItemList = data

	local startIdx = selectIndex or 1

	if selectIndex then
		self.view:setTotalCountAndRefillCells(#self.cardItemList, startIdx)
	elseif selectId then
		local cardCount = #self.cardItemList

		for i = 1, cardCount do
			if selectId and selectId == self.cardItemList[i].id then
				startIdx = i

				break
			end
		end

		if startIdx > 9 then
			local tempIndex = startIdx % HERO_CARD_ROW_COUNT == 0 and startIdx - 1 or startIdx

			startIdx = math.floor(tempIndex / HERO_CARD_ROW_COUNT) * HERO_CARD_COLUMN_COUNT + 1

			local totalRow = math.ceil(#self.cardItemList / HERO_CARD_COLUMN_COUNT)

			startIdx = math.min((totalRow - (HERO_CARD_COLUMN_COUNT - 1)) * HERO_CARD_ROW_COUNT - (HERO_CARD_ROW_COUNT - 1), startIdx)
		else
			startIdx = 1
		end

		self.view:setTotalCountAndRefillCells(#self.cardItemList, startIdx)
	else
		self.view:setTotalCountAndRefillCells(#self.cardItemList)
	end

	return startIdx
end

return HeroAllGridCardList
