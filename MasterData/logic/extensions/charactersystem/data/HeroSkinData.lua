-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/data/HeroSkinData.lua

module("logic.extensions.charactersystem.data.HeroSkinData", package.seeall)

local M = class("HeroSkinData")

function M:ctor()
	self._id = false
	self._heroId = false
	self._isOnline = false
	self._name = false
	self._desc = false
	self._modelId = false
	self._getWayDes = false
	self._skillEffect = false
	self._quality = false
	self._getWays = false
	self._skinLabels = false
	self._icon = false
	self._isUnlock = false
	self._isWear = false
	self._isSelected = false
	self._isDefault = false
	self._levelId = false
end

function M:initByAgent()
	self._isUnlock = true
end

function M:initByCharacterConfig(skin)
	self._id = HeroSkinEnum.DefaultSkin
	self._heroId = skin.id
	self._isOnline = 1
	self._name = lang("tip_battle_cloth")
	self._getWayDes = lang("tip_default_get_way")
	self._desc = lang("tip_frequently_cloth")
	self._modelId = skin.modelId or 0
	self._skillEffect = false
	self._isShowBag = 1
	self._quality = GameEnum.QualityEnum.D
	self._icon = false
	self._expireTime = 0
	self._isDefault = true
	self._isUnlock = true
	self._levelId = false
end

function M:initByConfig(skin)
	self._id = skin.id
	self._heroId = skin.heroId
	self._isOnline = skin.isShowBag
	self._name = skin.name
	self._getWayDes = skin.getWay
	self._desc = skin.desc
	self._modelId = skin.module or 0
	self._skillEffect = skin.skillEffect
	self._isShowBag = skin.isShowBag
	self._quality = skin.quality
	self._getWays = skin.getWays
	self._skinLabels = skin.skinLabels
	self._icon = skin.icon
	self._expireTime = 0
	self._isDefault = false
	self._isUnlock = false
	self._levelId = skin.levelId
end

function M:getId()
	return self._id
end

function M:getHeroId()
	return self._heroId
end

function M:getIsOnline()
	return self._isOnline == 1
end

function M:getName()
	return self._name
end

function M:getWayDesc()
	return self._getWayDes
end

function M:getDesc()
	return self._desc
end

function M:getModelId()
	return self._modelId
end

function M:changeModelId(modelId)
	self._modelId = modelId
end

function M:getIsDefault()
	return self._isDefault
end

function M:getIsUnlock()
	return self._isUnlock
end

function M:getIsBuy()
	return self._isUnlock
end

function M:setIsUnlock(isUnlock)
	self._isUnlock = isUnlock
end

function M:getIsWear()
	return self._isWear
end

function M:setIsWear(isWear)
	self._isWear = isWear
end

function M:getIsSelected()
	return self._isSelected
end

function M:setIsSelected(isSelected)
	self._isSelected = isSelected
end

function M:getSkillEffect()
	return self._skillEffect
end

function M:getIsOnMallTable()
	return self._isOnMallTable
end

function M:getEffectDes()
	if self:isHaveEffect() == false then
		return string.format(lang("tip_change_clothes_attribute"), lang("tip_common_none"))
	end

	if self._effectType == 12 or self._effectType == 17 then
		local value = false

		if self._effectMode == 1 then
			value = string.format("%s", self._effectValue * 100)
		else
			value = string.format("%s", self._effectValue)
		end

		nowStr = string.gsub(self._effectFormulaDes, "X", string.format("%.2f", math.abs(value)))
	elseif self._effectType == 13 or self._effectType == 14 then
		local value = false

		if self._effectMode == 1 then
			value = string.format("%s", self._effectValue * 100)
		else
			value = string.format("%s", self._effectValue)
		end

		nowStr = string.gsub(self._effectFormulaDes, "X", string.format("%d", math.abs(value)))
	else
		local isFloat = false

		for i, v in ipairs(TipsHelper.floatEquipMagicAttrType) do
			if v == self._effectType then
				isFloat = true
			end
		end

		if isFloat == true then
			nowStr = string.gsub(self._effectFormulaDes, "X", string.format("%.2f", math.abs(self._effectValue)))
		else
			nowStr = string.gsub(self._effectFormulaDes, "X", string.format("%s", math.abs(self._effectValue)))
		end
	end

	return string.format(lang("tip_change_clothes_attribute"), nowStr)
end

function M:getLabelCO(skinLabelType)
	if self._isDefault then
		return nil
	end

	for _, labelId in ipairs(self._skinLabels) do
		local skinLabelCO = HeroSkinConfig.instance:getSkinLabel(labelId)

		if skinLabelCO.type == skinLabelType then
			return skinLabelCO
		end
	end

	return nil
end

function M:getQuality()
	return self._quality
end

function M:getIsShowBag()
	return self._isShowBag == 1
end

function M:getIcon()
	return self._icon
end

function M:getLevelId()
	return self._levelId
end

function M:isSale()
	local skinGoodsCo = StoreConfig.instance:getSkinGoodsCo(self._id)

	return skinGoodsCo and skinGoodsCo.isOnline or false
end

return M
