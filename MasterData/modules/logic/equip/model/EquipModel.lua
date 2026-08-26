-- chunkname: @modules/logic/equip/model/EquipModel.lua

module("modules.logic.equip.model.EquipModel", package.seeall)

local EquipModel = class("EquipModel", BaseModel)

function EquipModel:onInit()
	self.strengthenPrompt = nil
	self._equipQualityDic = {}
end

function EquipModel:reInit()
	self._equipList = nil
	self._equipDic = nil
	self._equipQualityDic = {}
	self.strengthenPrompt = nil
end

function EquipModel:getEquips()
	return self._equipList
end

function EquipModel:getEquip(uid)
	return uid and self._equipDic[uid]
end

function EquipModel:haveEquip(id)
	return self._equipQualityDic[id] and self._equipQualityDic[id] > 0
end

function EquipModel:getEquipQuantity(id)
	return self._equipQualityDic[id] or 0
end

function EquipModel:addEquips(value)
	self._equipList = self._equipList or {}
	self._equipDic = self._equipDic or {}

	for _, v in ipairs(value) do
		local equipMO = self._equipDic[v.uid]
		local isNewEquip = false

		if not equipMO then
			equipMO = EquipMO.New()

			table.insert(self._equipList, equipMO)

			self._equipDic[v.uid] = equipMO
			isNewEquip = true
		end

		equipMO:init(v)

		if not equipMO.config then
			logError("equipId " .. equipMO.equipId .. " not found config")
		else
			self._equipQualityDic[equipMO.config.id] = self._equipQualityDic[equipMO.config.id] or 0

			if equipMO.config.isExpEquip == 1 then
				self._equipQualityDic[equipMO.config.id] = equipMO.count
			elseif isNewEquip then
				self._equipQualityDic[equipMO.config.id] = self._equipQualityDic[equipMO.config.id] + 1
			end
		end
	end

	EquipController.instance:dispatchEvent(EquipEvent.onUpdateEquip)
end

function EquipModel:removeEquips(uids)
	for _, id in ipairs(uids) do
		local equipMO = self._equipDic[id]

		self._equipQualityDic[equipMO.config.id] = equipMO.config.isExpEquip == 1 and 0 or self._equipQualityDic[equipMO.config.id] - 1
		self._equipDic[id] = nil
	end

	local index = 1
	local count = #self._equipList

	for k, v in pairs(self._equipDic) do
		self._equipList[index] = v
		index = index + 1
	end

	for i = index, count do
		self._equipList[i] = nil
	end

	EquipController.instance:dispatchEvent(EquipEvent.onDeleteEquip, uids)
end

function EquipModel.canShowVfx(config)
	return config ~= nil and config.rare >= 4
end

function EquipModel:isLimit(id)
	local equipCfg = EquipConfig.instance:getEquipCo(id)

	return equipCfg.upperLimit >= 1
end

function EquipModel:isLimitAndAlreadyHas(id)
	local equipCfg = EquipConfig.instance:getEquipCo(id)

	if equipCfg.upperLimit == 0 then
		return false
	end

	local hasEquipNum = self:getEquipQuantity(id)

	return hasEquipNum >= equipCfg.upperLimit
end

function EquipModel:isActivateTwinssychubeEquip(heroMo, equipMo)
	if not heroMo then
		return
	end

	if not equipMo then
		equipMo = heroMo:getTrialEquipMo() or self:getEquip(heroMo.defaultEquipUid)

		if not equipMo then
			return
		end
	end

	if heroMo.heroId ~= CharacterEnum.TwinssychubeHeroId then
		return
	end

	local otherEquipId = self:getOtherTwinssychubeEquipId(equipMo.equipId)

	if self:getTwinssychubeEquipMo(otherEquipId) then
		return true
	end
end

function EquipModel:getTwinssychubeEquipMo(id)
	local mos = self:getEquips()

	if mos then
		for _, mo in ipairs(mos) do
			if mo.equipId == id then
				return mo
			end
		end
	end
end

function EquipModel:getOtherTwinssychubeEquipId(id)
	if id == CharacterEnum.TwinssychubeEquip[1] then
		return CharacterEnum.TwinssychubeEquip[2]
	end

	if id == CharacterEnum.TwinssychubeEquip[2] then
		return CharacterEnum.TwinssychubeEquip[1]
	end
end

function EquipModel:refreshShowActivateDoubleTip()
	local heroId = CharacterEnum.TwinssychubeHeroId
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if heroMo and not self:isShowActivateDoubleTip() and not self:isActivateTwinssychubeEquip(heroMo) then
		self:setShowActivateDoubleTip(true)
		self:setPlayDoubleUnlockAnim(true)
	end
end

function EquipModel:isShowActivateDoubleTip()
	local heroId = CharacterEnum.TwinssychubeHeroId
	local heroMo = HeroModel.instance:getByHeroId(heroId)
	local isShowTip = GameUtil.playerPrefsGetNumberByUserId("ShowActivateDoubleTip_" .. heroId, 0) == 0

	return isShowTip and heroMo and self:isActivateTwinssychubeEquip(heroMo)
end

function EquipModel:setShowActivateDoubleTip(isShow)
	local heroId = CharacterEnum.TwinssychubeHeroId

	GameUtil.playerPrefsSetNumberByUserId("ShowActivateDoubleTip_" .. heroId, isShow and 0 or 1)
end

function EquipModel:isPlayDoubleUnlockAnim()
	local heroId = CharacterEnum.TwinssychubeHeroId
	local heroMo = HeroModel.instance:getByHeroId(heroId)
	local isShowTip = GameUtil.playerPrefsGetNumberByUserId("PlayDoubleUnlockAnim_" .. heroId, 0) == 0

	return isShowTip and heroMo and self:isActivateTwinssychubeEquip(heroMo)
end

function EquipModel:setPlayDoubleUnlockAnim(isShow)
	local heroId = CharacterEnum.TwinssychubeHeroId

	GameUtil.playerPrefsSetNumberByUserId("PlayDoubleUnlockAnim_" .. heroId, isShow and 0 or 1)
end

EquipModel.instance = EquipModel.New()

return EquipModel
