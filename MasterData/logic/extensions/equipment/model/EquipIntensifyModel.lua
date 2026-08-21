-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/model/EquipIntensifyModel.lua

module("logic.extensions.equipment.model.EquipIntensifyModel", package.seeall)

local M = class("EquipIntensifyModel", BaseModel)

function M:onInit()
	self:onReset()
end

function M:onReset()
	return
end

function M:setTimingJumpHoleInde(holeInde)
	self._jumpTimingHoleIndex = holeInde
end

function M:getTimingJumpHoleInde()
	return self._jumpTimingHoleIndex
end

function M:clearTimingJumpHoleInde()
	self._jumpTimingHoleIndex = -1
end

function M:setJumpToD6()
	self._jumpToGetD6 = true
end

function M:getIsJumpToD6()
	local isJump = self._jumpToGetD6

	self._jumpToGetD6 = false

	return isJump
end

function M:setTuoweiPos(hole, pos)
	self._tuoweiTargetPos[hole] = pos
end

function M:getTuoweiPos()
	return self._tuoweiTargetPos[self._operatingHoleIndex]
end

function M:setOperatingEquip(equipMo)
	self._operatingEquip = equipMo
	self._equipBeforeUpdate = clone(equipMo)
end

function M:getOperatingEquip()
	return self._operatingEquip
end

function M:isOperatingEquip(equipUuid)
	return self._operatingEquip and equipUuid == self._operatingEquip:getUuid()
end

function M:getEquipBeforeUpdate()
	return self._equipBeforeUpdate
end

function M:backupsEquip()
	if not self._operatingEquip then
		return
	end

	self._equipBeforeUpdate = clone(self._operatingEquip)
end

function M:getIntensityItemId()
	return self._lvItemId
end

function M:getTimingItemId()
	return self._timingItemId
end

function M:isNeedPlayTimingAni()
	return self._isPlayTimingAni
end

function M:setNeedPlayTimingAni(need)
	self._isPlayTimingAni = need
end

function M:setTimingHoleIndex(index)
	self._operatingHoleIndex = index
end

function M:clearTimingHoleIndex()
	self._operatingHoleIndex = false
end

function M:getTimingHoleIndex()
	return self._operatingHoleIndex
end

function M:getMaxTimingTimes()
	local quality = self._operatingEquip:getQuality()
	local cfg = EquipmentConfig.instance:getConfigByKey(ConfigName.EquipmentQuality, quality)

	return cfg and cfg.reRollLimit or 0
end

function M:getLvConsumeInfo(lvUp)
	if lvUp <= 0 then
		return 0, 0, 0
	end

	local equip = self._operatingEquip
	local lv = equip:getLevel()
	local needExp = -equip:getCurrentExp()

	for i = 0, lvUp - 1 do
		needExp = needExp + equip:getLevelUpNeedExp(lv + i)
	end

	local needItemCount = math.ceil(needExp / self._expPerLvItem)
	local needCurrency = math.ceil(self._currencyPerExp * needItemCount * self._expPerLvItem)

	return needItemCount, needCurrency, math.ceil(needExp)
end

function M:getEquipLvConsumeInfo(equip, lvUp)
	if lvUp <= 0 then
		return 0, 0, 0
	end

	local lv = equip:getLevel()
	local needExp = -equip:getCurrentExp()

	for i = 0, lvUp - 1 do
		needExp = needExp + equip:getLevelUpNeedExp(lv + i)
	end

	local needItemCount = math.ceil(needExp / self._expPerLvItem)
	local needCurrency = math.ceil(self._currencyPerExp * needItemCount * self._expPerLvItem)

	return needItemCount, needCurrency
end

function M:isEquipCanLvUpAnyMore(equip, lvup)
	if not equip or equip:isMaxLv() then
		return false
	end

	local itemHas = ItemModel.instance:getItemCountByItemId(self._lvItemId)
	local goldHas = ItemModel.instance:getItemCountByItemId(GameEnum.CurrencyCodeEnum.LzbCode)
	local itemNeed, goldNeed = EquipIntensifyModel.instance:getEquipLvConsumeInfo(equip, lvup or 1)

	return itemNeed <= itemHas and goldNeed <= goldHas
end

function M:getEquipLvUpNum(equip, itemHas, goldHas)
	local exp = self._expPerLvItem * itemHas
	local currecy = exp * self._currencyPerExp

	if goldHas < currecy then
		exp = math.ceil(goldHas / self._currencyPerExp)
	end

	local lvCanUp = equip:getUpgradeLevel(exp)

	return lvCanUp - equip:getLevel()
end

function M:getAllPartD6Item(part)
	local moList = {}
	local allD6 = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.DiceItem)

	for _, mo in ipairs(allD6) do
		if mo:getPart() == part then
			table.insert(moList, mo)
		end
	end

	return moList
end

function M:getAllTimingD6Item()
	local allD6 = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.DiceItem)
	local moList = self._filterCfg:doFilter(allD6)

	return moList
end

function M:setTimingD6Part(part)
	self._filterCfg:setSimplePartFilter(MultipleEnumUtil.getOneMultipleValue(part))
end

function M:clearTimingFilter()
	self._filterCfg:reset()
end

function M:getFilterCfg()
	return self._filterCfg
end

function M:genEquipHoleAttrMo(equipMo, holeIndex)
	local equipHoleAttrMo = {
		desc = "",
		status = 0
	}
	local diceAttrMo
	local isHoldUnlock = false

	if holeIndex == 0 then
		isHoldUnlock = equipMo:hasOriginalD6()

		if isHoldUnlock then
			local originD6 = equipMo:getOriginalD6()

			diceAttrMo = originD6:getEffectAttr()
			equipHoleAttrMo.status = EquipEnum.HoleStatus.Unalterable
			equipHoleAttrMo.desc = diceAttrMo:getDesc()
		else
			equipHoleAttrMo.status = EquipEnum.HoleStatus.Seal
			equipHoleAttrMo.desc = ""
		end
	else
		isHoldUnlock = equipMo:getIsHoleUnlock(holeIndex)

		if isHoldUnlock then
			local fixedD6Mo = equipMo:getFixedD6ByHoleIndex(holeIndex)

			if fixedD6Mo then
				diceAttrMo = fixedD6Mo:getEffectAttr()
				equipHoleAttrMo.status = EquipEnum.HoleStatus.Unlock
				equipHoleAttrMo.desc = diceAttrMo:getDesc()
			else
				equipHoleAttrMo.status = EquipEnum.HoleStatus.NoCalibration
				equipHoleAttrMo.desc = lang("tip_to_be_embedded")
			end
		else
			local list = EquipmentConfig.instance:getConstNumList("DiceOpenLevels")
			local unlockLevel = list[holeIndex]

			if unlockLevel > equipMo:getMaxLevel() then
				equipHoleAttrMo.status = EquipEnum.HoleStatus.Unalterable
				equipHoleAttrMo.desc = ""
			else
				equipHoleAttrMo.status = EquipEnum.HoleStatus.Lock
				equipHoleAttrMo.desc = string.format(lang("tip_s_unlock"), unlockLevel)
			end
		end
	end

	return equipHoleAttrMo
end

function M:isD6Open()
	return SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.EquipD6, false)
end

function M:clear()
	self._isPlayTimingAni = false
	self._operatingHoleIndex = false
end

M.instance = M.New()

return M
