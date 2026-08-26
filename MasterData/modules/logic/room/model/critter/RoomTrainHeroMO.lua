-- chunkname: @modules/logic/room/model/critter/RoomTrainHeroMO.lua

module("modules.logic.room.model.critter.RoomTrainHeroMO", package.seeall)

local RoomTrainHeroMO = pureTable("RoomTrainHeroMO")

function RoomTrainHeroMO:init(info)
	local heroMO = HeroModel.instance:getByHeroId(info.heroId)

	self:initHeroMO(heroMO)
end

function RoomTrainHeroMO:initHeroMO(heroMO)
	self.id = heroMO.heroId
	self.heroId = self.id
	self.heroMO = heroMO
	self.skinId = self.heroMO.skin
	self.heroConfig = HeroConfig.instance:getHeroCO(self.heroId)
	self.skinConfig = SkinConfig.instance:getSkinCo(self.skinId)
	self.critterHeroConfig = CritterConfig.instance:getCritterHeroPreferenceCfg(self.heroId)
	self._prefernectType = nil
	self._prefernectValueNums = nil

	local attrInfoMO = self:getAttributeInfoMO()

	if self.critterHeroConfig then
		self._prefernectType = self.critterHeroConfig.preferenceType

		attrInfoMO:setAttr(self.critterHeroConfig.effectAttribute, 0)

		attrInfoMO.rate = self.critterHeroConfig.addIncrRate + 10000

		if not string.nilorempty(self.critterHeroConfig.preferenceValue) then
			self._prefernectValueNums = string.splitToNumber(self.critterHeroConfig.preferenceValue, "#")
		end
	end
end

function RoomTrainHeroMO:updateSkinId(skinId)
	self.skinId = skinId
	self.skinConfig = SkinConfig.instance:getSkinCo(self.skinId)
end

function RoomTrainHeroMO:getAttributeInfoMO()
	if not self._attributeInfoMO then
		self._attributeInfoMO = CritterAttributeInfoMO.New()

		self._attributeInfoMO:init()
	end

	return self._attributeInfoMO
end

function RoomTrainHeroMO:getPrefernectType()
	return self._prefernectType
end

function RoomTrainHeroMO:getPrefernectIds()
	return self._prefernectValueNums
end

function RoomTrainHeroMO:chcekPrefernectCritterId(critterId)
	if self._prefernectType == CritterEnum.PreferenceType.All then
		return true
	end

	if self._prefernectType == CritterEnum.PreferenceType.Catalogue then
		local tCritterConfig = CritterConfig.instance
		local catalogueId = tCritterConfig:getCritterCatalogue(critterId)

		for i = 1, #self._prefernectValueNums do
			local parentId = self._prefernectValueNums[i]

			if parentId == catalogueId or tCritterConfig:isHasCatalogueChildId(parentId, catalogueId) then
				return true
			end
		end
	elseif self._prefernectType == CritterEnum.PreferenceType.Critter and tabletool.indexOf(self._prefernectValueNums, critterId) then
		return true
	end

	return false
end

function RoomTrainHeroMO:getPrefernectName()
	if self._prefernectType == CritterEnum.PreferenceType.All then
		return luaLang("critter_train_hero_prefernect_all_txt")
	elseif self._prefernectType == CritterEnum.PreferenceType.Catalogue then
		if self._prefernectValueNums and #self._prefernectValueNums > 0 then
			local cfg = CritterConfig.instance:getCritterCatalogueCfg(self._prefernectValueNums[1])

			return (cfg or nil) and (cfg.name or self._prefernectValueNums[1])
		end
	elseif self._prefernectType == CritterEnum.PreferenceType.Critter and self._prefernectValueNums and #self._prefernectValueNums > 0 then
		local cfg = CritterConfig.instance:getCritterCfg(self._prefernectValueNums[1])

		return (cfg or nil) and (cfg.name or self._prefernectValueNums[1])
	end

	return ""
end

return RoomTrainHeroMO
