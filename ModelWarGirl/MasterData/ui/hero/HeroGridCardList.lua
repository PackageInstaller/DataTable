-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroGridCardList.lua

local strClassName = "HeroGridCardList"
local HeroGridCardList = Class(strClassName, UIControls.Panel)
local HeroGridCardPrefab = "System/Hero/GridHeroCard"
local HeroGridCard = require("UI/Hero/Grid/HeroGridCard")
local RookieFocusChild = require("Logic/Beginner/RookieFocusChild")

function HeroGridCardList:ctor()
	self:_initUI()
end

function HeroGridCardList:_initUI()
	self.view = UIControls.ScrollViewLoopV(self, self.mPath, 0, self._initItem)
	self.cards = {}
	self.gidMapCards = {}

	if CurAvatar then
		self.currentEntity = CurAvatar
	end
end

function HeroGridCardList:_initItem(sender, targetCell, newIdx)
	targetCell = targetCell or HeroGridCard(sender, HeroGridCardPrefab, newIdx)

	if not self.cardItemList or #self.cardItemList == 0 then
		return
	end

	if self.cardItemList[newIdx] ~= nil then
		targetCell:setData(self.cardItemList[newIdx], newIdx)
		targetCell:setSelectCallback(Slot(self.heroCardBeSelect, self))

		if self.focusOneHero then
			if self.focusOneHero == newIdx then
				self:createCardFocusChild(targetCell)
			elseif targetCell.focusChild then
				targetCell.focusChild:setVisible(false)
			end
		end
	end

	self.cards[newIdx] = targetCell
	self.gidMapCards[self.cardItemList[newIdx].gid] = newIdx
end

function HeroGridCardList:heroCardBeSelect(card)
	for i, v in pairs(self.cards) do
		self.cards[i]:setSelected(i == card.idx)
	end

	self.view:setTotalCount(#self.cardItemList)
end

function HeroGridCardList:setClickCardByIdx(idx, gid)
	if idx and self.cards[idx] and self.cards[idx].idx == idx then
		self.cards[idx]:onBtnSelect(self.cards[idx])
	elseif #self.cardItemList > 0 then
		self:setData(self.cardItemList, gid, idx)

		if idx then
			self.cards[idx]:onBtnSelect(self.cards[idx])
		else
			local gidIdx = self.gidMapCards[gid] or 1

			self.cards[gidIdx]:onBtnSelect(self.cards[gidIdx])
		end
	end
end

function HeroGridCardList:setClickCardByGid(gid)
	local idx = self.gidMapCards[gid]

	self:setClickCardByIdx(idx, gid)
end

function HeroGridCardList:setClickCardByResId(heroId)
	if self.cardItemList and #self.cardItemList ~= 0 then
		for idx, hero in ipairs(self.cardItemList) do
			if hero.id == heroId then
				self:setClickCardByGid(hero.gid)
			end
		end
	else
		coroutine.start(self.yieldSetClickCardByResId, self, heroId)
	end
end

function HeroGridCardList:setClickCardUniqueHero()
	if self.cardItemList and #self.cardItemList ~= 0 then
		for idx, hero in ipairs(self.cardItemList) do
			if hero:isUniqueHero() then
				self:setClickCardByGid(hero.gid)
			end
		end
	else
		coroutine.start(self.yieldSetClickCardUniqueHero, self)
	end
end

local function sortForReset(a, b)
	if a.star ~= b.star then
		return a.star < b.star
	elseif a.level ~= b.level then
		return a.level > b.level
	elseif a.id ~= b.id then
		return a.id > b.id
	else
		return a.gid > b.gid
	end
end

function HeroGridCardList:setClickCardForReset()
	if self.cardItemList and #self.cardItemList ~= 0 then
		self:_clickCardForReset()
	else
		coroutine.start(self.yieldSetClickCardForReset, self)
	end
end

function HeroGridCardList:_clickCardForReset()
	local canResetCards = {}

	if self.cardItemList then
		for idx, hero in ipairs(self.cardItemList) do
			if hero.realLevel > 1 and not CurAvatar:heroInFormation(hero.gid, Const.FORMATION_MAIN_STAGE) then
				table.insert(canResetCards, hero)
			end
		end

		table.sort(canResetCards, sortForReset)

		if #canResetCards > 0 then
			self:setClickCardByGid(canResetCards[1].gid)
		end
	end
end

function HeroGridCardList:yieldSetClickCardByResId(heroId)
	coroutine.step()

	if self.cardItemList then
		for idx, hero in ipairs(self.cardItemList) do
			if hero.id == heroId then
				self:setClickCardByGid(hero.gid)
			end
		end
	end
end

function HeroGridCardList:yieldSetClickCardUniqueHero()
	coroutine.step()

	if self.cardItemList then
		for idx, hero in ipairs(self.cardItemList) do
			if hero:isUniqueHero() then
				self:setClickCardByGid(hero.gid)
			end
		end
	end
end

function HeroGridCardList:yieldSetClickCardForReset()
	coroutine.step()
	self:_clickCardForReset()
end

local HERO_CARD_COLUMN_COUNT = 3
local HERO_CARD_ROW_COUNT = 3

function HeroGridCardList:setData(data, selectGid, selectIndex)
	self.gidMapCards = {}
	self.cards = {}
	self.cardItemList = data

	local startIdx = selectIndex or 1

	if selectIndex then
		startIdx = self:getStartIndex(startIdx)

		self.view:setTotalCount(#self.cardItemList, startIdx)
	elseif selectGid then
		local cardCount = #self.cardItemList

		for i = 1, cardCount do
			if selectGid and selectGid == self.cardItemList[i].gid then
				startIdx = i

				break
			end
		end

		startIdx = self:getStartIndex(startIdx)

		self.view:setTotalCount(#self.cardItemList, startIdx)
	else
		self.view:setTotalCount(#self.cardItemList, 1)
	end

	self.mWindow.panelBgNone:setVisible(#self.cardItemList <= 0)

	return startIdx
end

function HeroGridCardList:getStartIndex(startIdx)
	if startIdx > 9 then
		local tempIndex = startIdx % HERO_CARD_ROW_COUNT == 0 and startIdx - 1 or startIdx

		startIdx = math.floor(tempIndex / HERO_CARD_ROW_COUNT) * HERO_CARD_COLUMN_COUNT + 1

		local totalRow = math.ceil(#self.cardItemList / HERO_CARD_COLUMN_COUNT)

		startIdx = math.min((totalRow - (HERO_CARD_COLUMN_COUNT - 1)) * HERO_CARD_ROW_COUNT - (HERO_CARD_ROW_COUNT - 1), startIdx)
	else
		startIdx = 1
	end

	return startIdx
end

function HeroGridCardList:beginnerFocusOneHero(hero)
	if self.focusOneHero then
		for index, card in pairs(self.cards) do
			if card.focusChild then
				card.focusChild:setVisible(false)
			end
		end
	end

	self.focusOneHero = nil

	if hero and self.cardItemList then
		local heroIdx

		for index, listHero in ipairs(self.cardItemList) do
			if listHero.gid == hero.gid then
				heroIdx = index

				break
			end
		end

		if heroIdx then
			self.focusOneHero = heroIdx

			if self.cards[self.focusOneHero] then
				self:createCardFocusChild(self.cards[self.focusOneHero])
			end
		end
	end
end

function HeroGridCardList:createCardFocusChild(card)
	if not card.focusChild then
		card.focusChild = RookieFocusChild(card, "", "System/PlayerGuide/HighLightPanel", 0, 0)

		card.focusChild:focus(card.btnSelf:getComObj().transform, Const.BEGINNER_LOSE_NOTICE[4])
	end

	card.focusChild:setVisible(true)
end

function HeroGridCardList:clearCardEffectCor()
	for _, card in pairs(self.cards) do
		card:stopUIEffect()
	end
end

return HeroGridCardList
