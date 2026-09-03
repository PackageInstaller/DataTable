-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/HeroCardPool.lua

HeroCardPool = class("HeroCardPool")

function HeroCardPool:initialize()
	super.initialize(self)
end

function HeroCardPool:initWithData(arrdata)
	local cards = {}

	for i = 1, #arrdata do
		cards[i] = HeroCard:new(arrdata[i])
	end

	self:setupCardArray(cards)

	return self
end

function HeroCardPool:setupCardArray(cards)
	local cardArray = {}
	local len = #cards

	for i = 1, len do
		cardArray[i] = cards[len + 1 - i]
	end

	self._cardArray = cardArray
end

function HeroCardPool:getCardArray()
	return self._cardArray
end

function HeroCardPool:getCardById(heroId)
	for k, v in pairs(self._cardArray) do
		if v:getType() == CARD_TYPE.kHeroCard and v:getHeroData().id == heroId then
			return true
		end
	end

	return nil
end

function HeroCardPool:getTotalCount()
	return (self._cardArray ~= nil or nil) and (#self._cardArray or 0)
end

function HeroCardPool:getRemainedCount()
	if self._cardArray == nil then
		return 0
	end

	return #self._cardArray
end

function HeroCardPool:getFrontCard()
	local cardArray = self._cardArray

	if cardArray == nil then
		return nil
	end

	return cardArray[#cardArray]
end

function HeroCardPool:popFrontCard()
	local cardArray = self._cardArray

	if cardArray == nil then
		return nil
	end

	local card = cardArray[#cardArray]

	if card ~= nil then
		table.remove(cardArray)
	end

	self._usedCard = self._usedCard or {}
	self._usedCard[#self._usedCard + 1] = card

	return card
end

function HeroCardPool:removeCard(card, index)
	local index = index

	if not index or self._cardArray[index] ~= card then
		for i, heroCard in ipairs(self._cardArray) do
			if card == heroCard then
				index = i

				break
			end
		end
	end

	if index then
		table.remove(self._cardArray, index)

		self._usedCard = self._usedCard or {}
		self._usedCard[#self._usedCard + 1] = card

		return true, index == #self._cardArray + 1
	end
end

function HeroCardPool:insertCardByInfo(cardInfo)
	local card = HeroCard:new(cardInfo)

	table.insert(self._cardArray, card)

	return card
end

function HeroCardPool:repleaceCard(card, index)
	self._cardArray[index] = card

	return card
end

function HeroCardPool:insertCard(card, index)
	if self._cardArray ~= nil then
		if index then
			if index > 0 then
				table.insert(self._cardArray, index, card)
			else
				table.insert(self._cardArray, #self._cardArray + index, card)
			end
		else
			table.insert(self._cardArray, card)
		end
	end

	return card
end

SkillCardPool = class("SkillCardPool", HeroCardPool)

function SkillCardPool:initWithData(arrdata)
	local cards = {}

	for i = 1, #arrdata do
		local widget = arrdata[i].weight

		for j = 1, widget do
			cards[#cards + 1] = SkillCard:new(arrdata[i])
		end
	end

	self:setupCardArray(cards)

	return self
end

local function shuffle(rand, arr, start, ending)
	local m = start or 1
	local n = ending or #arr

	for i = m, n - 1 do
		local k = rand:random(i, n)

		if k ~= i then
			arr[i], arr[k] = arr[k], arr[i]
		end
	end
end

function SkillCardPool:insertCard(card, index)
	if self._cardArray ~= nil then
		if index then
			if index > 0 then
				table.insert(self._cardArray, index, card)
			else
				table.insert(self._cardArray, #self._cardArray + index, card)
			end
		else
			table.insert(self._cardArray, card)
		end
	end

	return card
end

function SkillCardPool:shuffle(rand)
	if self._cardArray ~= nil then
		shuffle(rand, self._cardArray)
	end
end

function SkillCardPool:getRandomCard(rand)
	if self._cardArray ~= nil then
		local n = #self._cardArray
		local k = rand:random(1, n)

		return self._cardArray[k]
	end
end

ExtraCardPool = class("ExtraCardPool", HeroCardPool)

function ExtraCardPool:setupCardArray(cards)
	if not self._cardArray then
		local len = #cards

		for i = 1, len do
			self._cardArray[#self._cardArray + i] = cards[len + 1 - i]
		end

		self._cardArray = self._cardArray
	end
end

function ExtraCardPool:addHeroCard(arrdata)
	local cards = {}

	for i = 1, #arrdata do
		cards[i] = HeroCard:new(arrdata[i])
	end

	self:setupCardArray(cards)
end

function ExtraCardPool:addSkillCard(arrdata)
	local cards = {}

	for i = 1, #arrdata do
		local widget = arrdata[i].weight

		for j = 1, widget do
			cards[#cards + 1] = SkillCard:new(arrdata[i])
		end
	end

	self:setupCardArray(cards)

	return self
end

function ExtraCardPool:getCardAtIndex(index)
	if self._cardArray ~= nil then
		return self._cardArray[index]
	end
end
