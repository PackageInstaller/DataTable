-- chunkname: @modules/logic/activitywelfare/model/DestinyStoneGiftPickChoiceModel.lua

module("modules.logic.activitywelfare.model.DestinyStoneGiftPickChoiceModel", package.seeall)

local DestinyStoneGiftPickChoiceModel = class("DestinyStoneGiftPickChoiceModel", BaseModel)

function DestinyStoneGiftPickChoiceModel:onInit()
	self:reInit()
end

function DestinyStoneGiftPickChoiceModel:reInit()
	self._curSelectHeroId = 0
	self._curPreviewHeroId = 0
end

function DestinyStoneGiftPickChoiceModel:getAllDestinyHeroList()
	local list = {}
	local destinyList = CharacterDestinyConfig.instance:getAllDestinyConfigList()

	for _, destiny in pairs(destinyList) do
		local destinys = self:getHeroDestinys(destiny.heroId)

		if destinys and #destinys > 0 then
			table.insert(list, destiny.heroId)
		end
	end

	return list
end

function DestinyStoneGiftPickChoiceModel:getAllPreviewHeroList(itemId)
	itemId = itemId or DestinyStoneGiftPickChoiceEnum.V3a8ItemId

	local allHeroList = self:getAllDestinyHeroList()
	local itemCo = ItemConfig.instance:getItemCo(itemId)

	if not itemCo or string.nilorempty(itemCo.effect) then
		return allHeroList
	end

	local effArr = string.split(itemCo.effect, "|")

	if not effArr or #effArr < 3 then
		return allHeroList
	end

	local heroList = {}
	local heroArr = string.splitToNumber(effArr[3], "#")

	for _, heroId in ipairs(heroArr) do
		table.insert(heroList, heroId)
	end

	return heroList
end

function DestinyStoneGiftPickChoiceModel:isAllHeroDestinyLvMaxed(itemId)
	itemId = itemId or DestinyStoneGiftPickChoiceEnum.V3a8ItemId

	local heroList = self:getAllPreviewHeroList(itemId)

	for _, heroId in pairs(heroList) do
		local heroMo = HeroModel.instance:getByHeroId(heroId)

		if not heroMo then
			return false
		end

		if heroMo.destinyStoneMo then
			local isSlotMaxLevel = heroMo.destinyStoneMo:isSlotMaxLevel()

			if heroMo.destinyStoneMo then
				local stoneList = heroMo.destinyStoneMo:getStoneMoList()

				if not isSlotMaxLevel then
					return false
				else
					for _, stoneMo in pairs(stoneList) do
						local isIgnore = self:isIgnoreDestiny(stoneMo.stoneId)

						if not stoneMo.isUnlock and not isIgnore then
							return false
						end
					end
				end
			end
		end
	end

	return true
end

function DestinyStoneGiftPickChoiceModel:isHeroOpenDestinyStone(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if not heroMo or not heroMo:isHasDestinySystem() then
		return false
	end

	if not heroMo.config.rare then
		local rare = 5
		local constId = CharacterDestinyEnum.DestinyStoneOpenLevelConstId[rare]
		local openLevel = CommonConfig.instance:getConstStr(constId)

		if heroMo.level >= tonumber(openLevel) then
			return true
		end

		return false
	end
end

function DestinyStoneGiftPickChoiceModel:isIgnoreDestiny(destinyId, itemId)
	itemId = itemId or DestinyStoneGiftPickChoiceEnum.V3a8ItemId

	local itemCo = ItemConfig.instance:getItemCo(itemId)

	if not itemCo or string.nilorempty(itemCo.effect) then
		return false
	end

	local effArr = string.split(itemCo.effect, "|")

	if not effArr or #effArr < 2 then
		return false
	end

	local destinyArr = string.splitToNumber(effArr[2], "#")

	for _, id in ipairs(destinyArr) do
		if id == destinyId then
			return true
		end
	end

	return false
end

function DestinyStoneGiftPickChoiceModel:getIgnoreIds(itemId)
	itemId = itemId or DestinyStoneGiftPickChoiceEnum.V3a8ItemId

	local itemConfig = ItemConfig.instance:getItemCo(itemId)
	local effect = itemConfig.effect
	local ignoreIds = {}

	if not string.nilorempty(effect) then
		local _split = GameUtil.splitString2(effect, true)

		if _split[2] then
			ignoreIds = _split[2]
		end
	end

	return ignoreIds
end

function DestinyStoneGiftPickChoiceModel:getHeroDestinys(heroId)
	local destinyCfg = CharacterDestinyConfig.instance:getHeroDestiny(heroId)

	if not destinyCfg or string.nilorempty(destinyCfg.facetsId) then
		return {}
	end

	local resultDestinyIds = {}
	local destinyIds = string.splitToNumber(destinyCfg.facetsId, "#")

	for _, destinyId in ipairs(destinyIds) do
		local isIgnore = self:isIgnoreDestiny(destinyId)

		if not isIgnore then
			table.insert(resultDestinyIds, destinyId)
		end
	end

	return resultDestinyIds
end

local function sortOwnHeroFunc(a, b)
	local aAestinyStoneMo = a.heroMo.destinyStoneMo
	local bAestinyStoneMo = b.heroMo.destinyStoneMo
	local aUnlockSlot = aAestinyStoneMo:isUnlockSlot() and 1 or 2
	local bUnlockSlot = bAestinyStoneMo:isUnlockSlot() and 1 or 2

	if aUnlockSlot ~= bUnlockSlot then
		return bUnlockSlot < aUnlockSlot
	end

	local aRank = aAestinyStoneMo.rank
	local bRank = bAestinyStoneMo.rank

	if aRank ~= bRank then
		return aRank < bRank
	end

	return a.heroId > b.heroId
end

local function sortNotOwnHeroFunc(a, b)
	if a.heroId ~= b.heroId then
		return a.heroId > b.heroId
	end

	return a.stoneId > b.stoneId
end

function DestinyStoneGiftPickChoiceModel:getStoneListByType(type, itemId)
	itemId = itemId or DestinyStoneGiftPickChoiceEnum.V3a8ItemId

	local couldLvList = {}
	local lockList = {}
	local notOwnList = {}
	local stoneMaxList = {}
	local heroList = self:getAllPreviewHeroList(itemId)

	for _, heroId in pairs(heroList) do
		local heroMo = HeroModel.instance:getByHeroId(heroId)
		local destinys = self:getHeroDestinys(heroId)

		if not heroMo then
			for _, destiny in pairs(destinys) do
				local mo = {}

				mo.heroId = heroId
				mo.stoneId = destiny

				table.insert(notOwnList, mo)
			end
		else
			local destinyStoneMo = heroMo.destinyStoneMo
			local list = destinyStoneMo:getStoneMoList()
			local isMax = destinyStoneMo:isSlotMaxLevel()
			local isOpenDestinyStone = self:isHeroOpenDestinyStone(heroId)

			for _, destiny in pairs(destinys) do
				local mo = {}

				mo.heroId = heroId
				mo.heroMo = heroMo
				mo.stoneId = destiny

				local ownedStone

				for _, stoneMo in pairs(list) do
					if stoneMo.stoneId == destiny then
						ownedStone = stoneMo
					end
				end

				if not ownedStone then
					table.insert(notOwnList, mo)
				else
					mo.stoneMo = ownedStone

					local isUnlock = ownedStone.isUnlock
					local couldLvUp = isOpenDestinyStone

					if isMax then
						couldLvUp = couldLvUp and not isUnlock
					end

					if couldLvUp then
						table.insert(couldLvList, mo)
					elseif not isUnlock then
						table.insert(lockList, mo)
					else
						table.insert(stoneMaxList, mo)
					end
				end
			end
		end
	end

	if type == DestinyStoneGiftPickChoiceEnum.HeroStoneType.OwnHeroStoneCouldUp then
		table.sort(couldLvList, sortOwnHeroFunc)

		return couldLvList
	elseif type == DestinyStoneGiftPickChoiceEnum.HeroStoneType.OwnHeroStoneLocked then
		table.sort(lockList, sortOwnHeroFunc)

		return lockList
	elseif type == DestinyStoneGiftPickChoiceEnum.HeroStoneType.NotOwnHeroStone then
		table.sort(notOwnList, sortNotOwnHeroFunc)

		return notOwnList
	elseif type == DestinyStoneGiftPickChoiceEnum.HeroStoneType.OwnHeroStoneMax then
		table.sort(stoneMaxList, sortOwnHeroFunc)

		return stoneMaxList
	end

	return {}
end

function DestinyStoneGiftPickChoiceModel:setCurrentSelectStoneMo(stoneId, type, stoneMo)
	self._curStoneId = stoneId
	self._curStoneType = type
	self._curStoneMo = stoneMo
end

function DestinyStoneGiftPickChoiceModel:getCurrentSelectStoneId()
	return self._curStoneId
end

function DestinyStoneGiftPickChoiceModel:getCurrentSelectStoneMo()
	return self._curStoneMo
end

function DestinyStoneGiftPickChoiceModel:getCurrentSelectStoneType()
	return self._curStoneType
end

DestinyStoneGiftPickChoiceModel.instance = DestinyStoneGiftPickChoiceModel.New()

return DestinyStoneGiftPickChoiceModel
