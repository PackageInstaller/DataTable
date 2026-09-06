-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/model/ItemBagModel.lua

module("logic.extensions.itembag.model.ItemBagModel", package.seeall)

local ItemBagModel = class("ItemBagModel", BaseModel)

ItemBagModel.UPDATE_SELECT_ITEM = "itembagmodel_update_select_item"

function ItemBagModel:ctor()
	return
end

function ItemBagModel:onInit()
	self:onReset()
end

function ItemBagModel:onReset()
	self.curTabIdx = nil
	self.curItem = nil
	self._petStartLine = nil
	self._incrCapacityPetGap = nil
	self._gapAddPercent = nil
	self._maxCapacity = nil
end

function ItemBagModel:setCurrTabIdx(idx)
	self.curTabIdx = idx
end

function ItemBagModel:getCurrTabIdx()
	return self.curTabIdx
end

function ItemBagModel:setCurrItem(item, noDispath)
	self.curItem = item

	GlobalDispatcher:dispatch(ItemBagModel.UPDATE_SELECT_ITEM)
end

function ItemBagModel:getCurrItem()
	return self.curItem
end

function ItemBagModel:getMaxLvlSSRPetNum()
	local count = 0
	local pets = BagModel.instance:getPets()

	if pets then
		for k, mo in pairs(pets) do
			if mo:isExist() then
				local petCfg = CharacterConfig.instance:getPetCo(mo.raceId)

				if mo.level == petCfg.maxLv and petCfg.rare == MatType.Rare_SSR then
					count = count + 1
				end
			end
		end
	end

	return count
end

function ItemBagModel:getLimitTotalNum(petCount, initCapacity)
	self:getPetStartLine()

	if petCount <= self._petStartLine then
		return initCapacity, 0
	end

	self:getIncrCapacityPetGap()
	self:getGapAddPercent()
	self:getMaxCapacity()

	local addPercent = GameUtil.toInteger((petCount - self._petStartLine) / self._incrCapacityPetGap) * self._gapAddPercent

	return GameUtil.toInteger(math.min(self._maxCapacity, initCapacity * (100 + addPercent) / 100)), addPercent
end

function ItemBagModel:getPetStartLine()
	if self._petStartLine == nil then
		self._petStartLine = checknumber(EquipmentConfig.instance:getCommonValue("MATERIAL_CAPACITY_PET_START_LINE"))
	end

	return self._petStartLine
end

function ItemBagModel:getIncrCapacityPetGap()
	if self._incrCapacityPetGap == nil then
		self._incrCapacityPetGap = checknumber(EquipmentConfig.instance:getCommonValue("MATERIAL_CAPACITY_INCR_PET_GAP"))
	end

	return self._incrCapacityPetGap
end

function ItemBagModel:getGapAddPercent()
	if self._gapAddPercent == nil then
		self._gapAddPercent = checknumber(EquipmentConfig.instance:getCommonValue("MATERIAL_CAPACITY_GAP_ADD_PERCENT"))
	end

	return self._gapAddPercent
end

function ItemBagModel:getMaxCapacity()
	if self._maxCapacity == nil then
		self._maxCapacity = checknumber(EquipmentConfig.instance:getCommonValue("MATERIAL_CAPACITY_MAX_VALUE"))
	end

	return self._maxCapacity
end

ItemBagModel.instance = ItemBagModel.New()

return ItemBagModel
