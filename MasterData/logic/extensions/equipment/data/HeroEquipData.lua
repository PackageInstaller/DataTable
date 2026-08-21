-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/data/HeroEquipData.lua

module("logic.extensions.equipment.data.HeroEquipData", package.seeall)

local M = class("HeroEquipData")

function M:ctor(params)
	self._heroId = params.id

	local heroCfgInfo = params.id and CharacterConfig.instance:getCfgInfoByID(params.id) or false

	self._career = heroCfgInfo and heroCfgInfo.career or 1
	self._equipList = {}
	self._equipAttrList = {}

	self:_initAttrList()
end

function M:getEquipList()
	return self._equipList
end

function M:getEquipByPart(part)
	return self._equipList[part] or false
end

function M:hasEquip()
	return next(self._equipList) ~= nil
end

function M:isAllPartHasEquip()
	for _, part in ipairs(EquipEnum.PartTypeList) do
		if not self._equipList[part] then
			return false
		end
	end

	return true
end

function M:isAnlyPartHasEquip()
	for _, part in ipairs(EquipEnum.PartTypeList) do
		if self._equipList[part] then
			return true
		end
	end

	return false
end

function M:getEquipNum()
	local num = 0

	for _, part in ipairs(EquipEnum.PartTypeList) do
		if self._equipList[part] then
			num = num + 1
		end
	end

	return num
end

function M:isOtherPartHasEquip(partOut)
	for _, part in ipairs(EquipEnum.PartTypeList) do
		if partOut ~= part and not self._equipList[part] then
			return false
		end
	end

	return true
end

function M:refreshEquipByPart(part, equipData)
	self._equipList[part] = equipData
end

function M:getEquipNumBySuitId(suitId)
	local num = 0

	for k, equipData in pairs(self._equipList) do
		if equipData:getSuitId() == suitId then
			num = num + 1
		end
	end

	return num
end

function M:_initAttrList()
	table.insert(self._equipAttrList, {
		attrName = "生命",
		num = 0,
		name = lang("tip_character_life")
	})
	table.insert(self._equipAttrList, {
		attrName = "攻击",
		num = 0,
		name = lang("tip_character_attack")
	})
	table.insert(self._equipAttrList, {
		attrName = "防御",
		num = 0,
		name = lang("tip_character_defense")
	})
	table.insert(self._equipAttrList, {
		attrName = "以太",
		num = 0,
		name = lang("tip_character_yitai")
	})
	table.insert(self._equipAttrList, {
		attrName = "抗性",
		num = 0,
		name = lang("tip_character_resistance")
	})
end

function M:clearAttrList()
	for i, attr in ipairs(self._equipAttrList) do
		attr.num = 0
	end
end

function M:_addAttrByName(name, num)
	for i, attr in ipairs(self._equipAttrList) do
		if attr.attrName == name then
			attr.num = attr.num + num

			return
		end
	end
end

function M:getAllEquipAttr()
	self:clearAttrList()

	for k, equipData in pairs(self._equipList) do
		local equipAttrList = equipData:getAttrList()

		for i, attr in ipairs(equipAttrList) do
			self:_addAttrByName(attr:getName(), attr:getValue())
		end
	end

	return self._equipAttrList
end

function M:getAvailableSuitId()
	local suitMo

	for k, equipData in pairs(self._equipList) do
		local suitId = equipData:getSuitId()

		if not suitMo then
			suitMo = {
				num = 1,
				suitId = suitId
			}
		elseif suitId == suitMo.suitId then
			suitMo.num = suitMo.num + 1
		end
	end

	if suitMo and suitMo.num == EquipEnum.MaxSuitCount then
		return suitMo.suitId
	else
		return false
	end
end

function M:getPreviewSuitId(equip)
	local part = equip:getPart()
	local suitId = equip:getSuitId()
	local suitMo = {
		num = 1,
		suitId = suitId
	}

	for k, equipData in pairs(self._equipList) do
		if k ~= part then
			local suitId = equipData:getSuitId()

			if suitId == suitMo.suitId then
				suitMo.num = suitMo.num + 1
			end
		end
	end

	return suitMo.num == EquipEnum.MaxSuitCount
end

function M:checkForRedPoint()
	for index = 1, EquipEnum.MaxPartType do
		local key = string.format("%s_%s", RedDotType.ERedDotKey.EQUIPMENT, index)
		local isActive = false

		if SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEquip, false) then
			local equip = self:getEquipByPart(index)

			if not equip then
				local equipDataMoList = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.EquipItemType)

				for _, mo in ipairs(equipDataMoList) do
					if not mo:getIsEquip() and mo:getPart() == index then
						isActive = true
					end

					if isActive then
						break
					end
				end
			end
		end

		GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
			key = key,
			isActive = isActive
		})
	end
end

function M:checkForBattleRedPoint()
	local equipDataMoList = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.EquipItemType)

	for index = 1, EquipEnum.MaxPartType do
		local equip = self:getEquipByPart(index)

		if equip then
			if equip:checkForEmptyHoleRedPoint(true) then
				return true
			else
				for _, mo in ipairs(equipDataMoList) do
					if not mo:getIsEquip() and mo:getPart() == index and mo:getSuitId() == equip:getSuitId() and mo:getQuality() > equip:getQuality() then
						return true
					end
				end
			end
		else
			for _, mo in ipairs(equipDataMoList) do
				if not mo:getIsEquip() and mo:getPart() == index then
					return true
				end
			end
		end
	end

	return false
end

function M:getAllDicesAttr()
	local attrs = {}
	local flag = {}

	for k, equipMo in pairs(self._equipList) do
		local list = equipMo:getAllDiceAttr()

		for i = 1, #list do
			local diceAttrMO = list[i]
			local attrId = diceAttrMO:getAttrId()

			if flag[attrId] then
				flag[attrId]:AddDiceAttrMO(diceAttrMO)
			else
				flag[attrId] = DiceAttrMOTotal.New(diceAttrMO)

				table.insert(attrs, flag[attrId])
			end
		end
	end

	return attrs
end

return M
